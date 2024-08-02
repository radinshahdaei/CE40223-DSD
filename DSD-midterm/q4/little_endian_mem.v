module little_endian_mem(
    input [15:0] addr,
    input [1:0] byte_sel,
    input we, re, clk,
    input [31:0] data,
    output reg [31:0] read_data,
    output reg [7:0] data_out_byte
);

reg [7:0] mem[0:4 * 2 ** 16 - 1];

wire [17:0] base_addr;
assign base_addr = addr << 2;

always @(posedge clk) begin
    if (we) begin
        mem[base_addr + 0] <= data[7:0];
        mem[base_addr + 1] <= data[15:8];
        mem[base_addr + 2] <= data[23:16];
        mem[base_addr + 3] <= data[31:24];
    end else if (re) begin
        read_data[7:0]   <= mem[base_addr + 0];
        read_data[15:8]  <= mem[base_addr + 1];
        read_data[23:16] <= mem[base_addr + 2];
        read_data[31:24] <= mem[base_addr + 3];

        case (byte_sel)
            2'b00: data_out_byte <= mem[base_addr + 0];
            2'b01: data_out_byte <= mem[base_addr + 1];
            2'b10: data_out_byte <= mem[base_addr + 2];
            2'b11: data_out_byte <= mem[base_addr + 3];
            default: data_out_byte <= 8'bz;
        endcase
    end
end

endmodule

