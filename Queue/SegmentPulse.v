`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 15:35:28
// Design Name: 
// Module Name: SegmentPulse
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


module SegmentPulse(input Origin_Clock, input reset, output [2 : 0] pulse);
	 
	 reg [17:0] count;
     always @(posedge Origin_Clock or posedge reset)
     begin
     	if (reset)
     		count <= 'd0;  		
		else 
		begin
			if(count >= 'd117096)
     			count	<= 'd0;
     		else
     			count	<= count + 'd1;
     	end
     end
     assign	pulse = count[16 : 14];
endmodule
