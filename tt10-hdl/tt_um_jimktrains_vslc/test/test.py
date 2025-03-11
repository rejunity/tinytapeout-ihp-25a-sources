# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

SPI_CLOCK_DIV = 2**3;

IO_I = 0
IO_O = 1

INSTR_PUSH = lambda io, reg : 0x00 + (io << 3) + reg
INSTR_POP = lambda reg : 0x18 + reg
INSTR_SET = lambda reg : 0x28 + reg
INSTR_RESET = lambda reg : 0x38 + reg
INSTR_POP_TIMER = 0x10
INSTR_SET_TIMER = 0x20
INSTR_RESET_TIMER = 0x30
INSTR_NOP = 0xff
INSTR_CLR = 0xf0
INSTR_SETALL = 0xf1
INSTR_RISING     = lambda reg : 0b11000000 + reg
INSTR_FALLING    = lambda reg : 0b11010000 + reg
INSTR_SWAP = 0b11110010
INSTR_ROT  = 0b11110011

# ab   = 0001
# ~ab  = 0010 -> NIMPL
# a~b  = 0100 -> NCONV
# ~a~b = 1000 -> NOR

INSTR_AND     = 0b10010001
INSTR_NAND    = 0b10011110
INSTR_OR      = 0b10010111
INSTR_NOR     = 0b10011000
INSTR_XOR     = 0b10010110
INSTR_BICOND  = 0b10011001
INSTR_IMPL    = 0b10011101
INSTR_NIMPL   = 0b10010010
INSTR_CONV    = 0b10011011
INSTR_NCONV   = 0b10010100

INSTR_DUP     = 0b10110101
INSTR_OVER    = 0b10111010
INSTR_DROP    = 0b10011010
INSTR_ZERO    = 0b10110000
INSTR_ONE     = 0b10111111
INSTR_NOT     = 0b10010011
INSTR_OVERNOT = 0b10010101

instr_names = {
INSTR_AND: "INSTR_AND",
INSTR_NAND: "INSTR_NAND",
INSTR_OR: "INSTR_OR",
INSTR_NOR: "INSTR_NOR",
INSTR_XOR: "INSTR_XOR",
INSTR_BICOND: "INSTR_BICOND",
INSTR_IMPL: "INSTR_IMPL",
INSTR_NIMPL: "INSTR_NIMPL",
INSTR_CONV: "INSTR_CONV",
INSTR_NCONV: "INSTR_NCONV",

INSTR_NOT: "INSTR_NOT",
INSTR_DUP: "INSTR_DUP",
INSTR_OVER: "INSTR_OVER",
INSTR_DROP: "INSTR_DROP",
INSTR_OVERNOT: "INSTR_OVERNOT",
INSTR_ZERO: "INSTR_ZERO",
INSTR_ONE: "INSTR_ONE",
}

# These silly little functions just make debugging easier when it's
# just printing the function name.
def assert_timer_high(dut):
    return ((dut.uo_out.value>>(TIMER_OUTPUT)) & 0x1) == 1

def assert_timer_low(dut):
    return ((dut.uo_out.value>>(TIMER_OUTPUT)) & 0x1) == 0

def assert_tos(x):
    def y(dut):
        return dut.tos.value == x
    return y

def assert_tos_t(dut):
    return dut.tos.value == 1

def assert_tos_f(dut):
    return dut.tos.value == 0

def assert_output_1_t(dut):
    return ((dut.uo_out.value[7-1]) & 0x1) == 1

def assert_output_1_f(dut):
    return ((dut.uo_out.value[7-1]) & 0x1) == 0


def generate_test_result(instr, i):
    return (instr >> (3-i)) & 0x1 == True

