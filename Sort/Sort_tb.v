`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 15:25:53
// Design Name: 
// Module Name: Sort_tb
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


module Sort_tb();
	reg reset;
	wire clock;
	reg [3 : 0] x0, x1, x2, x3;
	wire [3 : 0] s0, s1, s2, s3;
	wire done;
//	wire [2 : 0] currentstate, nextstate;
//	wire [3 : 0] count;
	GenerateClock CLK (clock);
	Sort DUT (.x0(x0), .x1(x1), .x2(x2), .x3(x3), .reset(reset), .clock(clock), 
		.s0(s0), .s1(s1), .s2(s2), .s3(s3), .done(done));
	
	initial
	begin
		x0 = 4'b1000;
		x1 = 4'b0101;
		x2 = 4'b0001;
		x3 = 4'b0101;
		reset = 'b1;#5;
		reset = 'b0;#195;
		x0 = 4'b0011;
		x1 = 4'b0111;
		x2 = 4'b0000;
		x3 = 4'b0100;
		reset = 'b1;#5;
		reset = 'b0;
	end
	
endmodule
