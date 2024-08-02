import sys
import random


def generate_random_test(num_tests):
    addr = [random.randint(0, 65535) for _ in range(num_tests)]
    data = [random.randint(0, 4294967295) for _ in range(num_tests)]
    byte_sel = [random.randint(0, 3) for _ in range(num_tests)]

    test_code = generate_test(addr, data, byte_sel)
    return test_code


def generate_test(addr, data, byte_sel):
    test = []
    for i in range(len(addr)):
        test.append(f"addr = 16'h{addr[i]:04X};")
        test.append(f"data = 32'h{data[i]:08X};")
        test.append("we = 1;")
        test.append("#10;")
        test.append("we = 0;")
        test.append(f'$display("Written %h to address %h", data, addr);')
        test.append("#10;")

    for i in range(len(addr)):
        test.append(f"addr = 16'h{addr[i]:04X};")
        test.append(f"byte_sel = 2'b{byte_sel[i]:02b};")
        test.append("re = 1;")
        test.append("#10;")
        test.append(f'$display("Read full data at address %h: %h", addr, read_data);')
        test.append(
            f'$display("Byte %h at address %h: %h", byte_sel, addr, data_out_byte);'
        )
        test.append("re = 0;")
        test.append("#10;")

    return "\n".join(test)


def generate_verilog_testbench(module_name, num_tests, filename):
    original_code = f"""
`include "{module_name}.v"

module {module_name}_tb();

    reg [15:0] addr;
    reg [1:0] byte_sel;
    reg we, re, clk;
    reg [31:0] data;

    wire [31:0] read_data;
    wire [7:0] data_out_byte;

    {module_name} uut (
        .addr(addr),
        .byte_sel(byte_sel),
        .we(we),
        .re(re),
        .clk(clk),
        .data(data),
        .read_data(read_data),
        .data_out_byte(data_out_byte)
    );

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        addr = 0;
        byte_sel = 0;
        we = 0;
        re = 0;
        data = 0;
"""

    # Generating random tests

    # Appending random tests to the original code
    modified_code = original_code + random_tests

    # Adding the end of the module
    modified_code += """
        $display("Test completed.");
        $finish;
    end

endmodule
"""

    with open(filename, "w") as f:
        f.write(modified_code)


if __name__ == "__main__":
    num_tests = int(sys.argv[1])
    random_tests = generate_random_test(num_tests)
    generate_verilog_testbench(
        "little_endian_mem", random_tests, "little_endian_mem_tb.v"
    )
    generate_verilog_testbench("big_endian_mem", random_tests, "big_endian_mem_tb.v")
