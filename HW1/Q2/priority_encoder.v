module priority_encoder(
    input [3:0] I,
    output [1:0] O,
    output wire v
);
   assign v = I[3] | I[2] | I[1] | I[0];
   assign O[0] = (v & (I[3] | (~I[2] & I[1]))) | (~v & 1'bx);
   assign O[1] = (v & (I[3] | I[2])) | (~v & 1'bx);
   
endmodule