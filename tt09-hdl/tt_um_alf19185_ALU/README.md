![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Verilog Project:  4 BIT ALU

The 4-bit ALU (Arithmetic Logic Unit) is designed to perform a range of arithmetic and logical operations on two 4-bit inputs, A and B. The operation is determined by a 3-bit control signal, Opcode, which specifies the function to execute, such as addition, subtraction, multiplication, division, and bitwise operations (AND, OR, NOT, XOR).

When an arithmetic operation like addition is selected, the ALU outputs an 8-bit result, ALU_Result, to accommodate larger sums or products, and it sets a Carry flag if there’s an overflow. For logical operations like AND or OR, the ALU applies the operation bit-by-bit between A and B. The Zero flag is activated when the result is zero, providing a useful condition for further logic. This flexibility allows the ALU to handle various computational tasks, making it a crucial part of digital systems that require multi-functional data processing.





- [Read the documentation for project](docs/info.md)

