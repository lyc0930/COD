`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 17:55:11
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile #(parameter M = 3, N = 4)(Read_Address_0, Read_Address_1, Write_Address, Write_Data, Write_Enable, CLK100MHZ, reset, Read_Data_0, Read_Data_1);
	input CLK100MHZ, reset;
	input Write_Enable;
	input [M - 1 : 0] Read_Address_0, Read_Address_1;
	input [M - 1 : 0] Write_Address;
	input [N - 1 : 0] Write_Data;
	output [N - 1 : 0] Read_Data_0, Read_Data_1;
	
	reg [N - 1 : 0] Register [1 : (1 << M) - 1];
	integer i;
	
	assign Read_Data_0 = (Read_Address_0 == 0) ? 0 : Register[Read_Address_0];
	assign Read_Data_1 = (Read_Address_1 == 0) ? 0 : Register[Read_Address_1];
	
	always  @(posedge CLK100MHZ or negedge reset)
	begin
		if (~reset)
		begin
			for (i = 1; i < N; i = i + 1)
				Register[i] <= (1 << N) - 'b1;
		end
		else
		begin
			if ((Write_Address != 0) && Write_Enable)
				Register[Write_Address] <= Write_Data;
		end
	end
endmodule
