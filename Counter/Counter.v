`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 21:01:24
// Design Name: 
// Module Name: Counter
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


module Counter #(parameter N = 4)(Data, Set_Enable, Count_Enable, reset, CLK100MHZ, Q);
    input [N - 1 : 0] Data;
    input Set_Enable, Count_Enable;
    input reset, CLK100MHZ;
    output [N - 1 : 0] Q;
    
    reg [N - 1 : 0] Count;
    wire CLK5MHZ, clock;
    
    clk_wiz_0 CLK100M_to_5M (CLK5MHZ, CLK100MHZ);
    FrequencyDivision CLK5M_to_1k (CLK5MHZ, 0, clock);
    assign Q = Count;
    
    always @(posedge clock or posedge reset)
    begin
    	if (reset)
    		Count <= 0;
    	else
    	begin
    		if (Set_Enable)
				Count <= Data; 
    		else if (Count_Enable)
				Count <= Count + 1;
		end
	end
endmodule
