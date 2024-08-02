module adder32 (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] sum,
    output wire carry_out
);

    assign {carry_out, sum} = a + b;

endmodule