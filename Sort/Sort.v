`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 12:37:41
// Design Name: 
// Module Name: Sort
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


module Sort(x0, x1, x2, x3, reset, clock, s0, s1, s2, s3, done);
	parameter DIGIT = 4;
	input wire [DIGIT - 1 : 0] x0, x1, x2, x3;
	input wire reset, clock;
	output reg [DIGIT - 1 : 0] s0, s1, s2, s3;
	output reg done;
//	reg [DIGIT - 1 : 0] r0, r1, r2, r3;
	reg [2 : 0] currentstate, nextstate;
	reg [DIGIT - 1 : 0] count;
	parameter State_Disorder = 3'b001, 
			  State_01Inorder = 3'b010,
			  State_012Inorder = 3'b100;
//			  State_0123Inorder = 4'b1000;
			  
//	task Swap;
//		inout [DIGIT - 1 : 0] a, b;
//		reg [DIGIT - 1 : 0] temp;
		
//		begin
//			temp = a;
//			a = b;
//			b = temp;
//		end
//	endtask 
	
	always @(posedge clock or posedge reset)
	begin
		if (reset)
			currentstate <= State_Disorder;
		else
			currentstate <= nextstate;
	end
	
	always @(*)
	begin
		case (currentstate)
			State_Disorder:
			begin
				if (count != 3'b000)
				begin
					if (s0 > s1)
						nextstate <= State_01Inorder;
					else
						nextstate <= State_01Inorder;
				end
			end
			
			State_01Inorder:
			begin
				if (s1 > s2)
					nextstate <= State_Disorder;
				else
					nextstate <= State_012Inorder;
			end
			
			State_012Inorder:
			begin
				if (s2 > s3)
					nextstate <= State_Disorder;
				else
					nextstate <= State_012Inorder;
			end
			
			default :
				nextstate <= State_Disorder;
		endcase 
	end
	
	always @(posedge clock or posedge reset)
	begin
		if (reset) 
		begin
			count <= 'b0;
			s0 <= x0;
			s1 <= x1;
			s2 <= x2;
			s3 <= x3;
			done <= 'b0;
		end
		else
		begin
			count <= count + 'b1;
			done <= 'b0;
			case (currentstate)
				State_Disorder:
				begin
					if (s0 > s1)
					begin
						s0 <= s1;
						s1 <= s0;
					end
				end
				
				State_01Inorder:
				begin
					if (s1 > s2)
					begin
						s1 <= s2;
						s2 <= s1;
					end
				end
				
				State_012Inorder:
				begin
					if (s2 > s3)
					begin
						s2 <= s3;
						s3 <= s2;
					end
					else
					done <= 'b1;
				end

				default :
					done <= 'b0;
			endcase 
		end			
	end

endmodule
