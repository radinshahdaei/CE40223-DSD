module bidirectional_bus_gate #(
    parameter N = 8
) (
    input wire [N-1:0] data_in_1,
    input wire [N-1:0] data_in_2,
    input wire oe_1,
    input wire oe_2,
    output wire [N-1:0] data_out_1,
    output wire [N-1:0] data_out_2,
    inout wire [N-1:0] bi_data
);

genvar i;
for (i = 0; i < N; i = i + 1) begin
    bufif1 #(5:6:7, 4:5:6, 4:5:6) buf1(bi_data[i], data_in_1[i], oe_1);
    bufif1 #(5:6:7, 4:5:6, 4:5:6) buf2(bi_data[i], data_in_2[i], oe_2);
    bufif1 #(5:6:7, 4:5:6, 4:5:6) buf3(data_out_1[i], bi_data[i], oe_2);
    bufif1 #(5:6:7, 4:5:6, 4:5:6) buf4(data_out_2[i], bi_data[i], oe_1);
    
end

endmodule