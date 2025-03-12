# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1

    dut.tri_oe.value = 0
    dut.wr_en.value = 0
    dut.ram_in.value = 1
    dut.addr.value = 8
    dut.r_wr_en.value = 1

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)

    dut._log.info("Test multiplier")

    dut.rst_n.value = 1
    dut.wr_en.value = 1
    await ClockCycles(dut.clk, 1)

    dut.ram_in.value = 2
    dut.addr.value = 9
    dut.wr_en.value = 1
    await ClockCycles(dut.clk, 1)

    dut.wr_en.value = 0

    for i in range(8):
        dut.addr.value = i
        await ClockCycles(dut.clk, 2)

    dut.r_wr_en.value = 0

    for i in range(8):
        dut.wr_en.value = 0
        dut.addr.value = i
        await ClockCycles(dut.clk, 2)
        if i % 2 == 0:
            assert dut.ram_out.value == 2
        else:
            assert dut.ram_out.value == 0

    dut._log.info("input byte readback")
    dut.addr.value = 8
    await ClockCycles(dut.clk, 2)
    assert dut.ram_out.value == 1

    dut.addr.value = 9
    await ClockCycles(dut.clk, 2)
    assert dut.ram_out.value == 2

    dut._log.info("tristate readback")
    dut.tri_oe.value = 1
    await ClockCycles(dut.clk, 1)

    dut._log.info("end")
    await ClockCycles(dut.clk, 20)
