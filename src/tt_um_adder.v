/*
 * 8-bit Adder for TinyTapeout
 */

`default_nettype none

module tt_um_adder (
    input  wire [7:0] ui_in,    // First 8-bit input
    output wire [7:0] uo_out,   // 8-bit output (Sum)
    input  wire [7:0] uio_in,   // Second 8-bit input
    output wire [7:0] uio_out,  // Unused
    output wire [7:0] uio_oe,   // Unused
    input  wire       ena,      // Enable (not used)
    input  wire       clk,      // Clock (not needed for combinational logic)
    input  wire       rst_n     // Reset (not needed for combinational logic)
);

    // 8-bit addition operation
    assign uo_out = ui_in + uio_in;

    // Unused signals
    assign uio_out = 8'b00000000;
    assign uio_oe = 8'b00000000;

    // Prevent unused warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
