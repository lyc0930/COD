`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 12:32:05
// Design Name: 
// Module Name: Queue
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


module Queue #(parameter M = 8, N = 4)(en_out, en_in, in, CLK100MHZ, reset, Display, out, empty, full);
	input en_out, en_in;
	input CLK100MHZ, reset;
	input [N - 1 : 0] in;
	output reg [N - 1 : 0] out;
	output empty, full;
	output [15 : 0] Display;//[15 : 8] an [7] dp [6 : 0] seg  
	
	wire CLK5MHZ, clock;
	wire [2 : 0] pulse;
	wire [N - 1 : 0] EnQueue_Data, DeQueue_Data, Queue_Data;
	wire Enable_in, Enable_out;
	wire [(M >> 1) - 1 : 0] EnQueue_Address;//1 : 8
	reg [(M >> 1) - 2 : 0] head, rear;
	reg tag;
	
	// use 4'b1111 as nothing
	clk_wiz_0 CLK100MHZ_to_5MHZ (CLK5MHZ, CLK100MHZ);
	FrequencyDivision CLK5MHZ_to_1sPulse (CLK5MHZ, 'b0, clock);
	SegmentPulse CLK100MHZ_to_SegmentChoose (CLK100MHZ, 'b0, pulse);
	RegisterFile #((M >> 1), 4) QUEUE (head + 'b1, pulse + 'b1, EnQueue_Address, EnQueue_Data, Enable_in ^ Enable_out, clock, ~reset, DeQueue_Data, Queue_Data);
	BCD_to_7Segment ENCODE (Queue_Data, Display[6 : 0]);
	
	assign empty = (head == rear) && (tag == 'b0);
	assign full = (head == rear) && (tag == 'b1);
	assign Enable_in = en_in && ~full;
	assign Enable_out = en_out && ~empty;
	assign EnQueue_Address = ((Enable_in) ? rear : head) + 'b1;
	assign EnQueue_Data = (Enable_in) ? in : 4'b1111;
	assign Display[7] = (pulse == head) ? 0 : 1; 
	assign Display[8] = (pulse == 'd7) ? 0 : 1;
	assign Display[9] = (pulse == 'd6) ? 0 : 1;
	assign Display[10] = (pulse == 'd5) ? 0 : 1;
	assign Display[11] = (pulse == 'd4) ? 0 : 1;
	assign Display[12] = (pulse == 'd3) ? 0 : 1;
	assign Display[13] = (pulse == 'd2) ? 0 : 1;
	assign Display[14] = (pulse == 'd1) ? 0 : 1;
	assign Display[15] = (pulse == 'd0) ? 0 : 1;
	
	always @(posedge clock or posedge reset)
	begin
		if (reset)
		begin
			tag <= 'b0;
			out <= 4'b0000;
			head <= 'b0;
			rear <= 'b0;
		end
		else if (Enable_in ^ Enable_out)
		begin
			if (Enable_in)
			begin
//				EnQueue_Address <= rear;
				rear <= rear + 'b1;
				tag <= 'b1;
			end
			else if (Enable_out)
			begin
				out <= DeQueue_Data;
//				EnQueue_Address <= head;
				head <= head + 'b1;
				tag <= 'b0;
			end
		end
	end
endmodule
