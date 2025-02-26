/*
 * Copyright (c) 2025 Yijia Cao
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire [15:0] In;      // Concatenated input
    assign In = {ui_in, uio_in};  // In[15:0] = {A[7:0], B[7:0]}

    always @(*) begin
        casez (In)  
            16'b1???????????????: uo_out = 8'd15;
            16'b01??????????????: uo_out = 8'd14;
            16'b001?????????????: uo_out = 8'd13;
            16'b0001????????????: uo_out = 8'd12;
            16'b00001???????????: uo_out = 8'd11;
            16'b000001??????????: uo_out = 8'd10;
            16'b0000001?????????: uo_out = 8'd9;
            16'b00000001????????: uo_out = 8'd8;
            16'b000000001???????: uo_out = 8'd7;
            16'b0000000001??????: uo_out = 8'd6;
            16'b00000000001?????: uo_out = 8'd5;
            16'b000000000001????: uo_out = 8'd4;
            16'b0000000000001???: uo_out = 8'd3;
            16'b00000000000001??: uo_out = 8'd2;
            16'b000000000000001?: uo_out = 8'd1;
            16'b0000000000000001: uo_out = 8'd0;
            16'b0000000000000000: uo_out = 8'b11110000; // Special case
            default: uo_out = 8'b00000000;
        endcase
    end
endmodule
