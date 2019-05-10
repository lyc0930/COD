`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 21:14:29
// Design Name: 
// Module Name: SinglePulse
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


module SinglePulse(clock, reset, signal, pulse);
	input  clock;
	input  reset; 
	input  signal; 
	output pulse; 

	reg delay_0;
	reg delay_1;
	
	initial
	begin
		delay_0 = 'b0;
		delay_1 = 'b0;
	end
	
	always @(negedge clock or posedge signal)
  	begin
  		if (signal)
			delay_0 <= 1;
		else
			delay_0 <= 0;
	end
	
	always @(posedge clock or posedge reset)
  	begin
		if(reset)
			delay_1 <= 'd0;
  		else
			delay_1 <= delay_0;
	end

	assign pulse = delay_0 & delay_1 & clock;


endmodule
