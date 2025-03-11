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
    #dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")
    # increment minutes by two
    for _ in range(59):
        # Set the input values you want to test
        dut.ui_in.value = 1 #increment hours and minutes once
        # Wait for ~4ms clock cycle to see the output values
        await ClockCycles(dut.clk, 330)
        dut.ui_in.value = 0 #deassert pushbuttons
        # Wait for ~4ms clock cycle to see the output values
        await ClockCycles(dut.clk, 330)
    
    # increment hours by 4
    for _ in range(23):
        # Set the input values you want to test
        dut.ui_in.value = 2 #increment hours and minutes once
        # Wait for one clock cycle to see the output values
        await ClockCycles(dut.clk, 330)
        dut.ui_in.value = 0 #deassert pushbuttons
        # Wait for one clock cycle to see the output values
        await ClockCycles(dut.clk, 330)
    
    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uio_out.value == 31
    assert dut.uo_out.value == 146
    await ClockCycles(dut.clk, 65)
    assert dut.uio_out.value == 62
    assert dut.uo_out.value == 207
    await ClockCycles(dut.clk, 65)
    assert dut.uio_out.value == 61
    assert dut.uo_out.value == 129
    await ClockCycles(dut.clk, 65)
    assert dut.uio_out.value == 59
    assert dut.uo_out.value == 132
    await ClockCycles(dut.clk, 65)
    assert dut.uio_out.value == 55
    assert dut.uo_out.value == 164
    await ClockCycles(dut.clk, 65)
    assert dut.uio_out.value == 47
    assert dut.uo_out.value == 6

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
