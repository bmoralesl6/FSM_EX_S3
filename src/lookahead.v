`timescale 1ns / 1ps
// alu_8bit.v
module lookahead (
    input [7:0] A,
    input [7:0] B,
    input [2:0] ALU_Sel, // Control de operación
    output reg [7:0] ALU_Out,
    output CarryOut,
    output Zero,
    output Overflow
);

    wire [7:0] sum;
    wire carry_out;

    cla_adder_8bit CLA (
        .A(A),
        .B(B),
        .Cin(1'b0),
        .Sum(sum),
        .Cout(carry_out)
    );

    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Out = sum;                       
            3'b001: ALU_Out = A - B;                     
            3'b010: ALU_Out = A & B;                      
            3'b011: ALU_Out = A | B;                     
            3'b100: ALU_Out = A ^ B;                    
            3'b101: ALU_Out = ~A;                         
            3'b110: ALU_Out = A << 1;                     
            3'b111: ALU_Out = A >> 1;                    
            default: ALU_Out = 8'b00000000;
        endcase
    end

    assign Zero = (ALU_Out == 8'b0);
    assign CarryOut = (ALU_Sel == 3'b000) ? carry_out : 1'b0;
    assign Overflow = (ALU_Sel == 3'b000) ? ((A[7] == B[7]) && (ALU_Out[7] != A[7])) : 1'b0;

endmodule
