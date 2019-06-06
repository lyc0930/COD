`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 13:41:31
// Design Name: 
// Module Name: ALUControl
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
`include "MIPS_opcode.vh"

module ALUControl #(parameter CTRLSIZE = 4)(funct, Operation, Signal);
	input                 [5 : 0] funct;
	input                 [2 : 0] Operation;
	
	output reg [CTRLSIZE - 1 : 0] Signal;
	
	initial
	begin
		Signal = 4'b0000;
	end
	
	always @(*)
	begin
		case (Operation)
			3'b000: Signal = 4'b0000; // LW SW --> ADD
			3'b001: Signal = 4'b0001; // BEQ --> SUB
			3'b010: 
				case (funct)
					`ADD: Signal = 4'b0000; // ADD
					`SUB: Signal = 4'b0001; // SUB
					`AND: Signal = 4'b1000; // AND
					`OR : Signal = 4'b1001; //  OR
					`XOR: Signal = 4'b1100; // XOR
					`NOR: Signal = 4'b1011; // NOR
					`SLT: Signal = 4'b1101; // SLT
					default:
						Signal = 4'b0000;
				endcase
			3'b011: Signal = 4'b0000; // ADDI --> ADD
			3'b100: Signal = 4'b1000; // ANDI --> AND
			3'b101: Signal = 4'b1001; //  ORI -->  OR
			3'b110: Signal = 4'b1100; // XORI --> XOR
			3'b111: Signal = 4'b1101; // SLTI --> SLT
			default:
				Signal = 4'b0000;
		endcase 
	end
endmodule
