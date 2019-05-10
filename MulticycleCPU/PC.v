`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 10:03:33
// Design Name: 
// Module Name: PC
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



module ProgramCounter #(parameter DIGIT = 32)(clock, reset, NextPC, PCWrite, IAddress);
	input clock;
	input reset;
	input      [DIGIT - 1 : 0] NextPC;
	input PCWrite;
	
	output reg [DIGIT - 1 : 0] IAddress;

	initial 
	begin
		IAddress = 'b0;
	end
	
	always @(posedge clock or posedge reset)
	begin 
		if(reset) 
			IAddress <= 'b0;
		else 
		begin
			if (PCWrite) 
				IAddress <= NextPC;
			else 
				IAddress <= IAddress;
		end
	end
endmodule
