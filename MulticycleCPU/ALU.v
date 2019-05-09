`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 14:20:41
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter  DIGIT = 32, CTRLSIZE = 4, FLAGSIZE = 4)(Control, A, B, Out, Flags);
    input  wire [CTRLSIZE - 1 : 0] Control;
    input  wire    [DIGIT - 1 : 0] A;
    input  wire    [DIGIT - 1 : 0] B;
    
    output  reg    [DIGIT - 1 : 0] Out;
    output wire [FLAGSIZE - 1 : 0] Flags;

    wire Carry_Borrow, Negative, Overflow, Zero;
    wire Carry, Borrow;
    wire [DIGIT - 1 : 0] add_sum, minus_sum;

    always @(*)
    begin
    	case (Control)
    		4'b0000: Out = A + B;
    		4'b0001: Out = A + (~B + 'b1);//(F == 1) ? (('b1 << 6) - minus_sum) : minus_sum;
    		4'b1000: Out = A & B;
    		4'b1001: Out = A | B;
    		4'b1010: Out = ~A;
    		4'b1011: Out = ~(A | B);
    		4'b1100: Out = A ^ B;
    		4'b1101: Out = (A < B) ? 'b1 : 'b0;
    		default: 
    			Out = 'b0;
    	endcase 
    end

    assign Flags               = {Carry_Borrow, Negative, Overflow, Zero};
    assign Carry_Borrow        = ~Control[CTRLSIZE - 1] && ((Control[0] == 0) ? Carry : Borrow);
    assign {Carry, add_sum}    = A + B;
    assign {Borrow, minus_sum} = A - B;	
    assign Negative            = ~Control[CTRLSIZE - 1] && (Overflow ^ Out[DIGIT - 1]);
    assign Overflow            = ~Control[CTRLSIZE - 1] && ((Control[0] ^~ (A[DIGIT - 1] ^ B[DIGIT - 1])) && (A[DIGIT - 1] ^ Out[DIGIT - 1]));
    assign Zero                = (Out == 'b0);

endmodule
