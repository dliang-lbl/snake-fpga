

module gameboard(
	 input [1:0] direction,
    input master_clk,
    input movement_clk,
    input [9:0] index,
	 input rst,
	 input vga_clk,
	 output [9:0] score,
	 output reg won,
	 output reg lost,
    output is_snake,
    output is_apple,
    output is_green_apple
    );
    
    `include "definition.v"
    integer i;
	reg [MAX-1:0] data_frame;
    reg [9:0] snake_body [29:0];
    reg [9:0] length;
    reg [9:0] snake_head_index;
	 reg [9:0] apple;	
     reg [9:0] green_apple;
	 reg [9:0] random;
	 
	 assign score = length - 4;
	 
    always @(posedge master_clk)
	 begin
			random <= (random + 1) % 900;
	 end
	 
    reg [9:0] next_head;

    initial
    begin
        for (i=0; i<MAX; i=i+1)
		  begin
				snake_body[i] = 10'd1023;
		  end
		  apple = 88;
          green_apple = 700;
        snake_body[0] = 9'd3;
        snake_body[1] = 9'd2;
        snake_body[2] = 9'd1;
        snake_body[3] = 9'd0;
        length = 9'd4;
		  random = 0;
		  won = 0;
		  lost <= 0;
    end
	
    
    assign is_snake = |data_frame;
    assign is_apple = (apple == index);
    assign is_green_apple = (green_apple == index);
	 assign game_over = (|data_frame[MAX-1:1] & data_frame[0]);
	 
	 always @(posedge master_clk)
	 begin
			for (i=0; i<MAX; i=i+1)
			begin
					data_frame[i] <= (index == snake_body[i]);
			end
	 end
	 
	 
	
    //    2
    // 0     1
    //    3
    always @(posedge master_clk)
    begin
        case(direction)
            2'd0:  
            begin
                if ((snake_body[0] % 30) == 0)
                    next_head <= snake_body[0] + 10'd29;
                else
                    next_head <= snake_body[0] - 10'd1;
            end
            2'd1:
            begin
                if ((snake_body[0] % 30) == 29)
                    next_head <= snake_body[0] - 10'd29;
                else
                    next_head <= snake_body[0] + 10'd1;
            end
            2'd2:
            begin
                 if ((snake_body[0] / 30) == 0)
                    next_head <= snake_body[0] + 10'd870;
                 else
                    next_head <= snake_body[0] - 10'd30;
            end
            2'd3:
            begin
                 if ((snake_body[0] / 30) == 29)
                    next_head <= snake_body[0] - 10'd870;
                 else
                    next_head <= snake_body[0] + 10'd30;
            end
            endcase
    end
	 	 
    

	//update snake_body
	always @(posedge master_clk)
	begin
        if (game_over & ~rst)
        begin
            lost <= 1;
        end
		  
		  if ((length == WIN) & ~rst)
		  begin
				won <= 1;
		  end
		  
        
		if (movement_clk)
		begin
            if (~lost & ~won)
            begin
                if (next_head == green_apple)
                begin
                        if (length < 6)
                            length <= 4;
                        else
                            length <= length - 2;
                        green_apple <= random;
                        for (i=1; i<30; i=i+1)
                        begin
                            if (length < 6)
                            begin
                                if (i > 3)
                                begin
                                    snake_body[i] <= 10'd1023;
                                end
                                else
                                    snake_body[i] <= snake_body[i-1];
                            end
                            else
                            begin
                                if (i > length - 3)
                                    snake_body[i] <= 10'd1023;
                                else
                                    snake_body[i] <= snake_body[i-1];
                            end
                        end
                        snake_body[0] <= next_head;

                end
                else if (next_head == apple)
                begin
                        length <= length + 1;
                        apple <= random;
                        for (i=1; i<30; i=i+1)
                        begin
                                if (i < length)
                                    snake_body[i] <= snake_body[i-1];
                        end
                        snake_body[0] <= next_head;  
                end
                else
                begin
                    for (i=1; i<30; i=i+1)
                    begin
                            if (i < length)
                                snake_body[i] <= snake_body[i-1];
                    end
                    snake_body[0] <= next_head; 
                end
                
            end
		end
		
		else if (rst)
		begin
			for (i=3; i<MAX; i=i+1)
			begin
					snake_body[i] <= 1023;
			end
			snake_body[0] <= 3;
			snake_body[1] <= 2;
			snake_body[2] <= 1;
			snake_body[3] <= 0;
			length <= 4;
			apple <= random;
            green_apple <= (random * 152) % 900;
            lost <= 0;
				won <= 0;
		end
	end
endmodule



