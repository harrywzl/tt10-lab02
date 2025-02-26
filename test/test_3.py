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

    dut._log.info("Test equality comparator")

    # Test case 1: Equal inputs (ui_in == uio_in), expected uo_out = 0000 0001
    dut.ui_in.value = 0x55  # Arbitrary test value
    dut.uio_in.value = 0x55  # Same as ui_in
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x01, f"Test case 1 failed: got {dut.uo_out.value}"

    # Test case 2: Unequal inputs (ui_in != uio_in), expected uo_out = 0000 0000
    dut.ui_in.value = 0x55
    dut.uio_in.value = 0xAA  # Different value
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x00, f"Test case 2 failed: got {dut.uo_out.value}"
