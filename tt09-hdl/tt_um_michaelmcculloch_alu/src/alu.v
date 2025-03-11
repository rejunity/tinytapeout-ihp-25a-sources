`include "alu_op.vh"

module alu(
    input [7:0] a, b,
    input [3:0] alu_op,
    output reg [7:0] out
);


always @(*) begin
    case(alu_op)
        `ALU_ADD: out = a + b;      // aDD 
        `ALU_SUB: out = a - b;     // SUb
        `ALU_AND    : out = a & b;
        `ALU_OR : out = a | b;
        `ALU_XOR    : out = a ^ b;
        //Signed
        `ALU_SLT    : begin
            if (a < b) begin 
                out = 1; 
            end else begin
                out = 0;
            end
        end
        //Unsigned
        `ALU_SLTU   : begin
            if (a[4:0] < b[4:0]) begin 
                out = 1; 
            end else begin
                out = 0;
            end
        end
        `ALU_SLL    : out = a << b[4:0];
        `ALU_SRA: out = a >>> b[4:0];
        `ALU_SRL    : out = a >> b[4:0];
        `ALU_COPY_B : out = b;
        `ALU_XXX    : out = 0;
        
    endcase
end

endmodule
 
