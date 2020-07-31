`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:33:11 03/15/2020
// Design Name:   main
// Module Name:   C:/Users/15105/cs152a/lab4/src/tb/main_tb.v
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

module main_tb;

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
	wire [9:0] score;
	wire [9:0] h_counter;
	wire [9:0] v_counter;

   `include "../definition.v"
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

	reg [3:0] write;
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
		write = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	 reg newline;
	 initial newline = 0;
	 always @(posedge pixel_clk)
    begin
		  if (h_counter == 50)
		  begin
				newline <= 0;
		  end
        if (h_counter > 223 && h_counter < 705 && v_counter > 34 && v_counter < 515)
				if (((h_counter - 224) % 16 == 1) && ((v_counter - 35) % 16 == 1))
				begin
					if (rgb == BLACK)
					begin
						$write("0 ");
						write <= 0;
					end
					else if (rgb == BLUE)
					begin	
						$write("1 ");
						write <= 1;
					end
					else if (rgb == RED)
					begin
						$write("2 ");
						write <= 2;
					end
					else if (rgb == GREEN)
					begin
						$write("3 ");
						write <= 3;
					end
				end
    end
	 

	 
	 always @(negedge Vsync)
	 begin
			$write("\n\n------------------------------------------------------------\n\n");
	 end
      
	 reg count25;
    reg pixel_clk; 
    initial begin
        count25 = 0;
        pixel_clk = 0;
    end
	 always @(posedge clk) 
	 begin
        count25 <= ~count25;
        if (count25) 
		  begin
            pixel_clk <= ~pixel_clk;
        end
    end
	 
	 always begin
	 #1 clk <= ~clk;
	 end
endmodule

