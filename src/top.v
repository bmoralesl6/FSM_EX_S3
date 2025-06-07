`timescale 1ns / 1ps

module top (
    input clk,                      
    input [7:0] sw,                 
    input [7:0] sw_b,                
    input [2:0] sel,                 
    output [15:0] led,               
    output [6:0] seg,                
    output [3:0] an                 
);

    wire [7:0] result;
    wire carry, zero, ovf;

    alu_8bit alu_inst (
        .A(sw),
        .B(sw_b),
        .ALU_Sel(sel),
        .ALU_Out(result),
        .CarryOut(carry),
        .Zero(zero),
        .Overflow(ovf)
    );

    display_mux disp (
        .clk(clk),
        .data(result),
        .an(an),
        .seg(seg)
    );

  
    assign led[7:0] = result;
    assign led[8] = carry;
    assign led[9] = zero;
    assign led[10] = ovf;

endmodule