def generate_test(instr):
    name = instr_names[instr]
    tests = []
    tests.append((f"Clearing stack for " + instr_names[instr], None))
    tests.append((INSTR_CLR, test_stack(0)))
    r = 0
    for i in range(4):
        a = (i & 0b10) >> 1
        b = (i & 0b01)
        atest = assert_tos_t
        if a == 0:
            atest = assert_tos_f
        btest = assert_tos_t
        if b == 0:
            btest = assert_tos_f
        expected_result = generate_test_result(instr, i)
        expected_result_test = assert_tos_t
        if not expected_result:
            expected_result_test = assert_tos_f

        tests.append((instr_names[instr] + f" {i}: tos={b} {a} => {expected_result}", None))
        tests.append((INSTR_PUSH(IO_I, a),atest))
        tests.append((INSTR_PUSH(IO_I, b),btest))
        tests.append((instr, expected_result_test))

        r <<= 1
        r |= a
        r <<= 1
        r |= b


        if (instr & 0b00110000) == 16:
            r >>= 2
        elif (instr & 0b00110000) == 0:
            r >>= 1
        r <<= 1
        r |= expected_result
        r &= 0xff
        tests.append((f"Testing stack={r:08b}", None))
        tests.append((INSTR_NOP, test_stack(r)))
    return tests


def generate_timer_test():
    return []
    return [
        ("Timer Test", None),
        push_true,
        ("Enable Timer", None),
        (INSTR_SET_TIMER,    None ),
        ("Check High", None),
        (INSTR_NOP,          None ),
        (INSTR_NOP, assert_timer_high),
        ("Check Low", None),
        (INSTR_NOP, assert_timer_low),
        ("Disable Timer", None),
        push_false,
        (INSTR_POP_TIMER,    None ),
        (INSTR_NOP,          None ),
        ("Check Low 1", None),
        (INSTR_NOP, assert_timer_low),
        ("Check Low 2", None),
        (INSTR_NOP, assert_timer_low),
        ("Check Low 3", None),
        (INSTR_NOP, assert_timer_low),
        (INSTR_NOP,          None ),
    ]


EEPROM_READ_COMMAND = 0x03;

EEPROM_CS = 0;
EEPROM_COPI = 1;
EEPROM_CIPO = 2;

TIMER_OUTPUT = 7;


msg = lambda m : (m, None)

def test_stack(expected):
    def y(dut):
        if dut.stack.value[0:7] != expected:
            dut._log.info(f"{dut.stack.value=}")
            dut._log.info(f"expected stack={expected:08b}")
            return False
        return True
    return y

def pop_test(expected):
    test_fn = assert_output_1_t;
    if not expected:
        test_fn = assert_output_1_f
    return (INSTR_POP(1), test_fn)

def set_test(expected):
    test_fn = assert_output_1_t;
    if not expected:
        test_fn = assert_output_1_f
    return (INSTR_SET(1), test_fn)

def reset_test(expected):
    test_fn = assert_output_1_t;
    if not expected:
        test_fn = assert_output_1_f
    return (INSTR_RESET(1), test_fn)

push_true = (INSTR_PUSH(IO_I, 1), assert_tos_t)
push_false = (INSTR_PUSH(IO_I, 0), assert_tos_f)

nop = (INSTR_NOP, None )

MEMORY = [
    (0x04, None ),
    (0x00, None ),
    (0xff, None ),
    (0xff, None ),

    msg("Test Push"),
    push_true,
    push_false,
    push_true,
    push_true,
    push_true,
    push_false,
    push_true,
    push_true,
    (INSTR_NOP, test_stack(0b10111011)),

    msg("Test Pop"),
    pop_test(True),
    pop_test(True),
    pop_test(False),
    pop_test(True),
    pop_test(True),
    pop_test(True),
    pop_test(False),
    pop_test(True),

    msg("Clear Test"),
    (INSTR_CLR, assert_tos_f),
    (INSTR_NOP, test_stack(0b00000000)),
    msg("SetAll Test"),
    (INSTR_SETALL, assert_tos_t),
    (INSTR_NOP, test_stack(0b11111111)),

    msg("Test Set (0)"),
    # Set the output to the opposite of
    # what it should be at the end
    # of the test if set isn't working/
    # behaving like a push.
    push_true,
    pop_test(True),
    push_false,
    set_test(True),

    msg("Test Set (1)"),
    push_false,
    pop_test(False),
    push_true,
    set_test(True),

    msg("Test Reset (0)"),
    push_true,
    pop_test(True),
    push_false,
    reset_test(True),

    msg("Test Reset (1)"),
    push_true,
    pop_test(True),
    push_true,
    reset_test(False),

    ] + \
    generate_timer_test()

