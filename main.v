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
module main(
    input clk,
    input rst,
	output reg [7:0] rgb,
    output Hsync,
    output Vsync,
	 output [3:0] an,
	 output [6:0] seg,
	 input btnu,
	 input btnd,
	 input btnl,
	 input btnr,
	 input paused,
	 input speed,
	 output [9:0] score,
    output [9:0] h_counter,
    output [9:0] v_counter
	 );
    
    `include "definition.v"
    initial rgb = BLACK;
	 
	 wire [279:0] digit_to_pixel [9:0];
//	 assign digit_to_pixel[0] = 1600'hFE00000007FFC000001FFFF000003F83F800007E00FC00007C007C0000F8003E0000F8003E0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0001F0000F8003E0000F8003E00007C007C00007E00FC00003F83F800001FFFF0000007FFC0000000FE0000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[1] = 1600'hF800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F800000000F802000000F81E000000F8FE000000FBFE000000FFF0000000FFC0000000FF00000000FE00000000F800000000F000000000E000000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[2] = 1600'h3FFFFFF8003FFFFFF8003FFFFFF0003FFFFFF000000007E00000000FC00000003F800000007F00000001FC00000007F80000000FE00000003F800000007F00000001FC00000003F800000007E00000000FC00000001F800000001F000000001F000000003E0001F0003E0001F0001F0003E0001F8007E0000FC00FC00007F87F800003FFFF000000FFFC0000000780000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[3] = 1600'hFF00000007FFE000001FFFF800007F81FC0000FC007E0000F8003F0001F0001F0001F0001F0001F000080001F000000001F000000001F800000000F800000000FE000000003FFE0000000FFE0000000FFC0000001FC00000003E000000007C000000007C00000000F8001F00007C001F00007C003E00007E007E00003F81FC00001FFFF8000007FFE00000007F0000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[4] = 1600'h1F000000001F000000001F000000001F000000001F000000001F000000001F00000003FFFFFF8003FFFFFF8003FFFFFF80001F000F80001F001F00001F003E00001F007C00001F00F800001F01F000001F03E000001F07C000001F0F8000001F1F0000001F3E0000001F7C0000001FF80000001FF00000001FE00000001FC00000001F800000001F000000001E000000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[5] = 1600'h3C00000007FFE000001FFFF800003FC3FC00007E007E0000FC003F0001F8001F0001F0001F8001F000080003F000000003F000000003F000000001F000000001F800000000FC003F0000FE007E00007FFFFE00001FFFFE000007FF3E000000203C000000007C000000007C000000007C000000007800000000F80000FFFFF80000FFFFF00000FFFFF00000FFFFF000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[6] = 1600'h1FC0000000FFFC000003FFFF000007F03F80000FC00FC0000F8007E0001F0003E0001F0001F0001E0001F0003E0001F0003E0001F0001F0001F8001F0003F8001F8007F8000FC00FF80007F03EF80003FFFCF00000FFF8F000001FC1F000000001F000000001F000000003E0001F0003E0000F8007C0000FC00F800007F03F000003FFFE000000FFF80000001FC0000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[7] = 1600'h3E000000003E000000007C000000007C000000007C000000007C00000000F800000000F800000001F800000001F000000003F000000003E000000007E000000007C00000000FC00000001F800000001F000000003E000000007E00000000FC00000001F800000003F000000007E00000000FC00000001FFFFFF0001FFFFFF0001FFFFFF000000000000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[8] = 1600'hFE0000000FFFE000003FFFF800007F01FC0000FC007E0001F8003F0001F0001F0001F0001F0003E0000F8001F0000F8001F0001F0001F0001F0000F8003E00007E00FC00003FFFF8000007FFE000000FFFE000003F83F800007E00FC00007C007E0000F8003E0000F8003E0000F8003E0000FC007E00007E00FC00003F01F800001FFFF0000007FFC0000000FE0000000000000000000000000000000000000000000000000000000000000000;
//	 assign digit_to_pixel[9] = 1600'h7F00000003FFE000000FFFF800001F80FC00003E007E00007C003E0000F8001F0000F800000001F000000001F000000001F03F000001E1FFE00001E7FFF80001EF83FC0001FE007E0003F8003F0001F8001F0001F0001F0001F0001F8001F0000F8001F0001F0001F0001F0000F8001F0000F8003E00007E007E00003F83FC00001FFFF8000007FFE00000007F0000000000000000000000000000000000000000000000000000000000000000;
	 assign digit_to_pixel[0] = 280'h7003E018C0C183060C183060C183060C183060C1818C03E007000000000000;
	 assign digit_to_pixel[1] = 280'hC003000C003000C003000C003000C003000D803C00E0030008000000000000;
	 assign digit_to_pixel[2] = 280'h3FE0FF800C003003801C00E006003800C003060C1830C07E006000000000000;
	 assign digit_to_pixel[3] = 280'h7007F018E0C183040C0030007C00F00600100041818C03F007000000000000;
	 assign digit_to_pixel[4] = 280'h80020008002003FE0208086023008802400B003800C0030008000000000000;
	 assign digit_to_pixel[5] = 280'h2003F018E0C183040C003000C181FE03D0004003000C07F01F800000000000;
	 assign digit_to_pixel[6] = 280'h7007E018C0C183060C183060E381FE01980060C1030C07E006000000000000;
	 assign digit_to_pixel[7] = 280'h60018006001000C0030008006001000C006001000FF800000000000000;
	 assign digit_to_pixel[8] = 280'h7007F038E0C183060C1830607F00F80630104041018C03F007000000000000;
	 assign digit_to_pixel[9] = 280'h3003F018404183000CC03FC0E383060C183060C1818C03F007000000000000;
	 //==================== Clock Divider =======================================
    //pixel clock
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
    
	 //2hz clock
    reg [26:0] counter_2hz;
    reg clk_2hz;
    initial
    begin
        counter_2hz <= 27'd0;
        clk_2hz <= 0;
    end
    always @(posedge clk)
    begin
		  if (rst)
		  begin
				clk_2hz <= 1'b0;
				counter_2hz <= 27'd0;
		  end
		  if (~paused)
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
		  else
		  begin
					clk_2hz <= 1'b0;
		  end
    end
	 
	 //4hz clk
	 reg [26:0] counter_4hz;
    reg clk_4hz;
    initial
    begin
        counter_4hz <= 27'd0;
        clk_4hz <= 0;
    end
    always @(posedge clk)
    begin
		  if (rst)
		  begin
				clk_4hz <= 1'b0;
				counter_4hz <= 27'd0;
		  end
		  if (~paused)
		  begin
			  counter_4hz <= counter_4hz + 1'b1;
			  if (counter_4hz == 27'd25000000)
			  begin
					clk_4hz <= 1'b1;
					counter_4hz <= 27'd0;
			  end
			  else
					clk_4hz <= 1'b0;
		  end
		  else
		  begin
					clk_4hz <= 1'b0;
		  end
    end
	 
	 //8hz clock
    reg [26:0] counter_8hz;
    reg clk_8hz;
    initial
    begin
        counter_8hz <= 27'd0;
        clk_8hz <= 0;
    end
    always @(posedge clk)
    begin
		  if (rst)
		  begin
				clk_8hz <= 1'b0;
				counter_8hz <= 27'd0;
		  end
		  if (~paused)
		  begin
			  counter_8hz <= counter_8hz + 1'b1;
			  if (counter_8hz == 27'd12500000)
			  begin
					clk_8hz <= 1'b1;
					counter_8hz <= 27'd0;
			  end
			  else
					clk_8hz <= 1'b0;
		  end
		  else
		  begin
					clk_8hz <= 1'b0;
		  end
    end
	 
	 //1mhz clock
    reg [26:0] counter_1mhz;
    reg clk_1mhz;
    initial
    begin
        counter_1mhz <= 27'd0;
        clk_1mhz <= 0;
    end
    always @(posedge clk)
    begin
        counter_1mhz <= counter_1mhz + 1'b1;
        if (counter_1mhz == 27'd100)
        begin
            clk_1mhz <= 1'b1;
            counter_1mhz <= 27'd0;
        end
        else
            clk_1mhz <= 1'b0;
    end
	 
	 reg clk_400hz;
    reg [25:0] counter_400hz; //counter to make 400 hz clock, count up to 250,000
    initial
	  begin
	  		  clk_400hz = 1'b0;
			  counter_400hz = 26'd0;
	  end
	 always @(posedge clk)
    begin
        counter_400hz <= counter_400hz + 1'b1;
        if (counter_400hz == 26'd250000)
        begin
            clk_400hz <= 1'b1;
            counter_400hz <= 26'd0;
        end
		  else
				clk_400hz <= 1'b0;
    end
	 
	 reg clk_4hz_2;
	 initial
	 begin
			clk_4hz_2 <= 0;
	 end
	 always @(posedge clk_8hz)
	 begin
			clk_4hz_2 <= ~clk_4hz_2;
	 end
	 
    //==================== Clock Divider END =======================================

    //==================== Color Selection =========================================
    
    reg is_border;
    wire is_snake;
    wire is_apple;
    wire is_green_apple;
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
    
	 reg [7:0] animation_rgb;
	 initial animation_rgb <= 8'b10101000;
	 always @(posedge clk_400hz)
	 begin
			//animation_rgb <= {animation_rgb[0], animation_rgb[7:1]};
			animation_rgb <= animation_rgb + 1;
	 end
	 
	 wire won;
	 wire lost;
	 reg won2;
	 reg lost2;
	 reg [2:0] counter_2sec;
	 initial 
	 begin
		counter_2sec <= 0;
		won2 <= 0;
		lost2 <= 0;
	 end
	 
	 always @(posedge clk)
	 begin
			if (rst)
			begin
				lost2 <= 0;
				won2 <= 0;
				counter_2sec <= 0;
			end
			if (won & clk_2hz)
			begin
				counter_2sec <= counter_2sec + 1;
				if (counter_2sec == 3'd5)
					won2 <= 1;
			end
			if (lost & clk_2hz)
			begin
				counter_2sec <= counter_2sec + 1;
				if (counter_2sec == 3'd5)
					lost2 <= 1;
			end
	 end
	 
    wire [19:0] distance;
    wire [19:0] distance2;
    wire [19:0] distance3;
    wire [19:0] distance4;
    wire [19:0] distance5;
    wire [19:0] distance6;
    wire [19:0] distance7;
	 assign distance = (h_counter-464) * (h_counter-464) + (v_counter-275) * (v_counter-275);
	 assign distance2 = (h_counter-404) * (h_counter-404)+ (v_counter-245) * (v_counter-245);
	 assign distance3 = (h_counter-524) * (h_counter-524) + (v_counter-245) * (v_counter-245);
	 assign distance4 = (h_counter-464) * (h_counter-464) + (v_counter-315) * (v_counter-315);
	 
	 assign distance5 = (h_counter-404) * (h_counter-404)+ (v_counter-205) * (v_counter-205);
	 assign distance6 = (h_counter-524) * (h_counter-524)+ (v_counter-205) * (v_counter-205);
	 assign distance7 = (h_counter-464) * (h_counter-464) + (v_counter-355) * (v_counter-355);

	 wire [9:0] center_pixel_h;
	 wire [9:0] center_pixel_v;
	 wire [19:0] distance8;
	 assign distance8 = (h_counter-center_pixel_h) * (h_counter-center_pixel_h) + (v_counter-center_pixel_v) * (v_counter-center_pixel_v);
	 assign center_pixel_h = (index % 30) * 16 + 8 + 224;
	 assign center_pixel_v = (index / 30) * 16 + 8 + 36;
    always @(posedge clk)
    begin
		  if (h_counter > 719 & h_counter < 734 & v_counter > 44 & v_counter < 65 )
		  begin
		
				 if ((digit_to_pixel[digit[7:4]][hv_convert1] == 1) & ~(digit[7:4] == 0))
						rgb <= WHITE;
				 else
					rgb <= BLACK;
		  end
		  else if (h_counter > 733 & h_counter < 748 & v_counter > 44 & v_counter < 65 )
		  begin
				 if (digit_to_pixel[digit[3:0]][hv_convert2] == 1)
						rgb <= WHITE;
				 else
					rgb <= BLACK;
		  end
		  //happy face
        else if (won2)
        begin
				if ((distance < 161*161 ) & (distance > 159*159))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance2 < 41*41) & (distance2 > 39*39) & (v_counter < 245))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance3 < 41*41) & (distance3 > 39*39) & (v_counter < 245))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance4 < 41*41) & (distance4 > 39*39) & (v_counter > 315))
					rgb <= animation_rgb + h_counter[7:0];
				else
					rgb <= BLACK;
		  end
		  //sad face
		  else if (lost2)
        begin
				if ((distance < 161*161 ) & (distance > 159*159))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance5 < 41*41) & (distance5 > 39*39) & (v_counter > 205))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance6 < 41*41) & (distance6 > 39*39) & (v_counter > 205))
					rgb <= animation_rgb + h_counter[7:0];
				else if ((distance7 < 41*41) & (distance7 > 39*39) & (v_counter < 355))
					rgb <= animation_rgb + h_counter[7:0];
				else
					rgb <= BLACK;
		  end
		  //normal 
        else if (in_display_range)
		  begin
				 if (is_border)
					  rgb <= WHITE;
				 else if (is_snake)
					  if ((won | lost) & ~clk_4hz_2)
							rgb <= BLACK;
					  else
							rgb <= BLUE;
				 else if (is_apple)
				 begin
					  if (distance8 < 36)
							rgb <= RED;
					  else
							rgb <= BLACK;
				 end
				 else if (is_green_apple)
				 begin
					  if (distance8 < 36)
							rgb <= GREEN;
					  else
							rgb <= BLACK;
				 end
				 else
					  rgb <= BLACK;
		  end
		  
		  else
				 rgb <= BLACK;
    end
    

	 wire [11:0] hv_convert1;
	 wire [11:0] hv_convert2;
	 assign hv_convert1 = (h_counter - 720) + (v_counter - 45) * 14;
	 assign hv_convert2 = (h_counter - 734) + (v_counter - 45) * 14;
    //==================== Color Selection END =========================================
	
	 //==================== Snake Direction Button=============================================
	 reg [1:0] direction;
	 reg [1:0] next_direction;
	 initial
	 begin
			direction = 2'd1;
			next_direction = 2'd1;
	 end
	 always @(posedge clk)
	 begin
			if (rst)
            begin
					next_direction <= 2'd1;
                    direction <= 2'd1;
            end
            if (movement_clk)
                direction <= next_direction;
			else if (btnr)
			begin
				if (direction != 2'd0)
					next_direction <= 2'd1;
			end
			else if (btnl)
			begin
				if (direction != 2'd1)
					next_direction <= 2'd0;
			end
			else if (btnu)
			begin
				if (direction != 2'd3)
					next_direction <= 2'd2;
			end
			else if (btnd)
			begin
				if (direction != 2'd2)
					next_direction <= 2'd3;
			end
	 end
	 //==================== Snake Direction Button END =============================================

	 
	 //reference https://learn.digilentinc.com/Documents/269
	 
	 
	 //wire [9:0] socre;
    wire [15:0] digit;
	 assign digit[15:12] = (score / 1000) % 10;
	 assign digit[11:8] = (score / 100) % 10;
	 assign digit[7:4] = (score / 10) % 10;
	 assign digit[3:0] = score % 10;
	 


	wire movement_clk;
	assign movement_clk = (speed & clk_8hz) | (~speed & clk_2hz);
	
	
	vga640x480 vga_display(
		.pixel_clk(pixel_clk),
		.rst(rst),
		.hsync(Hsync),
		.vsync(Vsync),
		.h_counter(h_counter),
		.v_counter(v_counter)
	);

    gameboard gameboard(
		  .direction(direction),
		  .rst(rst),
        .master_clk(clk),
        .movement_clk(movement_clk),
		  .vga_clk(pixel_clk),
		  .score(score),
        .index(index),
		  .won(won),
		  .lost(lost),
        .is_snake(is_snake),
        .is_apple(is_apple),
        .is_green_apple(is_green_apple)
    );
	 
	 BCD_seven seven_segment_decoder(
        .digit(digit),
        .CA_CG(seg),
        .AN(an),
        .clk(clk_400hz)
    );
endmodule
