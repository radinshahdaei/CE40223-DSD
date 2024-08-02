rm diff.txt

python3 generator.py $1

iverilog -o tb little_endian_mem_tb.v
vvp tb >> littleOutput.txt
iverilog -o tb big_endian_mem_tb.v
vvp tb >> bigOutput.txt

diff -y bigOutput.txt littleOutput.txt >> diff.txt

rm tb bigOutput.txt littleOutput.txt
