import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_adder(dut):
    """Test the 8-bit adder."""
    for a in range(256):
        for b in range(256):
            dut.ui_in.value = a
            dut.uio_in.value = b
            await Timer(2, units='ns')
            assert dut.uo_out.value == (a + b) % 256, f"Adder failed for {a} + {b} = {dut.uo_out.value}"
