`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 13:42:52
// Design Name: 
// Module Name: MUX
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


module Multiplexer #(parameter N = 2, DATASIZE = 32)(in_0, in_1, in_2, in_3, s, out);
	input      [DATASIZE - 1 : 0] in_0, in_1, in_2, in_3;
	input                 [1 : 0] s;
	
	output reg [DATASIZE - 1 : 0] out;

	initial
	begin
		out = 'b0;
	end
	
	always @(*)
	begin
		if (s >= N)
            out = 'b0;
        else
			case (s)
				2'b00: out = in_0;
				2'b01: out = in_1; 
				2'b10: out = in_2; 
				2'b11: out = in_3; 
				2'bx0: out = in_0; 
				2'bx1: out = in_1;
				2'bz0: out = in_0; 
				2'bz1: out = in_1;
				default: 
					out = 'b1111; 
			endcase
        end
endmodule
