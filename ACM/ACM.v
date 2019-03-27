`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 15:24:48
// Design Name: 
// Module Name: ACM
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


module ACM(x, reset, clock, s);
	parameter N = 6;
	input wire [N - 1 : 0] x;
	input wire reset, clock;
	output wire [N - 1 : 0] s;
	wire [N - 1 : 0] temp_in;
	
	ALU adder (3'b000, x, s, temp_in, );
	Register R (temp_in, 'b1, reset, clock, s);
	
endmodule
