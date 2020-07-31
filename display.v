`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:48 02/18/2020 
// Design Name: 
// Module Name:    display 
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
`include "definition.v"
module main(
    output [9:0] current_tail,
    input clk,
    input rst,
	output reg [7:0] rgb,
    output Hsync,
    output Vsync,
    output [9:0] h_counter,
    output [9:0] v_counter
	 );
    
    initial rgb = BLACK;
    
    //==================== Clock Divider =======================================
    //pixel clock
    reg count25;
    reg pixel_clk; 
    initial begin
        count25 = 0;
        pixel_clk = 0;
    end
    always @(posedge clk) begin
        count25 <= ~count25;
        if (count25) begin
            pixel_clk <= ~pixel_clk;
        end
    end
    
    reg [26:0] counter_2hz;
    reg clk_2hz;
    initial
    begin
        counter_2hz <= 27'd0;
        clk_2hz <= 0;
    end
    always @(posedge clk)
    begin
        counter_2hz <= counter_2hz + 1'b1;
        if (counter_2hz == 27'd50000000)
        begin
            clk_2hz <= 1'b1;
            counter_2hz <= 27'd0;
        end
        else
            clk_2hz <= 1'b0;
    end
    //==================== Clock Divider END =======================================

    //==================== Color Selection =========================================
    
    reg is_border;
    wire is_snake;
    wire is_apple;
    reg in_display_range;
    initial
    begin
        is_border <= 0;
        in_display_range <= 0;
    end

    always @(posedge clk)
    begin
        if (h_counter > 223 && h_counter < 705 && v_counter > 34 && v_counter < 515)
            in_display_range <= 1;
        else
            in_display_range <= 0;
    end
    
    always @(posedge clk)
    begin
        if (((h_counter - 224) % 16 < 1) || ((v_counter - 35) % 16 < 1) || v_counter == 514)
            is_border <= 1;
        else
            is_border <= 0;
    end
    
    reg [9:0] index_reg;
    wire [9:0] index;
    assign index = index_reg;
    
    always @(posedge clk)
    begin
        index_reg <= (h_counter - 224) / 16 + (v_counter - 35) / 16 * 30;
    end
    
    always @(posedge clk)
    begin
        if (in_display_range)
        begin
            if (is_border)
                rgb <= WHITE;
            else if (is_snake)
                rgb <= BLUE;
            else if (is_apple)
                rgb <= RED;
            else
                rgb <= BLACK;
        end
        else
            rgb <= BLACK;
    end
    
    //horizontal and vertical counter
    //https://learn.digilentinc.com/Documents/Digital/DC06_VGAController/VESA_TimingDiagram.svg
	 //https://learn.digilentinc.com/Documents/269
     //https://embeddedthoughts.com/2016/07/29/driving-a-vga-monitor-using-an-fpga/  
    
	
	
	vga640x480 vga_display(
		.pixel_clk(pixel_clk),
		.rst(rst),
		.hsync(Hsync),
		.vsync(Vsync),
		.h_counter(h_counter),
		.v_counter(v_counter)
	);

    gameboard gameboard(
        .master_clk(clk),
        .movement_clk(clk),
        .index(index),
        .is_snake(is_snake),
        .is_apple(is_apple)
    );
endmodule
