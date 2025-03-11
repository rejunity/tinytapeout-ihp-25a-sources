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

    # case 0
    dut.ui_in.value = 244
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 60

    # case 1
    dut.ui_in.value = 206
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 168

    # case 2
    dut.ui_in.value = 255
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 225

    # case 3
    dut.ui_in.value = 15
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0

    # case 4
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0

    # case 5
    dut.ui_in.value = 70
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 24

    # case 6
    dut.ui_in.value = 170
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 100

    # case 7
    dut.ui_in.value = 254
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 210

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
