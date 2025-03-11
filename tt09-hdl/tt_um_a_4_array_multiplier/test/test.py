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

    # Test case 1
    dut.ui_in.value = 0x42
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x08  # Expected product for 0x42 is 0x08

    # Test case 2
    dut.ui_in.value = 0x15
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x05  # Expected product for 0x15 is 0x05
    
    # Test case 3
    dut.ui_in.value = 0x7A
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x46  # Expected product for 0x7A is 0x46
    
    # Test case 4
    dut.ui_in.value = 0xAB
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x6E  # Expected product for 0xAB is 0x6E
    
    # Test case 5
    dut.ui_in.value = 0xFF
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0xE1  # Expected product for 0xFF is 0xE1

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
