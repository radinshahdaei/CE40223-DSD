`include "bidirectional_bus.v"

module tb_bidirectional_bus;

// Define parameters and signals
parameter N = 8; // Width of the data bus

// Test inputs and outputs
reg [N-1:0] data_in_1; // Input data for port 1
reg [N-1:0] data_in_2; // Input data for port 2
reg oe_1; // Output enable for port 1
reg oe_2; // Output enable for port 2
wire [N-1:0] data_out_1; // Output data for port 1
wire [N-1:0] data_out_2; // Output data for port 2
wire [N-1:0] bi_data; // Bidirectional data bus

// Instantiate the bidirectional_bus module
bidirectional_bus #(.N(N)) uut (
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
    $dumpvars(0, tb_bidirectional_bus);
    // Initialize signals
    data_in_1 = 8'hAA; // Example data for port 1 (binary 10101010)
    data_in_2 = 8'h55; // Example data for port 2 (binary 01010101)
    oe_1 = 0;
    oe_2 = 0;

    // Display header for the output
    $display("Time\tOE1\tOE2\tBiData\tOut1\tOut2");

    // Simulation for various test cases

    // Test 1: No output enabled, bus should be high-impedance
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test 2: Enable output from port 1
    oe_1 = 1;
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test 3: Enable output from port 2 (should create high-impedance due to conflict)
    oe_2 = 1;
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test 4: Disable output from port 1
    oe_1 = 0;
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // Test 5: No output enabled again (high-impedance)
    oe_2 = 0;
    #10;
    $display("%0t\t%b\t%b\t%h\t%h\t%h", $time, oe_1, oe_2, bi_data, data_out_1, data_out_2);

    // End the simulation
    $stop;
end

endmodule
