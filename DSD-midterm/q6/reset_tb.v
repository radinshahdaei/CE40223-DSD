`include "johnson_counter.v"

module parameter_tb;

parameter CLK_PERIOD    = 10;
parameter SIM_DURATION  = 100;

reg clk     = 0;
reg reset   = 0;

wire [3:0]  q;

johnson_counter #(.N(4)) dut (
    .clk(clk),
    .reset(reset),
    .q(q)
);


always #((CLK_PERIOD / 2)) clk = ~clk;

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, parameter_tb);
    reset = 1;
    #10
    reset = 0;
    #27
    reset = 1;
    #15
    reset = 0;

end

always @(posedge clk) begin
    if ($time >= SIM_DURATION)
        $finish;
end

endmodule
