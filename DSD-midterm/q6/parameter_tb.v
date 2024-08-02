`include "johnson_counter.v"

module parameter_tb;

parameter CLK_PERIOD    = 10;
parameter SIM_DURATION  = 1000;

reg clk     = 0;
reg reset   = 0;

wire [3:0]  q1;
wire [7:0]  q2;
wire [15:0] q3;
wire [31:0] q4;

johnson_counter #(.N(4)) dut4 (
    .clk(clk),
    .reset(reset),
    .q(q1)
);

johnson_counter #(.N(8)) dut8 (
    .clk(clk),
    .reset(reset),
    .q(q2)
);

johnson_counter #(.N(16)) dut16 (
    .clk(clk),
    .reset(reset),
    .q(q3)
);

johnson_counter #(.N(32)) dut32 (
    .clk(clk),
    .reset(reset),
    .q(q4)
);

always #((CLK_PERIOD / 2)) clk = ~clk;

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, parameter_tb);
    reset = 1;
    #10
    reset = 0;
end

always @(posedge clk) begin
    $display("q1 = %b, q2 = %b, q3 = %b, q4 = %b", q1 ,q2 ,q3,q4);
    if ($time >= SIM_DURATION)
        $finish;
end

endmodule
