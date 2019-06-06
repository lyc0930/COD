`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:41:04
// Design Name: 
// Module Name: Extend
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


module SignExtend #(parameter INDIGIT = 16,OUTDIGIT = 32)(In, Out);
    input  [ INDIGIT - 1 : 0] In;
    output [OUTDIGIT - 1 : 0] Out;
    
    assign Out = {{OUTDIGIT - INDIGIT{In[INDIGIT - 1]}}, In};
endmodule

module ZeroExtend #(parameter INDIGIT = 16,OUTDIGIT = 32)(In, Out);
    input  [ INDIGIT - 1 : 0] In;
    output [OUTDIGIT - 1 : 0] Out;
    
    assign Out = {{OUTDIGIT - INDIGIT{1'b0}}, In};
endmodule
