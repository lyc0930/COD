`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 10:03:33
// Design Name: 
// Module Name: ProgramCounter
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



module ProgramCounter #(parameter DIGIT = 32)(clock, reset, NextPC, PCWrite, Out);
	input clock;
	input reset;
	input      [DIGIT - 1 : 0] NextPC;
	input PCWrite;
	
	output reg [DIGIT - 1 : 0] Out;

	initial 
	begin
		Out = 'b0;
	end
	
	always @(posedge clock or posedge reset)
	begin 
		if(reset) 
			Out <= 'b0;
		else 
		begin
			if (PCWrite) 
				Out <= NextPC;
			else 
				Out <= Out;
		end
	end
endmodule
