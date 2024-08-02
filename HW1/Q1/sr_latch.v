module sr_latch (
    input CLK, SET, CLR, S, R, 
    output reg Q, Q_not
);

    always @ (posedge CLK or negedge SET or negedge CLR) begin
        if(~SET) begin
            Q <= 1;
            Q_not <= 0;
        end
        else if(~CLR) begin
            Q <= 0;
            Q_not <= 1;
        end
        else if (S && ~R) begin
            Q <= 1;
            Q_not <= 0;
        end
        else if (~S && R) begin
            Q <= 0;
            Q_not <= 1;
        end
        else if(S && R) begin
            Q <= 1'bx;
            Q_not <= 1'bx;
        end
    end

endmodule
