module bidirectional_bus #(
    parameter N = 8
) (
    input [N-1:0] data_in_1,
    input [N-1:0] data_in_2,
    input oe_1,
    input oe_2,
    output [N-1:0] data_out_1,
    output [N-1:0] data_out_2,
    inout [N-1:0] bi_data
);

assign #(4:5:6) bi_data = (oe_1 ^ oe_2 == 0) ? {N{1'bZ}} : (oe_1 ? data_in_1 : data_in_2);
// if both signals are active or inactive, send high impedance on the wire
assign #(4:5:6) data_out_1 = oe_2 ? bi_data : {N{1'bZ}};
assign #(4:5:6) data_out_2 = oe_1 ? bi_data : {N{1'bZ}};

endmodule