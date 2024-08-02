module wide_or (
    input wire [31:0] in,
    output wire out
);

    assign out = |in;

endmodule