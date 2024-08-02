`include "priority_encoder.v"

module testbench();
    reg [3:0] I;
    wire [1:0] O;
    wire v;

    priority_encoder encoder(
        .I(I),
        .O(O),
        .v(v)
    );

    initial 
        I = 0;
    always 
        #5 I = I + 1;
    
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #80;
        $stop;
    end

    initial
        $monitor("I = %4b, O = %2b v = %b", I, O, v);

endmodule