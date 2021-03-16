`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:08 06/19/2020 
// Design Name: 
// Module Name:    lcdverilog 
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
module lcdverilog(input clk, output data, output lcd_e, output lcd_rw,output lcd_rs, input reset);
 
	 reg [15:0] data;
	 reg [32:0] count;
	 reg [15:0]  data_comand;
	 reg lcd_e, lcd_rw, lcd_rs; 
	 	 
	always @(posedge clk)
	begin 
		if(reset == 1)
		begin 
			lcd_e=1;
			lcd_rw=0;
			lcd_rs=0;
			count =0;
			data_comand=0;
		end
		
	else 
		
			begin
			
				if (count <=1000000) 
				begin
					count = count + 1;
					lcd_e = 1;
					if (data_comand <=3) lcd_rs=0; else lcd_rs=1;
					
					if (data_comand==0) data = 8'h38;
					else if (data_comand==1) data = 8'b00001101;
					else if (data_comand==2) data = 8'b00000001;//Clear display screen
					else if (data_comand==3) data = 8'b10000010;//82 Force cursor to beginning ( 1st line) POSITION 3, IF TAKE 80 POSITION 0.
					
					//else if (data_comand==4) data = 8'b11000010;// C2 Force cursor to beginning ( 2nd line) POSITION 3, IF TAKE C0 POSITION 0.
					
					else if (data_comand==4) data = 8'b00101010;//*					
					else if (data_comand==5) data = 8'b01001001;//I
					else if (data_comand==6) data = 8'b01001001;//I
					else if (data_comand==7) data = 8'b01010100;//T
					
					else if (data_comand==8) data = 8'b00100000;//SPACE
					
					else if (data_comand==9) data = 8'b01000010;//B
					else if (data_comand==10) data = 8'b01101000;//h
					else if (data_comand==11) data = 8'b01101001;//i
					else if (data_comand==12) data = 8'b01101100;//l
					else if (data_comand==13) data = 8'b01100001;//a
					else if (data_comand==14) data = 8'b01101001;//i
					else if (data_comand==15) data = 8'b00101010;//*
					
					else if (data_comand==16) data = 8'b00100000;//SPACE
					

					else data = 8'hff;
			  end
			
			else if (count > 1000000 && count < 2000000) begin count = count + 1;  lcd_e=0; end
			else if (count >= 2000000) begin count = 0; data_comand = data_comand +1; end
			
			if (data_comand==16) data_comand =0;
			
		end // else-reset
		
	end  //clock end 
	
endmodule	
