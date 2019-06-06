`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 16:47:05
// Design Name: 
// Module Name: Fibonacci_VGA
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


module Fibonacci_VGA #(parameter DIGIT = 32, ADDRWIDTH = 16)
(CLK100MHZ, reset, f0, f1, continue, inc, dec, LED, AN, seg, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);
	input CLK100MHZ, reset;
	input [7 : 0] f0, f1;
	input continue;
	input inc, dec;
	output [15 : 0] LED; 
	output [ 7 : 0] AN;
	output [ 6 : 0] seg;
	output [ 3 : 0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
	
	wire clock, CLK5MHZ;
	wire MemWrite;
	wire [ADDRWIDTH - 1 : 0] MemAddress;
	wire     [DIGIT - 1 : 0] MemData;
	wire     [DIGIT - 1 : 0] RegData;
	wire     [DIGIT - 1 : 0] ProbeMemData;
	wire [7 : 0] X, Y;
	reg [4 : 0] Count;
	wire [4 : 0] ProbeCount;
	wire [9 : 0] f;
	wire inc_s, dec_s;
	reg [4 : 0] increment;
	reg [4 : 0] decrement;
	FrequencyDivision  SecondPulse       (CLK5MHZ, 'b0, clock);
	MulticycleCPU       CPU (clock, reset, continue, MemData, , MemWrite, MemAddress, RegData, , );
	Memory              MEM (MemAddress[9 : 2], RegData, 8'b00000011, clock, MemWrite, MemData, ProbeMemData);
	Data_RAM            RAM  (Count, ProbeMemData, Y[7 : 3], CLK100MHZ, 'b1, f);
	VGADisplayUnit VDU (f << 2, CLK100MHZ, reset, X, Y, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);

	initial
	begin
		Count = 'b0;
		increment    = 'b0;
		decrement    = 'b0;
	end
	
	always @(ProbeMemData)
	begin
		Count <= Count + 'd1;
	end
	

	// Clock
	Clocking_Wizard_0  CLK100MHZ_to_5MHZ (CLK5MHZ, CLK100MHZ);

	
	// Address change
	Debounce           incStabilize      (CLK5MHZ, inc, inc_s);
	Debounce           decStabilize      (CLK5MHZ, dec, dec_s);
	assign ProbeCount = increment + decrement;
	
	always @(posedge inc_s or posedge reset)
	begin
		if (reset)
			increment <= 'b0;
		else
		begin
			if (inc_s)
				increment <= increment + 'b1;
		end
	end	
	
	always @(posedge dec_s or posedge reset)
	begin
		if (reset)
			decrement <= 'b0;
		else
		begin
			if (dec_s)
				decrement <= decrement - 'b1;
		end
	end	
endmodule
