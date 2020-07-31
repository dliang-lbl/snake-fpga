`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:59:16 03/10/2020
// Design Name:   main
// Module Name:   C:/Users/15105/cs152a/lab4/src/tb/seg_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module seg_tb;

	// Inputs
	reg clk;
	reg rst;
	reg btnu;
	reg btnd;
	reg btnl;
	reg btnr;
	reg paused;
	reg speed;

	// Outputs
	wire [7:0] rgb;
	wire Hsync;
	wire Vsync;
	wire [3:0] an;
	wire [6:0] seg;
	wire [9:0] h_counter;
	wire [9:0] v_counter;
	wire [9:0] score;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.rst(rst), 
		.rgb(rgb), 
		.Hsync(Hsync), 
		.Vsync(Vsync), 
		.an(an), 
		.seg(seg), 
		.btnu(btnu), 
		.btnd(btnd), 
		.btnl(btnl), 
		.btnr(btnr), 
		.paused(paused), 
		.speed(speed), 
		.score(score),
		.h_counter(h_counter), 
		.v_counter(v_counter)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		btnu = 0;
		btnd = 0;
		btnl = 0;
		btnr = 0;
		paused = 0;
		speed = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always begin
		#1 clk <= ~clk;
	end
      
endmodule

