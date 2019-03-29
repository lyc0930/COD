`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 16:37:32
// Design Name: 
// Module Name: DIV
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


module DIV (clock, reset, x, y, q, r, error, done);// currentstate, nextstate, count, Data);
	parameter N = 4;
	parameter State_Begin = 3'b001,
			  State_Shift = 3'b010,
			  State_Finish = 3'b100;
	input clock;
	input reset;
	input [N - 1 : 0] x;
	input [N - 1 : 0] y;
	output wire [N - 1 : 0] q;
	output wire [N - 1 : 0] r;
	output reg error, done;
//	output reg [2 : 0] currentstate, nextstate;
//	output reg [N - 1 : 0] count;
//	output reg [2 * N - 1 : 0] Data;
	reg [2 : 0] currentstate, nextstate;
	reg [N - 1 : 0] count;
	reg [2 * N - 1 : 0] Data;

	
	always @(posedge clock or posedge reset)
	begin
		if (reset)
			currentstate <= State_Begin;
		else
			currentstate <= nextstate;
	end
	
	always @(*)
	begin
		case (currentstate)
			State_Begin:
			begin
				if (y == 0)
					nextstate = State_Begin;
				else
				begin
					if (count == N)
						nextstate = State_Shift;
					else
						nextstate = State_Begin;
				end
			end
			
			State_Shift:
			begin				
    			if (count < 'd2)
    				nextstate = State_Finish;
    			else
    				nextstate = State_Shift;
    		end
    		
    		State_Finish:
    			nextstate = State_Finish;

    		default :
    			nextstate = State_Begin;
    	endcase 
    end
    
    always @(posedge clock or posedge reset)
	begin
		if (reset)
		begin
			count <= N;
			done <= 1'b0;
			error <= 1'b0;
		end
		else
		begin
			case (currentstate)
				State_Begin:
				begin
					if (y == 0)
					begin
						error <= 1'b1;
						Data <= 0;
					end
					else
					begin
						if (count == N)
							Data <= {{N{1'b0}}, x};
					end
				end
				
				State_Shift:
				begin
					count <= count - 3'b001;				
					if (Data[(2 * N - 2) : N - 1] >= y)
						Data <= (Data << 1) + 1'b1 - (y << N);
					else
						Data <= (Data << 1);
				end
				
				State_Finish:
					done <= 1'b1;
					
				default :
				begin
					done <= 1'b0;
					error <= 1'b0;
				end
			endcase
    	end 
    end
    
    assign q = Data[N - 1 : 0];
    assign r = Data[2 * N - 1 : N];
endmodule
