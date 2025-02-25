`timescale 1ns / 1ps

module tb;
    reg [7:0] A, B;
    wire [7:0] C;

    // Instantiate the adder module
    tt_um_adder uut (
        .ui_in(A),
        .uo_out(C),
        .uio_in(B),
        .uio_out(),
        .uio_oe(),
        .ena(1'b1),
        .clk(1'b0),
        .rst_n(1'b1)
    );

    initial begin
        // Test Case 1: 0 + 0
        A = 8'b00000000; B = 8'b00000000;
        #10;
        
        // Test Case 2: 5 + 10
        A = 8'b00000101; B = 8'b00001010;
        #10;
        
        // Test Case 3: 100 + 50
        A = 8'b01100100; B = 8'b00110010;
        #10;
        
        // Test Case 4: 255 + 1 (overflow)
        A = 8'b11111111; B = 8'b00000001;
        #10;

        // Test Case 5: 128 + 128 (overflow)
        A = 8'b10000000; B = 8'b10000000;
        #10;
        
        $finish;
    end
endmodule
