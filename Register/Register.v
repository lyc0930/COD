`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 22:16:00
// Design Name: 
// Module Name: Register
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


module Register(in, enable, reset, clock, out);
    parameter N = 6;
    input wire [N - 1 : 0] in;
    input wire enable;
    input wire reset;
    input wire clock;
    output reg [N - 1 : 0] out;
    always @(posedge clock)
   	begin
   		if (reset)
   			out <= 'b0;
   		else
   			if (enable)
   				out <= in;
   	end
endmodule
