`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 16:37:26
// Design Name: 
// Module Name: DebugandDisplayUnit
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


module DebugandDisplayUnit #(DIGIT = 32, DEBUGSIZE = 8)(CLK100MHZ, reset, continue, step, probe, inc, dec, ProbePC, ProbeMemData, ProbeRegData, run, clock, ProbeAddress, DisplayPC, AN, seg);
	input CLK100MHZ, reset;
	input continue, step, probe, inc, dec;
	input  [DEBUGSIZE - 1 : 0] ProbePC; 
	input      [DIGIT - 1 : 0] ProbeMemData, ProbeRegData;
	
	output run;
	output clock;
	output [DEBUGSIZE - 1 : 0] ProbeAddress;
	output [DEBUGSIZE - 1 : 0] DisplayPC; 
	output             [7 : 0] AN;
	output             [6 : 0] seg;
	
	wire CLK5MHZ;
	wire singlePulse;

	wire inc_s, dec_s;
	reg [DEBUGSIZE - 1 : 0] increment;
	reg [DEBUGSIZE - 1 : 0] decrement;

	wire         [2 : 0] pulse;
	wire [DIGIT - 1 : 0] DisplayData;
	reg          [3 : 0] SegmentData;

	initial
	begin
		SegmentData  = 'b0;
		increment    = 'b0;
		decrement    = 'b0;
	end

	// Clock, running control
	ClockWizard        CLK100MHZ_to_5MHZ (CLK5MHZ, CLK100MHZ);
	FrequencyDivision  SecondPulse       (CLK5MHZ, 'b0, clock);
	SinglePulse        SingleSecondPulse (clock, reset, step, singlePulse);
	assign run = (continue ? 1 : singlePulse);
	
	// Address change
	Debounce           incStabilize      (CLK5MHZ, inc, inc_s);
	Debounce           decStabilize      (CLK5MHZ, dec, dec_s);
	assign ProbeAddress = increment + decrement;
	
	always @(posedge inc_s or posedge reset)
	begin
		if (reset)
			increment <= 'b0;
		else
		begin
			if (inc_s)
				increment <= increment + 'b1;
		end
	end	
	
	always @(posedge dec_s or posedge reset)
	begin
		if (reset)
			decrement <= 'b0;
		else
		begin
			if (dec_s)
				decrement <= decrement - 'b1;
		end
	end	
	
	// LED
	assign DisplayPC = ProbePC;
	
	// 7 Segment Display
	DisplayPulse       SegmentChoose     (CLK100MHZ, 'b0, pulse); 
	Hex7SegmentDisplay SegmentDisplay    (SegmentData, seg);

	assign DisplayData = (probe ? ProbeMemData : ProbeRegData);
	
	always @(*)
	begin
		case (pulse)
			'd0: SegmentData <= DisplayData[ 3 :  0];
			'd1: SegmentData <= DisplayData[ 7 :  4];
			'd2: SegmentData <= DisplayData[11 :  8];
			'd3: SegmentData <= DisplayData[15 : 12];
			'd4: SegmentData <= DisplayData[19 : 16];
			'd5: SegmentData <= DisplayData[23 : 20];
			'd6: SegmentData <= DisplayData[27 : 24];
			'd7: SegmentData <= DisplayData[31 : 28];
		endcase 
	end

	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) 
		begin: SegmentDisplaySignal
			assign AN[i] = (pulse == i) ? 0 : 1;
		end
	endgenerate

	
endmodule
