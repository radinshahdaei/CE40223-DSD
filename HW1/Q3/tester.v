`define width 8
`timescale 1ns/1ps
`include "mult.v"

module tester();
    parameter width = `width;
    reg signed [width - 1 : 0] x, y;
    wire signed [2 * width - 1 : 0] p, real_product;
    
    assign real_product = x * y;
    integer xPrime, yPrime;

    mult multiplier(p, x, y);

    initial begin

        for (xPrime = -128; xPrime < 128; xPrime++) begin
            for (yPrime = -128; yPrime < 128; yPrime++) begin
                x = xPrime;
                y = yPrime;
                #10
                if (real_product != p) begin
                    $display("x = %d , y = %d , p = %d , x * y = %d", x, y, p, real_product);
                end
            end
        end
    end
endmodule