`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 23:44:14
// Design Name: 
// Module Name: Register_tb
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


module Register_tb();
	reg enable, reset;
	reg [5 : 0] in;
	wire [5 : 0] out;
	wire clock;
	GenerateClock CLK (clock);
	Register A (.in(in), .enable(enable), .reset(reset), .clock(clock), .out(out));
	initial 
	begin
		in = 6'b110011;
		enable = 'b0;
		reset = 'b0;#20 
		reset = 'b1;#20 
		reset = 'b0;#20 
		enable = 'b1;#20 
		enable = 'b0;#20
		in = 6'b101010;#20
		enable = 'b1;#20 
		enable = 'b0;#20
		reset = 'b0;#20 
		reset = 'b1;#20 
		reset = 'b0; 
	end
endmodule
