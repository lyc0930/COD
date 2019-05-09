`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 17:31:53
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
			if(count >= 'd4999999)
				count <= 'd0;
			else
				count <= count + 'd1;
		end
 	end
 	
 	assign	pulse =  (count == 'd2499999) ? 1'b1 : 1'b0;
 	
endmodule
