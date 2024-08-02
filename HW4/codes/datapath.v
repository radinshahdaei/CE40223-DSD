`include "adder32.v"
`include "comparator32.v"
`include "dff.v"
`include "mux32.v"
`include "reg32.v"
`include "wide_or.v"
`include "control_unit.v"

module datapath(
    input clk,
    input start,
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    output out_r,
    output [31:0] out
);

wire dec_r1, reset_r3;
wire [31:0] R1, R2, R3, R4;
wire [31:0] out_mux_r1, out_mux_r2, out_mux_r4, out_adder;

reg32 reg_r1 (clk, 1'b0, 1'b0, dec_r1, out_mux_r1, R1);
reg32 reg_r2 (clk, 1'b0, 1'b0, 1'b0, out_mux_r2, R2);
reg32 reg_r3 (clk, reset_r3, 1'b0, 1'b0, out_adder, R3);
reg32 reg_r4 (clk, 1'b0, 1'b0, 1'b0, out_mux_r4, R4);

dff R (clk, 1'b0, in_r, out_r);

mux32 mux_r1 (A, R2, select_mux_r1, out_mux_r1);
mux32 mux_r2 (B, R1, select_mux_r2, out_mux_r2);
mux32 mux_r4 (C, R3, select_mux_r4, out_mux_r4);

adder32 adder (R2, R3, out_adder, cout);

comparator32 cmp1 (R1, R2, cmp1_gt, cmp1_e1, cmp1_lt);
comparator32 cmp2 (R3, R4, cmp2_gt, cmp2_e1, cmp2_lt);

wide_or or1 (R1, or_out);

control_unit cu (clk, start, or_out, cmp1_lt, cmp2_gt, 
in_r, dec_r1, reset_r3, select_mux_r1, select_mux_r2, select_mux_r1);

assign out = R4;

endmodule