`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:25:37 07/01/2013
// Design Name:   Cordic
// Module Name:   D:/new_folder/sequential_logic/Cordic_processor_Qvalue_Ivalue/Cordic_tb.v
// Project Name:  Cordic_processor_Qvalue_Ivalue
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Cordic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Cordic_tb;

	// Inputs
	reg clk;
	reg [31:0] phase_step;
	reg [15:0] xin;
	reg [15:0] yin;

	// Outputs
	wire [21:0] xout;
	wire [21:0] yout;

	// Instantiate the Unit Under Test (UUT)
	Cordic uut (
		.clk(clk), 
		.phase_step(phase_step), 
		.xin(xin), 
		.yin(yin), 
		.xout(xout), 
		.yout(yout)
	);
	initial begin
			clk = 0;
			forever #10 clk=~clk;
	end
	initial begin
		// Initialize Inputs
		phase_step = 32'b00110101_01010101_01010101_01010101;
		xin = 16'd10000;
		yin = 16'd0;

		// Wait 100 ns for global reset to finish
		#100;
      phase_step = 32'b00110101_01010101_01010101_01010101;
		xin = 16'd10000;
		yin = 16'd0;
  
		// Add stimulus here

	end
      
endmodule

