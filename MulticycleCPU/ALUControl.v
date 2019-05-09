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


module ALUControl #(parameter CTRLSIZE = 4)(funct, Operation, ControlSignal);
	input                 [5 : 0] funct;
	input                 [2 : 0] Operation;
	
	output reg [CTRLSIZE - 1 : 0] ControlSignal;
	
	initial
	begin
		ControlSignal = 4'b0000;
	end
	
	always @(*)
	begin
		case (Operation)
			3'b000: ControlSignal = 4'b0000; // LW SW --> ADD
			3'b001: ControlSignal = 4'b0001; // BEQ --> SUB
			3'b010: 
				case (funct)
					6'b100000: ControlSignal = 4'b0000; // ADD
					6'b100010: ControlSignal = 4'b0001; // SUB
					6'b100100: ControlSignal = 4'b1000; // AND
					6'b100101: ControlSignal = 4'b1001; //  OR
					6'b100110: ControlSignal = 4'b1100; // XOR
					6'b100111: ControlSignal = 4'b1011; // NOR
					6'b101010: ControlSignal = 4'b1101; // SLT
					default:
						ControlSignal = 4'b0000;
				endcase
			3'b011: ControlSignal = 4'b0000; // ADDI 001000
			3'b100: ControlSignal = 4'b1000; // ANDI 001100
			3'b101: ControlSignal = 4'b1001; //  ORI 001101
			3'b110: ControlSignal = 4'b1100; // XORI 001110
			3'b111: ControlSignal = 4'b1101; // SLTI 001010
			default:
				ControlSignal = 4'b0000;
		endcase 
	end
	
	
endmodule
