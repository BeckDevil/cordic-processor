`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:46 06/16/2013 
// Design Name: 
// Module Name:    Cordic 
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
module Cordic(clk,phase_step,xin,yin,xout,yout);

parameter IN_WIDTH	= 16;//adc bit width
parameter EXTRA_BITS	= 6;//for better resolution and noise reduction

localparam WI			= IN_WIDTH;
localparam WXY			= IN_WIDTH+EXTRA_BITS;//22 bit data registers
localparam STG			= WXY;//no of stages STG>WXY results zero as x ix shifted right more times than no of bits in x

input clk;
input signed  [31:0]    phase_step;//ratio of f0 to fs .Thus theta=2*pi*f0/fs is represented as 32 bit number
input signed  [WI-1:0]  xin,yin;
output signed [WXY-1:0] xout,yout;

wire signed [31:0] atan_table [0:31];
                 assign atan_table[00] = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
						assign atan_table[01] = 32'b0001_0010_1110_0100_0000_0101_0001_1110;
						assign atan_table[02] = 32'b0000_1001_1111_1011_0011_1000_0101_1011;
						assign atan_table[03] = 32'b0000_0101_0001_0001_0001_0001_1101_0100;
						assign atan_table[04] = 32'b0000_0010_1000_1011_0000_1101_0100_0011;
						assign atan_table[05] = 32'b0000_0001_0100_0101_1101_0111_1110_0001;
						assign atan_table[06] = 32'b0000_0000_1010_0010_1111_0110_0001_1110;
						assign atan_table[07] = 32'b0000_0000_0101_0001_0111_1100_0101_0101;
						assign atan_table[08] = 32'b0000_0000_0010_1000_1011_1110_0101_0011;
						assign atan_table[09] = 32'b0000_0000_0001_0100_0101_1111_0010_1111;
						assign atan_table[10] = 32'b0000_0000_0000_1010_0010_1111_1001_1000;
						assign atan_table[11] = 32'b0000_0000_0000_0101_0001_0111_1100_1100;
						assign atan_table[12] = 32'b0000_0000_0000_0010_1000_1011_1110_0110;
						assign atan_table[13] = 32'b0000_0000_0000_0001_0100_0101_1111_0011;
						assign atan_table[14] = 32'b0000_0000_0000_0000_1010_0010_1111_1010;
						assign atan_table[15] = 32'b0000_0000_0000_0000_0101_0001_0111_1101;
						assign atan_table[16] = 32'b0000_0000_0000_0000_0010_1000_1011_1110;
						assign atan_table[17] = 32'b0000_0000_0000_0000_0001_0100_0101_1111;
						assign atan_table[18] = 32'b0000_0000_0000_0000_0000_1010_0011_0000;
						assign atan_table[19] = 32'b0000_0000_0000_0000_0000_0101_0001_1000;
						assign atan_table[20] = 32'b0000_0000_0000_0000_0000_0010_1000_1100;
						assign atan_table[21] = 32'b0000_0000_0000_0000_0000_0001_0100_0110;
						assign atan_table[22] = 32'b0000_0000_0000_0000_0000_0000_1010_0011;
						assign atan_table[23] = 32'b0000_0000_0000_0000_0000_0000_0101_0001;
						assign atan_table[24] = 32'b0000_0000_0000_0000_0000_0000_0010_1001;
						assign atan_table[25] = 32'b0000_0000_0000_0000_0000_0000_0001_0100;
						assign atan_table[26] = 32'b0000_0000_0000_0000_0000_0000_0000_1010;
						assign atan_table[27] = 32'b0000_0000_0000_0000_0000_0000_0000_0101;
						assign atan_table[28] = 32'b0000_0000_0000_0000_0000_0000_0000_0011;
						assign atan_table[29] = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
						assign atan_table[30] = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
						assign atan_table[31] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
                  

//registers
//stage outputs for iterations
reg signed [WXY-1:0] X [0:STG-1];
reg signed [WXY-1:0] Y [0:STG-1];
reg signed [31:0]    Z [0:STG-1];//32 bit angle value
reg [31:0] phase_acc;

// wire variables
wire [1:0]  quadrant = phase_acc [31:30];//the quardant value

wire signed [WI-1:0] nxin,nyin;

assign nxin = -xin;
assign nyin = -yin;


//for iteration stage=0
always @(posedge clk)
	begin
		//we have to make sure that the rotation angle is between range -pi/2 to pi/2.
		//IF angle is not in this range we have to make some prerotations to reduce angles within this range
		case(quadrant)
			2'b00,2'b11://no pre rotation required
				begin //since  A=1.64 we have to divide by 2 and multiply by 2^EXTRA_BITS ie equivalent to left
						//shift by EXTRA_BITS-1				
					X[0] <= {xin[WI-1],xin}<<{EXTRA_BITS-1};
					Y[0] <= {yin[WI-1],yin}<<{EXTRA_BITS-1};
					Z[0] <= phase_acc ;
				end
			2'b01:
				begin
					X[0] <= {nyin[WI-1],nyin}<<{EXTRA_BITS-1};
					Y[0] <= {xin[WI-1],xin}<<{EXTRA_BITS-1};
					Z[0] <= {2'b00,phase_acc[29:0]};//subtract pi/2 from angle so that angle lies within range of first quadrant
				end
			2'b10:
				begin
					X[0] <= {yin[WI-1],yin}<<{EXTRA_BITS-1};
					Y[0] <= {nxin[WI-1],nxin}<<{EXTRA_BITS-1};
					Z[0] <= {2'b11,phase_step[29:0]};
				end
			default:;
		endcase
		phase_acc<=phase_acc+phase_step;
	end


//for stage 1 to STG-1
genvar i;
generate
	for(i=0;i<(STG-1);i=i+1)
	
	begin:ITERATION
	wire z_sign;
	wire signed [WXY-1:0] x_shr,y_shr;
	assign x_shr=X[0]>>>i;
	assign y_shr=Y[0]>>>i;
	assign z_sign=Z[i][31];
	
	always @ (posedge clk)
			begin
				//ADD or subtract the shifted data
				X[i+1] = z_sign?(X[i]+y_shr):(X[i]-y_shr);
				Y[i+1] = z_sign?(Y[i]-x_shr):(Y[i]+x_shr);
				Z[i+1] = z_sign?(Z[i]+atan_table[i]):(Z[i]-atan_table[i]);
				end
			
	end
endgenerate
assign xout	=	X[STG-1];
assign yout	=	Y[STG-1];
endmodule
