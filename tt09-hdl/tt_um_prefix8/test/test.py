# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
    max_val = 0xFF
    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
    for a in range(1<<8):
        for b in range(1<<8):
            dut.a.value = a
            dut.b.value = b
            await ClockCycles(dut.clk, 10)

            expected_sum = (a + b) & max_val  # 4-bit sum

            # Check if the results match the expected values
            assert dut.sum.value == expected_sum, f"Test failed with a={a}, b={b}: sum={dut.sum.value}, expected={expected_sum}"

            # Print the test result (optional)
            print(f"PASS: a={a}, b={b} -> sum={dut.sum.value}")