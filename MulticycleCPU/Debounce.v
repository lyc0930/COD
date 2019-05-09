`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 14:26:43
// Design Name: 
// Module Name: Debounce
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


module Debounce(
    input clock,
    input button,
    output reg button_s
    );
    
    reg [20 : 0] count;
    reg count_enable;
    
    parameter LIMIT = 100_000; // 5MHz --> 20ms
    
    always @(posedge clock)
    begin
    	if (count == LIMIT - 1)
    		button_s <= button;
    end
    
    always @(posedge clock)
    begin
    	if (count_enable)
    		count <= count + 'b1;
    	else
    		count <= 'b0;
    end
    
    always @(posedge clock)
    begin
    	if (~count_enable && (button != button_s))
    		count_enable <= 1;
    	else
    		if (count == LIMIT - 1)
    			count_enable <= 0;
    end
    
endmodule
