`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 18:03:44
// Design Name: 
// Module Name: Queue_tb
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


module Queue_tb();
	wire CLK100MHZ;
	reg en_out, en_in, reset;
	reg [3 : 0] in;
	wire empty, full, tag;
	wire [3 : 0] out;
	wire [3 : 0] head, rear;
	GenerateClock CLK (CLK100MHZ);
	Queue DUT (.en_out(en_out), .en_in(en_in), .in(in), .CLK100MHZ(CLK100MHZ), .reset(reset), .Display(), .out(out), .empty(empty), .full(full), .head(head), .rear(rear), .tag(tag));

	initial
	begin
		en_in = 'b0;
		en_out = 'b0;
		in = 'd0;
		reset = 'b1;#23;
		reset = 'b0;
		en_in = 'b1;
		in = 'd1;#23;
		in = 'd2;#23;
		in = 'd3;#23;
		in = 'd4;#23;
		in = 'd5;#23;
		in = 'd6;#23;
		in = 'd7;#23;
		en_in = 'b0;#33;
		en_out = 'b1;
	end
endmodule
