`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 15:25:53
// Design Name: 
// Module Name: RegisterFile_tb
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


module RegisterFile_tb();
	reg Write_Enable;
	reg [5 : 0] Read_Address_0, Read_Address_1;
	reg [5 : 0] Write_Address;
	reg [31 : 0] Write_Data;
	wire [31 : 0] Read_Data_0, Read_Data_1;
	reg reset;
	wire clock;
	GenerateClock CLK (clock);
	RegisterFile DUT (.Read_Address_0(Read_Address_0), .Read_Address_1(Read_Address_1), .Write_Address(Write_Address), .Write_Data(Write_Data), .Write_Enable(Write_Enable), .clock(clock), .reset(reset), .Read_Data_0(Read_Data_0), .Read_Data_1(Read_Data_1));
	
	initial
	begin
		reset = 'b1;#10;
		reset = 'b0;
		Read_Address_0 = 'd3;
		Read_Address_1 = 'd5;
		
		Write_Data = 32'b11000000;
		Write_Address = 'd3;
		Write_Enable = 'b1;#10;
		Write_Enable = 'b0;
		#10;
		Write_Data = 32'b1100111000;
		Write_Address = 'd5;
		Write_Enable = 'b1;#10;
		Write_Enable = 'b0;
		#10;
		Write_Data = 32'b11;
		Write_Address = 'd3;
		Write_Enable = 'b1;#10;
		Write_Enable = 'b0;
		
		reset = 'b1;#10;
		reset = 'b0;
		Read_Address_0 = 'd2;
		Read_Address_1 = 'd3;
		
		Write_Data = 32'b01;
		Write_Address = 'd3;
		Write_Enable = 'b1;#10;
		Write_Enable = 'b0;
	end
	
endmodule