module d_flip_flop (
    input d,
    input clk,
    input reset,
    output reg q
);

always @(posedge clk, posedge reset)
begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
