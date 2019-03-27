`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 16:10:19
// Design Name: 
// Module Name: Fibonacci
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


module Fibonacci(f0, f1, reset, clock, fn);
	parameter N = 6;
	input wire [N - 1 : 0] f0, f1;
	input wire reset, clock;
	output wire [N - 1 : 0] fn;
	reg [N - 1 : 0] fn_1, fn_2;
	wire [N - 1 : 0] fn_1_temp, fn_2_temp;
	
	ALU adder (3'b000, fn_2, fn_1, fn, );
	Register R1 (fn_1, 'b1, 'b0, clock, fn_2_temp);
	Register R2 (fn, 'b1, 'b0, clock, fn_1_temp);
	 
	initial 
	begin
		fn_2 = f0;
		fn_1 = f1;
	end
	
	always @(negedge clock)
   	begin
   		if (reset)
   		begin
   			fn_2 <= f0;
			fn_1 <= f1;
		end
		else
		begin
			if (fn_2_temp)
   				fn_2 <= fn_2_temp;
   			if (fn_1_temp)
   				fn_1 <= fn_1_temp;
		end
   	end
   	
endmodule
