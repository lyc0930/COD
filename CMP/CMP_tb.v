`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 23:19:45
// Design Name: 
// Module Name: CMP_tb
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


module CMP_tb();
	reg [5:0] x, y;
	wire unsignedGL, signedGL, equal;
	CMP DUT (.x(x), .y(y), .unsignedGL(unsignedGL), .signedGL(signedGL), .equal(equal));
	
	initial
	begin
		x = 6'b100000;
		y = 6'b111111;#20
		x = 6'b100000;
		y = 6'b100000;#20
		x = 6'b000101;
		y = 6'b100111;#20
		x = 6'b001100;
		y = 6'b101101;
	end
endmodule
