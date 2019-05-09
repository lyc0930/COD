`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:34:27
// Design Name: 
// Module Name: DisplayPulse
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


module DisplayPulse(input Origin_Clock, input reset, output [2 : 0] pulse);
	reg [17:0] count;
	
	initial
	begin
		count = 'b0;
	end
	
 	always @(posedge Origin_Clock or posedge reset)
 	begin
		if (reset)
			count <= 'd0;  		
		else 
		begin
			if(count >= 'd131072)
				count <= 'd0;
			else
				count <= count + 'd1;
		end
	end
	
 	assign	pulse = count[16 : 14];
 	
endmodule
