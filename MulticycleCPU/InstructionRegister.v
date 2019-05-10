`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 10:59:27
// Design Name: 
// Module Name: InstructionRegister
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


module InstructionRegister #(parameter DIGIT = 32)
(clock, IRWrite, MemData, Instruction);
	input clock; 
	input IRWrite; 
	input      [DIGIT - 1 : 0] MemData; 
	
	output reg [DIGIT - 1 : 0] Instruction;
	
	reg [31:0] Register;
	
	initial 
	begin
		Register    = 'b0;
		Instruction = 'b0;
	end
	
	always @(negedge clock) 
	begin
		if (IRWrite)
			Register <= MemData;
		else
			Register <= Register;
	end
	
	always @(posedge clock) 
	begin
		Instruction <= Register;
	end
	
endmodule	

