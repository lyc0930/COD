`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 13:35:55
// Design Name: 
// Module Name: MulticycleCPU
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


module MulticycleCPU #(parameter DIGIT = 32, FIELDWIDTH = 5, ADDRWIDTH = 16, DEBUGSIZE = 8)
(CLK, reset, run, MemData, ProbeAddress, MemWrite, MemAddress, RegReadData_1_RegOut, ProbePC, ProbeRegData);
	input CLK;
	input reset;
	input run;
	input      [DIGIT - 1 : 0] MemData;
	input  [DEBUGSIZE - 1 : 0] ProbeAddress;
	
	output MemWrite;
	output [ADDRWIDTH - 1 : 0] MemAddress;
	output     [DIGIT - 1 : 0] RegReadData_1_RegOut;
	output     [DIGIT - 1 : 0] ProbePC;
	output     [DIGIT - 1 : 0] ProbeRegData;
		
	// Control signal
	wire         PCWriteCondition_0;
	wire         PCWriteCondition_1;
	wire         PCWrite;
	wire         IorD;
	wire         MemtoReg;
	wire         IRWrite;
	wire [1 : 0] PCSource;
	wire [2 : 0] ALUOp;
	wire         ALUSrcA;
	wire [1 : 0] ALUSrcB;
	wire         RegWrite;
	wire         RegDst;
	wire [3 : 0] ALUControlSignal;
	
	// Wires
	wire      [DIGIT - 1 : 0] PCOut; 
	wire      [DIGIT - 1 : 0] Instruction;
	wire      [DIGIT - 1 : 0] MemData_RegOut;
	wire [FIELDWIDTH - 1 : 0] RegWriteAddress;
	wire      [DIGIT - 1 : 0] RegWriteData;
	wire      [DIGIT - 1 : 0] RegReadData_0, RegReadData_1;
	wire      [DIGIT - 1 : 0] RegReadData_0_RegOut;
	wire      [DIGIT - 1 : 0] ALUSource_A;
	wire      [DIGIT - 1 : 0] ALUSource_B;
	wire      [DIGIT - 1 : 0] Instruction_Extended;
	wire      [DIGIT - 1 : 0] ALUResult;
	wire              [3 : 0] ALUFlags;
	wire      [DIGIT - 1 : 0] ALUOut;
	wire      [DIGIT - 1 : 0] NextPC;
	
	// Decode
	wire              [5 : 0] op;
	wire [FIELDWIDTH - 1 : 0] rs, rt, rd, shamt;
	wire              [5 : 0] funct;
	
	assign {op, rs, rt, rd, shamt, funct} = Instruction; // R-type
	
	// Debug
	wire clock;
	
	assign ProbePC = PCOut;
	assign clock = run & CLK;
	
	// Connection
	ControlUnit 		             CU                       (clock, reset, op, PCWriteCondition_0, PCWriteCondition_1, PCWrite, IorD, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcA, ALUSrcB, RegWrite, RegDst);
	ProgramCounter                   PC                       (clock, reset, NextPC, ((ALUFlags[0] & PCWriteCondition_0) | (~ALUFlags[0] & PCWriteCondition_1) | PCWrite), PCOut);
	Multiplexer #(2, DIGIT)          MUX_MemAddress           (PCOut, ALUOut, , , IorD, MemAddress);
	InstructionRegister  			 IR                       (clock, IRWrite, MemData, Instruction);
	Register                         MDR                      (clock, MemData, MemData_RegOut);
	Multiplexer #(2, FIELDWIDTH)     MUX_RegisterWriteAddress (rt, rd, , , RegDst, RegWriteAddress);
	Multiplexer #(2, DIGIT)          MUX_RegisterWriteData    (ALUOut, MemData_RegOut, , , MemtoReg, RegWriteData);
	Registers   #(FIELDWIDTH, DIGIT) DR                       (clock, reset, rs, rt, ProbeAddress, RegWriteAddress, RegWriteData, RegWrite, RegReadData_0, RegReadData_1, ProbeRegData);
	SignExtend			             EX                       (Instruction[15 : 0], Instruction_Extended);
	Register                         A                        (clock, RegReadData_0, RegReadData_0_RegOut);
	Register                         B                        (clock, RegReadData_1, RegReadData_1_RegOut);
	Multiplexer #(2, DIGIT)          MUX_ALUSourceA           (PCOut, RegReadData_0_RegOut, , , ALUSrcA, ALUSource_A);
	Multiplexer #(4, DIGIT)          MUX_ALUSourceB           (RegReadData_1_RegOut, 'd4, Instruction_Extended, (Instruction_Extended << 2), ALUSrcB, ALUSource_B);
	ALUControl		                 ALUCTRL                  (funct, ALUOp, ALUControlSignal);
	ALU	                             ALU                      (ALUControlSignal, ALUSource_A, ALUSource_B, ALUResult, ALUFlags);
	Register                         ALUOUT                   (clock, ALUResult, ALUOut);
	Multiplexer #(3, DIGIT)          MUX_NextPC               (ALUResult, ALUOut, {PCOut[31 : 28], Instruction[25 : 0], 2'b00}, , PCSource, NextPC);

endmodule
