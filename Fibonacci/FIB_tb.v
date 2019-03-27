`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 16:19:12
// Design Name: 
// Module Name: FIB_tb
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


module FIB_tb();
	wire clock;
	wire [5 : 0] fn;
	reg [5 : 0] f0, f1;
	reg reset;
	GenerateClock CLK (clock);
	Fibonacci FIB (.f0(f0), .f1(f1), .reset(reset), .clock(clock), .fn(fn)); 
	
	initial
	begin
		f0 = 6'b1;
		f1 = 6'b1;
		reset = 'b1;#10;
		reset = 'b0;#40;
		reset = 'b1;#10;
		reset = 'b0;
	end
endmodule
