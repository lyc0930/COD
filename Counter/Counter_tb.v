`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 21:16:35
// Design Name: 
// Module Name: Counter_tb
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


module Counter_tb();
	reg [3 : 0] Data;
	reg Set_Enable, Count_Enable;
	reg reset;
	wire clock;
	wire [3 : 0] Q;
	
	GenerateClock CLK (clock);
	Counter DUT (.Data(Data), .Set_Enable(Set_Enable), .Count_Enable(Count_Enable), .reset(reset), .clock(clock), .Q(Q));
	
	initial
	begin
		Data = 4'b0110;
		reset = 'b1;#10;
		reset = 'b0;#10;
		Count_Enable = 'b1;#70;
		Set_Enable = 'b1;#10;
		Count_Enable = 'b0;#20;
		reset = 'b1;#10;
		Set_Enable ='b0;
		Count_Enable = 'b1;#20;
		reset = 'b0;
		Count_Enable = 'b1;#60;
		Count_Enable = 'b0;
	end
endmodule
