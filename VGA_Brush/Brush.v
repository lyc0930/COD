`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 19:58:49
// Design Name: 
// Module Name: Brush
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


module Brush(Brush_Colour, BTNU, BTNL, BTNR, BTND, draw, CLK100MHZ, reset, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);
	input [11 : 0] Brush_Colour;
	input BTNU, BTNL, BTNR, BTND;
	input draw, CLK100MHZ, reset;
	output [3 : 0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
	
	wire CLK50MHZ, CLK10HZ;
	wire [9 : 0] Point_X, Point_Y;
	wire DisplayEnable;
	reg [11 : 0] RGB;
	reg [7 : 0] Cursor_X, Cursor_Y;
	wire [11 : 0] Board_Colour;
	wire IfCursor, IfSquare;
	wire [7 : 0] X, Y;
	wire [7 : 0] Write_X, Write_Y;
	wire [11 : 0] Write_Colour;
	wire Write_Clock;
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
				
	clk_wiz_0 CLK100MHZ_to_CLK50MHZ (CLK50MHZ, CLK100MHZ);
	Counter H_COUNT (CLK50MHZ, 0, H_PERIOD, Point_X);
	Counter V_COUNT (~(Point_X[9]), 0, V_PERIOD, Point_Y);
	/*
	// Length|FP|SPW|BP	
	assign VGA_HS = (Point_X < H_Length + HFP) || (Point_X >= H_PERIOD - HBP);
	assign VGA_VS = (Point_Y < V_Length + VFP) || (Point_Y >= V_PERIOD - VBP);
	assign DisplayEnable = (Point_X < H_Length) && (Point_Y < V_Length);
	assign VGA_R = (DisplayEnable) ? RGB[11:8] : 4'b0000;
	assign VGA_G = (DisplayEnable) ? RGB[7:4] : 4'b0000;
	assign VGA_B = (DisplayEnable) ? RGB[3:0] : 4'b0000;
	*/
	// SPW|BP|Length|FP
	assign VGA_HS = ~(Point_X < HSPW);
	assign VGA_VS = ~(Point_Y < VSPW);
	assign DisplayEnable = 	   (Point_Y >= (VSPW + VBP)) 
							&& (Point_Y < (V_PERIOD - VFP)) 
							&& (Point_X >= (HSPW + HBP)) 
							&& (Point_X < (H_PERIOD - HFP));
	assign VGA_R = DisplayEnable ? RGB[11:8] : 0;
	assign VGA_G = DisplayEnable ? RGB[7:4] : 0;
	assign VGA_B = DisplayEnable ? RGB[3:0] : 0;
	//-------------------------------
	assign IfSquare = 	   (('d272 + HSPW + HBP) <= Point_X) 
						&& (Point_X < ('d528 + HSPW + HBP)) 
						&& (('d172 + VSPW + VBP) < Point_Y) 
						&& (Point_Y < ('d428 + VSPW + VBP));
	assign X = IfSquare ? Point_X - ('d272 + HSPW + HBP) : 'b0;
	assign Y = IfSquare ? Point_Y - ('d172 + VSPW + VBP) : 'b0;
	assign Write_X = reset ? X : Cursor_X;
	assign Write_Y = reset ? Y : Cursor_Y;
	assign Write_Colour = reset ? 12'hfff : Brush_Colour;
	assign Write_Clock = reset ? CLK50MHZ : CLK10HZ;
	FrequencyDivision CLK50MHZ_to_CLK10HZ (CLK50MHZ, 'b0, CLK10HZ); 
	dist_mem_gen_0 VRAM ({Write_X, Write_Y}, Write_Colour, 
						{X, Y}, Write_Clock, 
						draw, Board_Colour);
	assign IfCursor = 	   ((X == Cursor_X) 
						&& (Y < Cursor_Y + 'd4) 
						&& (Y > Cursor_Y - 'd4)) 
						|| ((Y == Cursor_Y) 
						&& (X < Cursor_X + 'd4) 
						&& (X > Cursor_X - 'd4)); 
	

	//------Cursor movement---------
	always @(posedge CLK10HZ or posedge reset)
	begin
		if (reset)
		begin
			Cursor_X <= 'd128;
			Cursor_Y <= 'd128;
		end
		else
		begin
			case ({BTNL, BTNR})
				2'b10: Cursor_X <= Cursor_X - 'b1;
				2'b01: Cursor_X <= Cursor_X + 'b1;
				default: Cursor_X <= Cursor_X;
			endcase
			case ({BTNU, BTND})
				2'b10: Cursor_Y <= Cursor_Y - 'b1;
				2'b01: Cursor_Y <= Cursor_Y + 'b1;
				default: Cursor_Y <= Cursor_Y;
			endcase
		end
	end
	//-------------------------------
    //--------Colour set-------------
    always @(Point_X or Point_Y)
	begin
		if (reset)
		begin
			RGB <= 12'h000;
		end
		else
		begin
			case ({IfSquare, IfCursor})
				2'b00: RGB <= 12'h000;
				2'b10: RGB <= Board_Colour;
				2'b01: RGB <= 12'hFFF;
				2'b11: RGB <= 12'hFFF - Board_Colour;
			endcase 
		end
	end
	//-------------------------------
	
endmodule
