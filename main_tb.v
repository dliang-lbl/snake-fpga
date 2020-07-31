`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:06:17 03/02/2020
// Design Name:   main
// Module Name:   /home/dliang/Documents/cs152a/lab4/main_tb.v
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

	// Outputs
	wire [9:0] current_tail;
	wire [7:0] rgb;
	wire Hsync;
	wire Vsync;
	wire [9:0] h_counter;
	wire [9:0] v_counter;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.current_tail(current_tail), 
		.clk(clk), 
		.rst(rst), 
		.rgb(rgb), 
		.Hsync(Hsync), 
		.Vsync(Vsync), 
		.h_counter(h_counter), 
		.v_counter(v_counter)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#1 clk <= ~clk;
	end
	reg [1:0] data;
	
	
    always @(posedge pixel_clk)
    begin
        if (h_counter > 223 && h_counter < 705 && v_counter > 34 && v_counter < 515)
				if (((h_counter - 224) % 16 == 3) && ((v_counter - 35) % 16 == 3))
				begin
					if (rgb == BLACK)
					begin
						$write("0 ");
						data <= 2'd0;
					end
					else if (rgb == BLUE)
					begin
						data <= 2'd1;
						$write("1 ");
					end
					else if (rgb == RED)
					begin
						$write("2 ");
						data <= 2'd2;
					end
				end
    end
	 
	 always @(posedge pixel_clk)
	 begin
//			if (h_counter == 0)
//				$write("\n");
			if (v_counter == 0)
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
      
endmodule

