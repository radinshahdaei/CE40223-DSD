module mem (
    input [8:0] addr_A,
    input [8:0] addr_B,
    input rd_en_A,
    input rd_en_B,
    input we_A,
    input we_B,
    input rst,
    input clk,
    inout [15:0] data_A,
    inout [15:0] data_B
);

    reg [15:0] mem [0:511];
    reg [15:0] read_data_A;
    reg [15:0] read_data_B;
    reg [15:0] write_data_A;
    reg [15:0] write_data_B;

    always @(posedge clk) begin
        if (rst) begin
            read_data_A <= 16'b0;
            read_data_B <= 16'b0;
        end
        else begin
            if (rd_en_A) begin
                read_data_A <= mem[addr_A];
            end
            if (rd_en_B) begin
                read_data_B <= mem[addr_B];
            end

            if (we_A && ~rd_en_A) begin
                mem[addr_A] <= data_A;
            end
            if (we_B && ~rd_en_B) begin
                mem[addr_B] <= data_B;
            end
        end
    end

    assign data_A = rd_en_A ? read_data_A : 16'bz;
    assign data_B = rd_en_B ? read_data_B : 16'bz;

endmodule





