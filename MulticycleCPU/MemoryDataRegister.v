`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 15:53:16
// Design Name: 
// Module Name: MemoryDataRegister
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


module Register #(parameter DIGIT = 32)(clock, In, Out);
	input clock;
	input      [31:0] In;
	
	output reg [31:0] Out;
	
	reg [31:0] Register;

	initial 
	begin
		Out      = 'b0;
		Register = 'b0;
	end
	
	always@(negedge clock) 
	begin
		Register <= In;
	end
	
	always@(posedge clock) 
	begin
		Out <= Register;
	end
	
endmodule
