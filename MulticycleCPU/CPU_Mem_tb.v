`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/07 00:38:20
// Design Name: 
// Module Name: CPU_Mem_tb
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


module CPU_Mem_tb#(parameter DIGIT = 32, ADDRWIDTH = 16, DEBUGSIZE = 8) ();

	wire clock;
	reg reset;
	reg run; 
	wire MemWrite;
	reg  [DEBUGSIZE - 1 : 0] ProbeAddress;
	wire [ADDRWIDTH - 1 : 0] MemAddress;
	wire     [DIGIT - 1 : 0] MemData;
	wire     [DIGIT - 1 : 0] RegData;
	wire 	 [DIGIT - 1 : 0] ProbePC;
	wire     [DIGIT - 1 : 0] ProbeRegData;
	wire     [DIGIT - 1 : 0] ProbeMemData;
	
	GenerateClock CLK (clock);
	MulticycleCPU CPU (clock, reset, run, MemData, ProbeAddress, MemWrite, MemAddress, RegData, ProbePC, ProbeRegData);
	Memory        MEM (MemAddress[DEBUGSIZE + 1 : 2], RegData, ProbeAddress, clock, MemWrite, MemData, ProbeMemData);

	initial
	begin
		reset = 1;
		run = 1;
		ProbeAddress = 'b00000000; 
		#20;
		reset = 0;
//		#70;
		ProbeAddress = 'b00000000;  #80; //    j    _start
		ProbeAddress = 'b00001000;  #80; // t0 addi $t0,$0,3
		ProbeAddress = 'b00001001;  #80; // t1 addi $t1,$0,5
		ProbeAddress = 'b00001010;  #80; // t2 addi $t2,$0,1
		ProbeAddress = 'b00010000; #100; // s0 add  $s0,$t1,$t0
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,12($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 and  $s0,$t1,$t0
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,16($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 xor  $s0,$t1,$t0
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,20($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 nor  $s0,$t1,$t0
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,24($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 slt  $s0,$t0,$t1
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,28($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 andi $s0,$t0,7
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,32($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00010000; #100; // s0 ori  $s0,$t1,4
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,36($0)
		ProbeAddress = 'b00010000;  #80; // s0 bne  $s1,$s0,_fail
		ProbeAddress = 'b00001010; #100; // $10sw   $t1,40($0)
		ProbeAddress = 'b00010001; #120; // s1 lw   $s1,40($0)
		ProbeAddress = 'b00001010;  #80; // s0 beq  $t1,$s1,_sucess
		ProbeAddress = 'b00000010; #100; // $2 sw   $t2,8($0)
		#2930;
		ProbeAddress = 'b00000010;

	end
endmodule
