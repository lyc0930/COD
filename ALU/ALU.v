`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/13 19:36:03
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(s, a, b, y, f);
    parameter  N = 6, M = 3, K = 4;
    input wire [M - 1 : 0] s;
    input wire [N - 1 : 0] a;
    input wire [N - 1 : 0] b;
    output reg [N - 1 : 0] y;
    output wire [K - 1 : 0] f;
    wire CF, S, V, Z;
    wire  C, F;
    wire [N - 1 : 0] add_sum, minus_sum;
    always @(*)
    begin
    	case (s)
    		3'b000: y = a + b;
    		3'b001: y = a + ( ~b + 'b1);//(F == 1) ? (('b1 << 6) - minus_sum) : minus_sum;
    		3'b100: y = a & b;
    		3'b101: y = a | b;
    		3'b110: y = ~a;
    		3'b111: y = a ^ b;
    		default : y = 'b0;
    	endcase 
    end
    assign f = {CF, S, V, Z};//carry/borrow positive/negative overflow/not zero/not
    assign CF = (s[M - 1] == 1) ? 0 : ((s[0] == 0) ? C : F);
    assign {C, add_sum} = a + b;
    assign {F, minus_sum} = a - b;	
    assign S = ((s == 3'b001) && (F == 1)) ? 1 : 0;//negative number only appears when doing subtraction
    assign V = ((s[M - 1] == 0) && (s[0] ^~ (a[N - 1] ^ b[N - 1])) && (a[N - 1] ^ y[N - 1])) ? 1 : 0;//overflow
    assign Z = (y == 'b0) ? 1 : 0;
endmodule
