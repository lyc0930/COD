`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/08 19:36:31
// Design Name: 
// Module Name: GenerateClock
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


module GenerateClock(output reg Clk);
    parameter tON = 10,tOFF = 10;
    
    initial
   	begin
    		Clk = 0;
    		forever
    		begin
    			#tOFF Clk = 1;
    			#tON Clk = 0;
    		end
    end
endmodule
