`timescale 1ns / 1ps
// display.v
module display (
    input clk,
    input [7:0] data,
    output reg [3:0] an,       
    output [6:0] seg          
);

    reg toggle;
    reg [3:0] digit;
    wire [6:0] seg_temp;

    always @(posedge clk) begin
        toggle <= ~toggle;
    end

    always @(*) begin
        if (toggle) begin
            digit = data[3:0];  
            an = 4'b1110;       
        end else begin
            digit = data[7:4];  
            an = 4'b1101;       
        end
    end

    hex_to_7seg h2s (
        .hex(digit),
        .seg(seg_temp)
    );

    assign seg = seg_temp;

endmodule
