`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/13 20:42:28
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();
	reg [2:0] s;
	reg [5:0] a,b;
	wire [5:0] y;
	wire [3:0] f;
	ALU DUT (.s(s), .a(a), .b(b), .y(y), .f(f));
	
	initial 
	begin
		a = 6'b000000;
		b = 6'b100000;
		s = 3'b000;#20;
		s = 3'b001;#20;
		a = 6'b001100;
		b = 6'b101111;
		s = 3'b000;#20;
		s = 3'b001;#20;
		a = 6'b101001;
		b = 6'b001100;
		s = 3'b000;#20;
		s = 3'b001;#20;
		a = 6'b101100;
		b = 6'b110100;
		s = 3'b000;#20;
		s = 3'b001;#20;
//		s = 3'b100;#20
//		s = 3'b101;#20
//		s = 3'b110;#20
//		s = 3'b111;
	end
endmodule
