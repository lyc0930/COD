`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 00:18:05
// Design Name: 
// Module Name: CMP
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


module CMP(x, y, unsignedGL, signedGL, equal);
	parameter N = 6, K = 4;
	input wire [N - 1 : 0] x, y;
	output wire unsignedGL, signedGL;
	output wire equal;
	wire [K - 1 : 0] f;
	ALU minus (3'b001, x, y, , f);
	assign equal = f[0];
	assign unsignedGL = ~equal & ~f[3];
	assign signedGL = ~equal & ~f[2];
endmodule
