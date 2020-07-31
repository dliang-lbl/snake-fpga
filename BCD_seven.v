`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:17 02/09/2020 
// Design Name: 
// Module Name:    BCD_seven 
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
module BCD_seven(digit, CA_CG, AN, clk);
	
	input [15:0] digit;
	input clk;
	
	//display
	output reg [6:0] CA_CG;
	output reg [3:0] AN;
	
	reg [3:0] val;
	
	initial begin
		CA_CG = 7'b1111111;
		AN = 4'b1110;
		val = digit[3:0];
	end
	
	always @(posedge clk)
	begin
		case(AN)
			4'b1011: val <= digit[3:0];
			4'b0111: val <= digit[7:4];
			4'b1110: val <= digit[11:8];
			4'b1101: val <= digit[15:12];
		endcase
		
		AN <= {AN[2:0], AN[3]};
		
		case(val)
			4'b0000: CA_CG <= 7'b1000000;
			4'b0001: CA_CG <= 7'b1111001;
			4'b0010: CA_CG <= 7'b0100100;
			4'b0011: CA_CG <= 7'b0110000;
			4'b0100: CA_CG <= 7'b0011001;
			4'b0101: CA_CG <= 7'b0010010;
			4'b0110: CA_CG <= 7'b0000010;
			4'b0111: CA_CG <= 7'b1111000;
			4'b1000: CA_CG <= 7'b0000000;
			4'b1001: CA_CG <= 7'b0010000;	
		endcase
	end
  


endmodule
