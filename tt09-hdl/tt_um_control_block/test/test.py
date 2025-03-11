# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge, RisingEdge

CLOCK_PERIOD = 10  # 100 MHz
CLOCK_UNITS = "ns"

def get_control_signals(dut):
    return (dut.uo_out.value.integer << 8) | (dut.uio_out.value.integer)

def get_stage(dut):
    try:
        return dut.uut.stage.value.integer
    except AttributeError:
        stage = 0
        for i in range(3):
            stage += (dut.uut._id(f"\\stage[{i}]", extended=False).value) << i
        return stage

async def init(dut):
    clock = Clock(dut.clk, CLOCK_PERIOD, units=CLOCK_UNITS)
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 11)
    dut.rst_n.value = 1

@cocotb.test()
async def test_HLT(dut):
    await init(dut)
    dut.ui_in.value = 0x00

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x8FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x7
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x8FE3

    await ClockCycles(dut.clk, 10)
    assert get_stage(dut) == 0x7
    assert get_control_signals(dut) == 0x8FE3

@cocotb.test()
async def test_NOP(dut):
    await init(dut)
    dut.ui_in.value = 0x01

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_ADD(dut):
    await init(dut)
    dut.ui_in.value = 0x02

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x07A3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0DE1

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FC7

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_SUB(dut):
    await init(dut)
    dut.ui_in.value = 0x03

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x07A3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0DE1

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FCF

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_LDA(dut):
    await init(dut)
    dut.ui_in.value = 0x04

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x07A3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0DC3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_OUT(dut):
    await init(dut)
    dut.ui_in.value = 0x05

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FF2

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_STA(dut):
    await init(dut)
    dut.ui_in.value = 0x06

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x07A3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0BF3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0EE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

@cocotb.test()
async def test_JMP(dut):
    await init(dut)
    dut.ui_in.value = 0x07

    await ClockCycles(dut.clk, 1)

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x0
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x27E3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x1
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x4FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x2
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0D63

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x3
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x1FA3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x4
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x5
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3

    await FallingEdge(dut.clk)
    assert get_stage(dut) == 0x6
    await RisingEdge(dut.clk)
    assert get_control_signals(dut) == 0x0FE3
