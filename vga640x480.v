`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:39 02/25/2020 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input  pixel_clk,			//pixel clock: 25MHz
	input  rst,			//asynchronous reset
	output  hsync,		//horizontal sync out
	output  vsync,		//vertical sync out
	output reg [9:0] h_counter,
	output reg [9:0] v_counter
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 35; 		// end of vertical back porch
parameter vfp = 515; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters

reg [9:0] block = 0;
reg [9:0] block2 = 9;


always @(posedge pixel_clk)
begin
		// keep counting until the end of the line
		if (h_counter < hpixels - 1)
			h_counter <= h_counter + 10'd1;
		else
		begin
			h_counter <= 0;
			if (v_counter < vlines - 1)
				v_counter <= v_counter + 1;
			else
				v_counter <= 0;
		end
end

assign hsync = (h_counter < hpulse) ? 0:1;
assign vsync = (v_counter < vpulse) ? 0:1;


endmodule

