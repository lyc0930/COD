`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 16:03:23
// Design Name: 
// Module Name: CPUDebugDisplay
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


module CPUDebugDisplay #(parameter DIGIT = 32, ADDRWIDTH = 16, DEBUGSIZE = 8)
(CLK100MHZ, reset, continue, step, probe, inc, dec, run, ProbeAddress, DisplayPC, AN, seg);
	input CLK100MHZ, reset;
	input continue, step, probe, inc, dec;
	
	output run; 
	output [DEBUGSIZE - 1 : 0] ProbeAddress;
	output [DEBUGSIZE - 1 : 0] DisplayPC; 
	output             [7 : 0] AN;
	output             [6 : 0] seg;

	
	wire clock;
	wire MemWrite;
	wire [ADDRWIDTH - 1 : 0] MemAddress;
	wire     [DIGIT - 1 : 0] MemData;
	wire     [DIGIT - 1 : 0] RegData;
	wire 	 [DIGIT - 1 : 0] ProbePC;
	wire     [DIGIT - 1 : 0] ProbeRegData;
	wire     [DIGIT - 1 : 0] ProbeMemData;

	DebugandDisplayUnit DDU (CLK100MHZ, reset, continue, step, probe, inc, dec, ProbePC[DEBUGSIZE + 1 : 2], ProbeMemData, ProbeRegData, run, clock, ProbeAddress, DisplayPC, AN, seg);
	MulticycleCPU       CPU (clock, reset, run, MemData, ProbeAddress, MemWrite, MemAddress, RegData, ProbePC, ProbeRegData);
	Memory              MEM (MemAddress[DEBUGSIZE + 1 : 2], RegData, ProbeAddress, clock, MemWrite, MemData, ProbeMemData);

endmodule
