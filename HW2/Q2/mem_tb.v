`include "mem.v"

module mem_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [8:0] addr_A;
    reg [8:0] addr_B;
    reg rd_en_A;
    reg rd_en_B;
    reg we_A;
    reg we_B;
    reg rst;
    reg clk;
    reg [15:0] data_A;
    reg [15:0] data_B;

    wire [15:0] io_data_A;
    wire [15:0] io_data_B;

    assign io_data_A = we_A ? data_A : 16'bz;
    assign io_data_B = we_B ? data_B : 16'bz;

    mem uut (
        .addr_A(addr_A),
        .addr_B(addr_B),
        .rd_en_A(rd_en_A),
        .rd_en_B(rd_en_B),
        .we_A(we_A),
        .we_B(we_B),
        .rst(rst),
        .clk(clk),
        .data_A(io_data_A),
        .data_B(io_data_B)
    );

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1;
        addr_A = 0;
        addr_B = 0;
        rd_en_A = 0;
        rd_en_B = 0;
        we_A = 0;
        we_B = 0;
        data_A = 16'h0000;
        data_B = 16'h0000;
        #20 rst = 0;

        we_A = 1;
        we_B = 1;

        addr_A = 0;
        addr_B = 100;

        repeat (10) begin
            data_A = $random;
            data_B = $random;
            #CLK_PERIOD;

            $display("Write: \tAddress = %h, Data = %h", addr_A, io_data_A);
            $display("Write: \tAddress = %h, Data = %h", addr_B, io_data_B);

            addr_A = addr_A + 1;
            addr_B = addr_B + 1;
        end


        we_A = 0;
        we_B = 0;
        rd_en_A = 1;
        rd_en_B = 1;

        repeat (10) begin
            #CLK_PERIOD;
            addr_A = addr_A - 1;
            addr_B = addr_B - 1;
            #CLK_PERIOD;
            $display("Read: \tAddress = %h, Data = %h", addr_A, io_data_A);
            $display("Read: \tAddress = %h, Data = %h", addr_B, io_data_B);
        end

        #100 $finish;
    end

endmodule
