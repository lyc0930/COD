`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:38:44
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

module RegisterFile #(parameter REGSIZE = 5, DIGIT = 32)
(clock, reset, Read_Address_0, Read_Address_1, Read_Address_2, Write_Address, Write_Data, 
Write_Enable, Read_Data_0, Read_Data_1, Read_Data_2);
	input clock, reset;
	input Write_Enable;
	input  [REGSIZE - 1 : 0] Read_Address_0, Read_Address_1, Read_Address_2;
	input  [REGSIZE - 1 : 0] Write_Address;
	input    [DIGIT - 1 : 0] Write_Data;
	
	output   [DIGIT - 1 : 0] Read_Data_0, Read_Data_1, Read_Data_2;
	
	reg [DIGIT - 1 : 0] Register [1 : (1 << REGSIZE) - 1];
	integer i;
	
	assign Read_Data_0 = (Read_Address_0 == 0) ? 'b0 : (((Read_Address_0 == Write_Address) && Write_Enable) ? Write_Data : Register[Read_Address_0]);
	assign Read_Data_1 = (Read_Address_1 == 0) ? 'b0 : (((Read_Address_1 == Write_Address) && Write_Enable) ? Write_Data : Register[Read_Address_1]);
	assign Read_Data_2 = (Read_Address_2 == 0) ? 'b0 : (((Read_Address_2 == Write_Address) && Write_Enable) ? Write_Data : Register[Read_Address_2]);
	
	initial
	begin
		for (i = 1; i < DIGIT; i = i + 1)
			Register[i] = 'b0;
	end
	
	always  @(posedge clock or posedge reset)
	begin
		if (reset)
		begin
			for (i = 1; i < DIGIT; i = i + 1)
				Register[i] <= 0;
		end
		else
		begin
			if ((Write_Address != 0) && Write_Enable)
				Register[Write_Address] <= Write_Data;
		end
	end
endmodule
