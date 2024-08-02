`include "d_flip_flop.v"

module johnson_counter #(
    parameter N = 4
) (
    input clk,
    input reset,
    output [N-1:0] q
);

genvar i;
generate
    for (i = 0; i < N; i=i+1) begin : dff_loop
        d_flip_flop dff (
            .d(i == 0 ? ~q[N-1] : q[i-1]),
            .clk(clk),
            .reset(reset),
            .q(q[i])
        );
    end
endgenerate

endmodule
