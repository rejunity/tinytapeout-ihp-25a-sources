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
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    #test 1
    dut.ui_in.value = 0b0100_0010
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 8

    #test 2
    dut.ui_in.value = 0b0110_1001
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 54

    #test 3
    dut.ui_in.value = 0b0110_0110
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 36

    #test 4
    dut.ui_in.value = 0b0111_1010
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 70

    #test 5
    dut.ui_in.value = 0b1111_1000
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 120
    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
