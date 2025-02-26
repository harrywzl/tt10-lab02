module tt_um_equal_comparator(
    input [7:0] A,  // 8-bit input A
    input [7:0] B,  // 8-bit input B
    output [7:0] C  // 8-bit output C
);
    // Equality comparator logic
    assign C = (A == B) ? 8'b00000001 : 8'b00000000;  // C[0] = 1 if A == B, else 0

endmodule
