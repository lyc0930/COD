`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 21:57:25
// Design Name: 
// Module Name: FrequencyDivision
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


module FrequencyDivision(input Origin_Clock, input reset, output pulse);
	 reg [23:0] count;
     always @(posedge Origin_Clock or posedge reset)
     begin
     	if (reset)
     		count <= 'd0;  		
		else 
		begin
			if(count >= 'd499999)
     			count	<= 'd0;
     		else
     			count	<= count + 'd1;
     	end
     end
     assign	pulse =  (count == 'd299999) ? 1'b1 : 1'b0;
endmodule
