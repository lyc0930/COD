`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 18:48:36
// Design Name: 
// Module Name: DIV_tb
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


module DIV_tb();
	wire clock, error, done;
	wire [3 : 0] q, r;
	reg reset;
	reg [3 : 0] x, y;
//	wire [2 : 0] currentstate, nextstate;
//	wire [3 : 0] count;
//	wire [7 : 0] Data;
	GenerateClock C (clock);
	DIV DUT (.clock(clock), .reset(reset), .x(x), .y(y), .q(q), .r(r), .error(error), .done(done));//, .currentstate(currentstate), .nextstate(nextstate), .count(count) ,.Data(Data));
	initial 
	begin
		x = 4'b1111;
		y = 4'b0010;
		reset = 'b1;#10;
		reset = 'b0;#110;
		x = 4'b0111;
		y = 4'b0011;
		reset = 'b1;#10;
		reset = 'b0;#110;
		x = 4'b1010;
		y = 4'b0000;
		reset = 'b1;#10;
		reset = 'b0;
	end
	
endmodule
