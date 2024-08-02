`define width 8
`include "mult.v"


module testbench();
    parameter width = `width;
    reg signed [width - 1 : 0] x, y;
    wire signed [2 * width - 1 : 0] p;
    mult multiplier(p, x, y);

    initial begin
        x = 2;
        y = 5;
        #10;
        $display("x = %d, y = %d, p = %d", x, y, p);

        x = 3;
        y = -17;
        #10;
        $display("x = %d, y = %d, p = %d", x, y, p);

        x = 23;
        y = -1;
        #10;
        $display("x = %d, y = %d, p = %d", x, y, p);

        x = 12;
        y = 12;
        #10;
        $display("x = %d, y = %d, p = %d", x, y, p);

        x = 0;
        y = 1;
        #10;
        $display("x = %d, y = %d, p = %d", x, y, p);
        $stop;
    end

    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars;
    end

endmodule
