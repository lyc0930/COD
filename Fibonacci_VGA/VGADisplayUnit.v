`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 16:51:37
// Design Name: 
// Module Name: VGADisplayUnit
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


module VGADisplayUnit(RGB, CLK100MHZ, reset, X, Y, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);
	input [11 : 0] RGB;
	input CLK100MHZ, reset;
	output [7 : 0] X, Y;
	output [3 : 0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
	
	wire CLK50MHZ;
	wire [9 : 0] Point_X, Point_Y;
	wire DisplayEnable;

	//---------VGA signal------------
	//800x600@72Hz
	parameter H_PERIOD = 1040, 
				HSPW = 120, 
				HBP = 64, 
				H_Length = 800, 
				HFP = 56; 
	parameter V_PERIOD = 666, 
				VSPW = 6, 
				VBP = 23, 
				V_Length = 600, 
				VFP = 37;
				
	Clocking_Wizard_1 CLK100MHZ_to_CLK50MHZ (CLK50MHZ, CLK100MHZ);
	Counter H_COUNT (CLK50MHZ, 0, H_PERIOD, Point_X);
	Counter V_COUNT (~(Point_X[9]), 0, V_PERIOD, Point_Y);

	// SPW|BP|Length|FP
	assign VGA_HS = ~(Point_X < HSPW);
	assign VGA_VS = ~(Point_Y < VSPW);
	assign DisplayEnable = 	   (Point_Y >= (VSPW + VBP)) 
							&& (Point_Y < (V_PERIOD - VFP)) 
							&& (Point_X >= (HSPW + HBP)) 
							&& (Point_X < (H_PERIOD - HFP));
	assign VGA_R = DisplayEnable ? RGB[11 : 8] : 0;
	assign VGA_G = DisplayEnable ? RGB[ 7 : 4] : 0;
	assign VGA_B = DisplayEnable ? RGB[ 3 : 0] : 0;
	//-------------------------------
	assign X = Point_X - (HSPW + HBP);
	assign Y = Point_Y - (VSPW + VBP);

endmodule
