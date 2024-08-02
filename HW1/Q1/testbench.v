`include "johnson_counter.v"

module testbench;
    reg CLK, SET, CLR;
    wire [3:0] q;

    johnson_counter counter(CLK, SET, CLR, q);

    initial 
        CLK = 0;
    always 
        #5 CLK = ~CLK;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            SET = 1; CLR = 1;
        #10 SET = 0; CLR = 0;
        #10 SET = 0; CLR = 1;
        #10 SET = 1; CLR = 0;
        #10 SET = 1; CLR = 1;
        #75 $stop; 
        
    end

    initial
        $monitor($time, " q = %4b", q);
    
endmodule