for (instr, mnemonic) in instr_names.items():
    MEMORY += generate_test(instr)

for i in [True, False]:
    for j in [True, False]:
        for k in [True, False]:
            MEMORY.append((INSTR_CLR, None))
            if i:
                MEMORY.append(push_true)
            else:
                MEMORY.append(push_false)

            if j:
                MEMORY.append(push_true)
            else:
                MEMORY.append(push_false)

            if k:
                MEMORY.append(push_true)
            else:
                MEMORY.append(push_false)

            MEMORY.append((f"Testing rot tos={k} {j} {i}", None))
            MEMORY.append((INSTR_ROT, assert_tos(j)))
            r = k
            r <<= 1
            r |= i
            r <<= 1
            r |= j

            MEMORY.append((f"Testing stack={r:08b}", None))
            MEMORY.append((INSTR_NOP, test_stack(r)))

for j in [True, False]:
    for k in [True, False]:
        MEMORY.append((f"Testing SWAP tos={k} {j}", None))
        MEMORY.append((INSTR_CLR, None))
        if j:
            MEMORY.append(push_true)
        else:
            MEMORY.append(push_false)

        if k:
            MEMORY.append(push_true)
        else:
            MEMORY.append(push_false)

        MEMORY.append((INSTR_SWAP, assert_tos(j)))
        r = k
        r <<= 1
        r |= j

        MEMORY.append((f"Testing stack={r:08b}", None))
        MEMORY.append((INSTR_NOP, test_stack(r)))

async def read8(dut):
    r = 0x0
    for i in range(8):
        await ClockCycles(dut.clk, SPI_CLOCK_DIV *1, rising=True)
        r += ((dut.uio_out.value[7-EEPROM_COPI]) & 0x01) << (7-i)
    return r

async def write8(dut, v):
    orig_uio_in = dut.uio_in.value


    y = 1 << EEPROM_CIPO
    for i in range(8):
        x = orig_uio_in & (0xff - y)
        v1 = v & (1<<(7-i))
        v2 = v1 != 0
        v3 = v2 << EEPROM_CIPO
        x |= v3
        # dut.scan_cycle_trigger_in.value =  ((i > 5) and (i < 7))
        dut.uio_in.value = x
        await ClockCycles(dut.clk, SPI_CLOCK_DIV *1, rising=False)

