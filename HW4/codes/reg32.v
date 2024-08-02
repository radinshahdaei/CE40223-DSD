module reg32 (
    input wire clk,
    input wire reset,
    input wire inc,
    input wire dec,
    input wire [31:0] d,
    output reg [31:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'b0;
        end else begin
            if (inc) begin
                q <= q + 1;
            end else if (dec) begin
                q <= q - 1;
            end else begin
                q <= d;
            end
        end
    end

endmodule
