`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 21:06:02
// Design Name: 
// Module Name: Counter
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


module Counter(
	input clock,             
	input reset,             
	input [15:0] Range,     
	output reg [15:0] Counter 
);

	always@(posedge clock or posedge reset) 
	begin
		if (reset) 
			Counter <= 0;
		else 
			if(Counter == Range - 1) 
				Counter <= 0;
			else 
				Counter <= Counter + 1;
	end

endmodule