async def do_reset(dut):
    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
    await ClockCycles(dut.clk, SPI_CLOCK_DIV *1)

    # Reset
    dut._log.info(f"{len(MEMORY)=} {SPI_CLOCK_DIV=}")
    dut._log.info("Reset")
    # dut.scan_cycle_trigger_in.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 2
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, SPI_CLOCK_DIV *1)
    dut._log.info(f"{dut.uio_out.value=}")
    #assert dut.uio_out.value[7-EEPROM_CS]
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, SPI_CLOCK_DIV *1)
    dut._log.info(f"Reset Done")
    dut._log.info(f"Reading READ Command")
    assert (await read8(dut)) == EEPROM_READ_COMMAND
    assert not dut.uio_out.value[7-EEPROM_CS]
    dut._log.info(f"Reading Address")
    assert (await read8(dut)) == 0
    assert (await read8(dut)) == 0

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    await do_reset(dut)

    last_a = None
    adj_addr = 0

    for (i,(m,a)) in enumerate(MEMORY):
        if (isinstance(m, str)):
            dut._log.info(f"#### {i=} {m=}")
            continue
        dut._log.info(f"{i=} {adj_addr=} {m=:02x}")
        adj_addr += 1
        await write8(dut, m)
        tos = dut.tos.value
        read_stack = dut.stack.value
        if last_a is not None:
            res = last_a(dut)
            if not res:
                dut._log.info(f"  {read_stack=} {tos=}")
                dut._log.info(f"  {dut.uio_out.value=}")
                dut._log.info(f"  {dut.uo_out.value=}")
                dut._log.info(f"  {last_a=}")
                dut._log.info(f"  last_a(dut)={res}")
                assert res
        last_a = a

    
    # I need to redo the tests for these to use the automatic cycling.
    # for i in range(8):
    #     for j in [1, 0]:
    #         for k in [1, 0]:
    #             expected = ((not j) and k)
    #             dut._log.info(f"#### Testing RISING({i}) {j} to {k} => {expected}")
    #             adj_addr += 1
    #             dut.ui_in.value = (j << i)
    #             await write8(dut, INSTR_NOP)

    #             dut.ui_in.value = (k << i)
    #             m = INSTR_RISING(i)
    #             adj_addr += 1
    #             dut._log.info(f"      {adj_addr=} {m=:02x} {j<<i=} {k<<i=}")
    #             await write8(dut, m)
    #             await write8(dut, INSTR_NOP)
    #             tos = dut.tos.value
    #             if tos != expected:
    #                 dut._log.info(f"      {tos=} {expected=}")
    #             assert tos == expected
    # for i in range(8):
    #     for j in [1, 0]:
    #         for k in [1, 0]:
    #             expected = ((not k) and j)
    #             dut._log.info(f"#### Testing FALLING ({i}) {j} to {k} => {expected}")
    #             adj_addr += 1
    #             dut.ui_in.value = (j << i)
    #             read_stack = await write8(dut, INSTR_NOP)

    #             dut.ui_in.value = (k << i)
    #             m = INSTR_FALLING(i)
    #             adj_addr += 1
    #             dut._log.info(f"      {adj_addr=} {m=:02x} {j<<i=} {k<<i=}")
    #             read_stack = await write8(dut, m)
    #             read_stack = await write8(dut, INSTR_NOP)
    #             tos = dut.tos.value
    #             if tos != expected:
    #                 dut._log.info(f"      {tos=} {expected=}")
    #             assert tos == expected


@cocotb.test()
async def test_addressing(dut):
    dut._log.info("Start, the Second")

    MEMORY = [
        0x00,
        0x05,
        0x00,
        0x06,
        INSTR_ZERO,
        INSTR_POP(0),
        INSTR_ONE,
    ]

    await do_reset(dut)

    await write8(dut, MEMORY[0])
    await write8(dut, MEMORY[1])
    await write8(dut, MEMORY[2])
    await write8(dut, MEMORY[3])
    await write8(dut, MEMORY[4])
    await write8(dut, MEMORY[5])
    await write8(dut, MEMORY[6])
    dut._log.info(f"Got to the end of the program")
    await ClockCycles(dut.clk, SPI_CLOCK_DIV *1)
    assert not dut.uo_out.value[7-0]

    dut._log.info(f"Reading READ Command")
    x = await read8(dut)
    dut._log.info(f"Read {x=:08b}")
    assert x == EEPROM_READ_COMMAND
    assert not dut.uio_out.value[7-EEPROM_CS]
    dut._log.info(f"Reading Address")
    assert (await read8(dut)) == 0
    assert (await read8(dut)) == 5
    dut._log.info(f"verified that it's running where it left of!")
    dut._log.info(f"{MEMORY[5]=:02x}")
    await write8(dut, MEMORY[5])
    dut._log.info(f"{MEMORY[6]=:02x}")
    await write8(dut, MEMORY[6])
    assert dut.uo_out.value[7-0]
