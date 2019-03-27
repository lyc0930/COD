`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 15:33:13
// Design Name: 
// Module Name: ACM_tb
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


module ACM_tb();
	reg [5 : 0] x;
	reg reset;
	wire clock;
	wire [5 : 0] s;
	GenerateClock CLK (clock);
	ACM acm (.x(x), .reset(reset), .clock(clock), .s(s));
	
	integer i = 0;
	initial 
	begin
		x = 'b0;
		reset = 'b1;#20
		reset = 'b0;#20
		for (i = 0; i <= 6'b111111; i = i + 1)
		begin
			x = i;#20;
		end
	end
	 
endmodule
