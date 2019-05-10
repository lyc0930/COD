`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 15:37:56
// Design Name: 
// Module Name: SignExtend
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


module SignExtend #(parameter DIGIT = 16)(In, Out);
    input      [DIGIT - 1 : 0] In;
    
    output [2 * DIGIT - 1 : 0] Out;
    
    assign Out[    DIGIT - 1 : 0    ] = In;
    assign Out[2 * DIGIT - 1 : DIGIT] = In[DIGIT - 1] ? {DIGIT{1'b1}} : {DIGIT{1'b0}};
endmodule
