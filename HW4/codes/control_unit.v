module control_unit(
    input clk,
    input start,
    input or_out,
    input cmp1_lt,
    input cmp2_gt,
    output reg in_r,
    output reg dec_r1,
    output reg reset_r3,
    output reg select_mux_r1,
    output reg select_mux_r2,
    output reg select_mux_r4
);

reg [1:0] p_state, n_state;
localparam [1:0] init = 2'b00, cmp = 2'b01, mul = 2'b10;

always @(p_state or start or or_out or cmp1_lt or cmp2_gt) begin: combi
    dec_r1 = 0;
    reset_r3 = 0;
    select_mux_r1 = 0;
    select_mux_r2 = 0;
    select_mux_r4 = 0;

    n_state = init;

    case (p_state)
        init: begin
            if (start) begin
                n_state = cmp;
                in_r = 1'b0;
                select_mux_r1 = 1'b0;
                select_mux_r2 = 1'b0;
                select_mux_r4 = 1'b0;
                reset_r3 = 1'b1;
            end else begin
                n_state = init;
            end
        end

        cmp: begin
            n_state = mul;
            if (!cmp1_lt) begin
                select_mux_r1 = 1;
                select_mux_r2 = 1;
            end
        end

        mul: begin
            if (or_out) begin
                n_state = mul;
                dec_r1 = 1;
            end else begin
                n_state = cmp;
                if (cmp2_gt) begin
                    select_mux_r4 = 0;
                end else begin
                    select_mux_r4 = 1;
                end
            end
        end

        default: n_state = init;
    endcase
end

always @(posedge clk) begin: sequential
    p_state <= n_state;
end

endmodule
