`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:34:41 06/28/2013 
// Design Name: 
// Module Name:    LTU_ROM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LTU_ROM (				Clk, 
									Addr, 
									Data
								);

input 						Clk;
input 		[4:0] 		Addr;
output reg 	[31:0] 			Data; //the equivalent shift value

parameter  			atan_table[00] = 32'b0010_0000_0000_0000_0000_0000_0000_0000,
						atan_table[01] = 32'b0001_0010_1110_0100_0000_0101_0001_1110,
						atan_table[02] = 32'b0000_1001_1111_1011_0011_1000_0101_1011,
						atan_table[03] = 32'b0000_0101_0001_0001_0001_0001_1101_0100,
						atan_table[04] = 32'b0000_0010_1000_1011_0000_1101_0100_0011,
						atan_table[05] = 32'b0000_0001_0100_0101_1101_0111_1110_0001,
						atan_table[06] = 32'b0000_0000_1010_0010_1111_0110_0001_1110,
						atan_table[07] = 32'b0000_0000_0101_0001_0111_1100_0101_0101,
						atan_table[08] = 32'b0000_0000_0010_1000_1011_1110_0101_0011,
						atan_table[09] = 32'b0000_0000_0001_0100_0101_1111_0010_1111,
						atan_table[10] = 32'b0000_0000_0000_1010_0010_1111_1001_1000,
						atan_table[11] = 32'b0000_0000_0000_0101_0001_0111_1100_1100,
						atan_table[12] = 32'b0000_0000_0000_0010_1000_1011_1110_0110,
						atan_table[13] = 32'b0000_0000_0000_0001_0100_0101_1111_0011,
						atan_table[14] = 32'b0000_0000_0000_0000_1010_0010_1111_1010,
						atan_table[15] = 32'b0000_0000_0000_0000_0101_0001_0111_1101,
						atan_table[16] = 32'b0000_0000_0000_0000_0010_1000_1011_1110,
						atan_table[17] = 32'b0000_0000_0000_0000_0001_0100_0101_1111,
						atan_table[18] = 32'b0000_0000_0000_0000_0000_1010_0011_0000,
						atan_table[19] = 32'b0000_0000_0000_0000_0000_0101_0001_1000,
						atan_table[20] = 32'b0000_0000_0000_0000_0000_0010_1000_1100,
						atan_table[21] = 32'b0000_0000_0000_0000_0000_0001_0100_0110,
						atan_table[22] = 32'b0000_0000_0000_0000_0000_0000_1010_0011,
						atan_table[23] = 32'b0000_0000_0000_0000_0000_0000_0101_0001,
						atan_table[24] = 32'b0000_0000_0000_0000_0000_0000_0010_1001,
						atan_table[25] = 32'b0000_0000_0000_0000_0000_0000_0001_0100,
						atan_table[26] = 32'b0000_0000_0000_0000_0000_0000_0000_1010,
						atan_table[27] = 32'b0000_0000_0000_0000_0000_0000_0000_0101,
						atan_table[28] = 32'b0000_0000_0000_0000_0000_0000_0000_0011,
						atan_table[29] = 32'b0000_0000_0000_0000_0000_0000_0000_0010,
						atan_table[30] = 32'b0000_0000_0000_0000_0000_0000_0000_0001,
						atan_table[31] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			
always @(posedge Clk) 
begin
			
					case(Addr)
					5'b00000: Data <= atan_table00;
					5'b00001: Data <= atan_table01;
					5'b00010: Data <= atan_table02;
					5'b00011: Data <= atan_table03;
					5'b00100: Data <= atan_table04;
					5'b00101: Data <= atan_table05;
					5'b00110: Data <= atan_table06;
					5'b00111: Data <= atan_table07;
					5'b01000: Data <= atan_table08;
					5'b01001: Data <= atan_table09;
					5'b01010: Data <= atan_table10;
					5'b01011: Data <= atan_table11;
					5'b01100: Data <= atan_table12;
					5'b01101: Data <= atan_table13;
					5'b01110: Data <= atan_table14;
					5'b01111: Data <= atan_table15;
					5'b10000: Data <= atan_table16;
					5'b10001: Data <= atan_table17;
					5'b10010: Data <= atan_table18;
					5'b10011: Data <= atan_table19;
					5'b10100: Data <= atan_table20;
					5'b10101: Data <= atan_table21;
					5'b10110: Data <= atan_table22;
					5'b10111: Data <= atan_table23;
					5'b11000: Data <= atan_table24;
					5'b11001: Data <= atan_table25;
					5'b11010: Data <= atan_table26;
					5'b11011: Data <= atan_table27;
					5'b11100: Data <= atan_table28;
					5'b11101: Data <= atan_table29;
					5'b11110: Data <= atan_table30;
					5'b11111: Data <= atan_table31;
			endcase
end
endmodule
