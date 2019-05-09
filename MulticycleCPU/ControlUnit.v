`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 09:16:50
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(clock, reset, op, PCWriteCondition_0, PCWriteCondition_1, PCWrite, IorD, MemWrite, 
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcA, ALUSrcB, RegWrite, RegDst, CurrentState, NextState);
	input clock;
	input reset;
	input      [5 : 0] op;

	output reg PCWriteCondition_0;
	output reg PCWriteCondition_1;
	output reg PCWrite;
	output reg IorD;
//	output reg MemRead;
	output reg MemWrite;
	output reg MemtoReg;
	output reg IRWrite;
	output reg [1 : 0] PCSource;
	output reg [2 : 0] ALUOp;
	output reg ALUSrcA;
	output reg [1 : 0] ALUSrcB;
	output reg RegWrite;
	output reg RegDst;
	
	// State
	output reg [16 : 0] CurrentState, NextState;
//	parameter Idle                 = 17'b00000000000000000,
//			  InstructionFetch     = 17'b00000000000000001,
//			  InstructionDecode    = 17'b00000000000000010,
//			  MemoryAddressCompute = 17'b00000000000000100,
//			  MemoryAccess_LW      = 17'b00000000000001000,
//			  MemoryReadComplete   = 17'b00000000000010000,
//			  MemoryAccess_SW      = 17'b00000000000100000,
//			  RTypeExecution       = 17'b00000000001000000,
//			  RTypeComplete        = 17'b00000000010000000,
//			  ADDIExecution        = 17'b00000000100000000,
//			  ANDIExecution        = 17'b00000001000000000,
//			  ORIExecution         = 17'b00000010000000000,
//			  XORIExecution        = 17'b00000100000000000,
//			  SLTIExecution        = 17'b00001000000000000,
//			  ITypeComplete        = 17'b00010000000000000,
//			  BEQComplete          = 17'b00100000000000000,
//			  BNEComplete          = 17'b01000000000000000,
//			  JumpComplete         = 17'b10000000000000000;
	parameter Idle                 = 17'b0,
			  InstructionFetch     = 1 <<  0,
			  InstructionDecode    = 1 <<  1,
			  MemoryAddressCompute = 1 <<  2,
			  MemoryAccess_LW      = 1 <<  3,
			  MemoryReadComplete   = 1 <<  4,
			  MemoryAccess_SW      = 1 <<  5,
			  RTypeExecution       = 1 <<  6,
			  RTypeComplete        = 1 <<  7,
			  ADDIExecution        = 1 <<  8,
			  ANDIExecution        = 1 <<  9,
			  ORIExecution         = 1 << 10,
			  XORIExecution        = 1 << 11,
			  SLTIExecution        = 1 << 12,
			  ITypeComplete        = 1 << 13,
			  BEQComplete          = 1 << 14,
			  BNEComplete          = 1 << 15,
			  JumpComplete         = 1 << 16;
	
	initial
	begin
		CurrentState       = Idle;
		PCWriteCondition_0 = 0;
		PCWriteCondition_1 = 0;
		PCWrite 	       = 0;
		IorD 		       = 0;
		MemWrite 	       = 0;
		MemtoReg 	       = 0;
		IRWrite 	       = 0;
		PCSource 	       = 2'b00;
		ALUOp 		       = 3'b000;
		ALUSrcA 	       = 0;
		ALUSrcB 	       = 2'b00;
		RegWrite 	       = 0;
		RegDst 		       = 0;
	end
	
	always @(posedge clock or posedge reset)
	begin
		if (reset)
			CurrentState <= Idle;
		else
			CurrentState <= NextState;
	end
	
	always @(*)
	begin
		case (CurrentState)
		
			Idle:
			begin
				NextState = InstructionFetch;
			end
		
			InstructionFetch: 
			begin
				NextState = InstructionDecode;
			end
			
			InstructionDecode: 
			begin				
				case (op)
					6'b100011: // LW
						NextState = MemoryAddressCompute;
					6'b101011: // SW
						NextState = MemoryAddressCompute;
					6'b000000: // R-type
						NextState = RTypeExecution;
				   	6'b001000: // ADDI
				   		NextState = ADDIExecution; 
				   	6'b001100: // ANDI 
				   		NextState = ANDIExecution;
				   	6'b001101: //  ORI  
				   		NextState = ORIExecution;
				   	6'b001110: // XORI 
				   		NextState = XORIExecution;
				   	6'b001010: // SLTI 
				   		NextState = SLTIExecution;
					6'b000100: // BEQ
						NextState = BEQComplete;
					6'b000101: // BNE
						NextState = BNEComplete;
					6'b000010: // J
						NextState = JumpComplete;
					default : 
						NextState = InstructionFetch;
				endcase
    		end
    		
    		MemoryAddressCompute: 
    		begin				
				case (op)
					6'b100011: // LW
						NextState = MemoryAccess_LW;
					6'b101011: // SW
						NextState = MemoryAccess_SW;
					default : 
						NextState = InstructionFetch;
				endcase
    		end
			
			MemoryAccess_LW: 
			begin
				NextState = MemoryReadComplete;
			end
			
			MemoryReadComplete: 
			begin
				NextState = InstructionFetch;
			end
			
			MemoryAccess_SW: 
			begin
				NextState = InstructionFetch;
			end
				
			RTypeExecution: 
			begin
				NextState = RTypeComplete;
			end
			
			RTypeComplete: 
			begin
				NextState = InstructionFetch;
			end
			
			ADDIExecution: 
			begin
				NextState = ITypeComplete;
			end
			
			ANDIExecution: 
			begin
				NextState = ITypeComplete;
			end
			
			ORIExecution: 
			begin
				NextState = ITypeComplete;
			end
			
			XORIExecution: 
			begin
				NextState = ITypeComplete;
			end
			
			SLTIExecution: 
			begin
				NextState = ITypeComplete;
			end
			
			ITypeComplete: 
			begin
				NextState = InstructionFetch;
			end
			
			BEQComplete: 
			begin
				NextState = InstructionFetch;
			end
			
			BNEComplete: 
			begin
				NextState = InstructionFetch;
			end
			
			JumpComplete: 
			begin
				NextState = InstructionFetch;
			end
			
    		default :
    			NextState = InstructionFetch;
    	endcase 
    end
    
    always @(posedge clock or posedge reset)
	begin
		if (reset)
		begin
			PCWriteCondition_0 <= 0;
			PCWriteCondition_1 <= 0;
			PCWrite 	       <= 0;
			IorD 		       <= 0;
			MemWrite 	       <= 0;
			MemtoReg 	       <= 0;
			IRWrite 	       <= 0;
			PCSource 	       <= 2'b00;
			ALUOp 		       <= 3'b000;
			ALUSrcA 	       <= 0;
			ALUSrcB 	       <= 2'b00;
			RegWrite 	       <= 0;
			RegDst 		       <= 0;
		end
		else
		begin
			case (NextState)
				Idle:
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				InstructionFetch: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
						PCWrite 	       <= 1;
						IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
						IRWrite 	       <= 1;
						PCSource           <= 2'b00;
						ALUOp 		       <= 3'b000;
						ALUSrcA 	       <= 0;
						ALUSrcB 	       <= 2'b01;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				InstructionDecode: 
				begin				
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp 		       <= 3'b000;
						ALUSrcA 	       <= 0;
						ALUSrcB 	       <= 2'b11;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				MemoryAddressCompute: 
				begin				
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp 		       <= 3'b000;
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				MemoryAccess_LW: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
						IorD               <= 1;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				MemoryReadComplete: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
						MemtoReg 	       <= 1;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
						RegWrite 	       <= 1;
						RegDst 		       <= 0;
				end
				
				MemoryAccess_SW: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
						IorD 		       <= 1;
						MemWrite 	       <= 1;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
					
				RTypeExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp 		       <= 3'b010;
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				RTypeComplete: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
						MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
						RegWrite 	       <= 1;
						RegDst 		       <= 1;
				end
				
				ADDIExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp              <= 3'b011; 
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				ANDIExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp              <= 3'b100; 
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				ORIExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp              <= 3'b101; 
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				XORIExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp              <= 3'b110; 
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				SLTIExecution: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
						ALUOp              <= 3'b111; 
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b10;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				ITypeComplete: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
						MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
						RegWrite 	       <= 1;
						RegDst 		       <= 0;
				end
				
				BEQComplete: 
				begin
						PCWriteCondition_0 <= 1;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
						PCSource 	       <= 2'b01;
						ALUOp 		       <= 3'b001;
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				BNEComplete: 
				begin
					PCWriteCondition_0 <= 0;
						PCWriteCondition_1 <= 1;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
						PCSource 	       <= 2'b01;
						ALUOp 		       <= 3'b001;
						ALUSrcA 	       <= 1;
						ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				JumpComplete: 
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
						PCWrite 	       <= 1;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
						PCSource 	       <= 2'b10;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
				
				default :
				begin
					PCWriteCondition_0 <= 0;
					PCWriteCondition_1 <= 0;
					PCWrite 	       <= 0;
					IorD 		       <= 0;
					MemWrite 	       <= 0;
					MemtoReg 	       <= 0;
					IRWrite 	       <= 0;
					PCSource 	       <= 2'b00;
					ALUOp 		       <= 3'b000;
					ALUSrcA 	       <= 0;
					ALUSrcB 	       <= 2'b00;
					RegWrite 	       <= 0;
					RegDst 		       <= 0;
				end
			endcase 
    	end 
    end
	
endmodule
