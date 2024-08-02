module comparator32 (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire gt,
    output wire eq,
    output wire lt
);

    assign gt = (a > b);
    assign eq = (a == b);
    assign lt = (a < b);

endmodule
