`timescale 1ns / 1ps

`include "datapath.v"

module testbench;

    reg clk;
    reg start;
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] C;

    wire out_r;
    wire [31:0] out;

    datapath uut (
        .clk(clk),
        .start(start),
        .A(A),
        .B(B),
        .C(C),
        .out_r(out_r),
        .out(out)
    );

    always #5 clk = ~clk;
    
    initial begin

        clk = 0;
        start = 0;
        A = 0;
        B = 0;
        C = 0;

        A = 32'd15;
        B = 32'd10;
        C = 32'd20;

        start = 1;
        #1000;
        $display(out); // test 1
        start = 0;
      
        #100;

        A = 32'd3;
        B = 32'd4;
        C = 32'd20;

        start = 1;
        #1000;
        $display(out); // test 2
        start = 0;
        
        #100;

        A = 32'd12;
        B = 32'd11;
        C = 32'd1000;

        start = 1;
        #1000;
        $display(out); // test 3
        start = 0;
        
        #100;

        A = 32'd24;
        B = 32'd1;
        C = 32'd25;

        start = 1;
        #1000;
        $display(out); // test 4
        start = 0;
        
        #100;

        A = 32'd5;
        B = 32'd5;
        C = 32'd20;

        start = 1;
        #1000;
        $display(out); // test 5
        start = 0;
        
        #100;

        A = 32'd19;
        B = 32'd28;
        C = 32'd10;

        start = 1;
        #1000;
        $display(out); // test 6
        start = 0;
        
        #100;


        $stop;
    end

endmodule
