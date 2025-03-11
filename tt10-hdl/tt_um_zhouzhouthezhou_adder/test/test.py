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

    # Test 1.1 0 + 0 = 0x3f
    dut.ui_in.value = 0x00
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x3f

    # Test 1.2 1 + 0 = 0x06
    dut.ui_in.value = 0x10
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x06

    # Test 1.3 0 + 1 = 0x06
    dut.ui_in.value = 0x01
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x06

    # Test 1.4 1 + 1 = 0x5b
    dut.ui_in.value = 0x11
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x5b

    # Test 1.5 15 + 15 = 0x80
    dut.ui_in.value = 0xFF
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x80

    # Test 2.1 1 + 1 = 0x5b
    dut.ui_in.value = 0x11
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x5b

    # Test 2.2 1 + 2 = 0x4f
    dut.ui_in.value = 0x12
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x4f

    # Test 2.3 2 + 2 = 0x66
    dut.ui_in.value = 0x22
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x66

    # Test 2.4 3 + 2 = 0x6d
    dut.ui_in.value = 0x32
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x6d

    # Test 2.5 3 + 3 = 0x7d
    dut.ui_in.value = 0x33
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x7d

    # Test 2.6 3 + 4 = 0x07
    dut.ui_in.value = 0x34
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x07

    # Test 2.7 4 + 4 = 0x7f
    dut.ui_in.value = 0x44
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x7f

    # Test 2.8 5 + 4 = 0x67
    dut.ui_in.value = 0x54
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x67

    # Test 2.9 5 + 5 = 0x80
    dut.ui_in.value = 0x55
    await ClockCycles(dut.clk, 2)
    assert dut.uo_out.value == 0x80
