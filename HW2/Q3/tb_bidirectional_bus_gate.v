`include "bidirectional_bus_gate.v"

module tb_bidirectional_bus_gate;

// Parameters for the width of the bus
parameter N = 8;

// Test inputs and outputs
reg [N-1:0] data_in_1; // Input data for port 1
reg [N-1:0] data_in_2; // Input data for port 2
reg oe_1; // Output enable for port 1
reg oe_2; // Output enable for port 2
wire [N-1:0] data_out_1; // Output data for port 1
wire [N-1:0] data_out_2; // Output data for port 2
wire [N-1:0] bi_data; // Bidirectional data bus

// Instantiate the bidirectional_bus_gate module
bidirectional_bus_gate #(.N(N)) uut (
    .data_in_1(data_in_1),
    .data_in_2(data_in_2),
    .oe_1(oe_1),
    .oe_2(oe_2),
    .data_out_1(data_out_1),
    .data_out_2(data_out_2),
    .bi_data(bi_data)
);

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_bidirectional_bus_gate);
    // Display header for the output
    $display("Time\tOE1\tOE2\tBiData\tOut1\tOut2");

    // Test case 1: No outputs enabled, bi_data should be high-impedance
    oe_1 = 0;
    oe_2 = 0;
    data_in_1 = 8'hAA; // Example data for port 1
    data_in_2 = 8'h55; // Example data for port 2
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test case 2: Enable output from port 1
    oe_1 = 1;
    oe_2 = 0;
    #10; // Allow time for propagation
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test case 3: Enable output from port 2, disabling port 1
    oe_1 = 0;
    oe_2 = 1;
    #10; // Allow time for propagation
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test case 4: Enable both ports (should create high-impedance due to conflict)
    oe_1 = 1;
    oe_2 = 1;
    #10; // Allow time for propagation
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // End the simulation
    $stop;
end

endmodule
