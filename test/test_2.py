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

    # Test case a: In[15:0] = 0010 1010 1111 0001, expected C[7:0] = 0000 1011 (13)
    dut.ui_in.value = 0x2A  # 0010 1010
    dut.uio_in.value = 0xF1  # 1111 0001
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x0D, f"Test case a failed: got {dut.uo_out.value}" 

    # Test case b: In[15:0] = 0000 0000 0000 0001, expected C[7:0] = 0000 0000 (0)
    dut.ui_in.value = 0x00
    dut.uio_in.value = 0x01
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x00, f"Test case b failed: got {dut.uo_out.value}"

    # Test case c: In[15:0] = 0000 0000 0000 0000, expected C[7:0] = 1111 0000
    dut.ui_in.value = 0x00
    dut.uio_in.value = 0x00
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0xF0, f"Test case c failed: got {dut.uo_out.value}"
