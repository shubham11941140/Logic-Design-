`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:02 04/28/2019 
// Design Name: 
// Module Name:    processor 
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
module processor(
    input [10:0] instruction,
    input clk,
    input execute_next,
    output reg [7:0] output_result,
    output reg signflag,
    output reg overflowflag,
	 input reset,
	 output reg [7:0] accummulator, 
	 output reg [7:0] R1,
	 output reg   [2:0] regsiter_operand,
	 output reg   [2:0] opcode
	 );


	 // reg [7:0] accummulator; //accummulator  
	 reg [7:0] R0, R2, R3, R4, R5, R6, R7; //regaiter bank
	 // reg [2:0] opcode;  // stotre 3 bits opcode 
	 reg [7:0] immediate_operand; // stotre 7 bits immediate operand 
    // reg [2:0] regsiter_operand;	 // stores 3 bits regsiter operand 
	 
	 reg [8:0] temp_accummulator; // to check for sign
	 
	 
	 always @(posedge clk)
	 if (reset)
		 begin
		 R1=0;
		 R2=0;
		 accummulator=0;
		 signflag=0;
       overflowflag=0;
		 output_result=0;	 
		 end
	 
	 else begin
	 
		 if (execute_next==1) // loading of instruction 
			 begin
			 opcode = instruction[10:8];
			 immediate_operand = instruction[7:0];
			 regsiter_operand =  instruction[7:5];
			 end
	 end
		
		
	always @(opcode or immediate_operand or regsiter_operand)
	begin
		
		if (opcode==3'b000) accummulator = immediate_operand; 
			 		
		else if (opcode==3'b001) begin
		   if (regsiter_operand==3'b000) accummulator = R0;
			else if (regsiter_operand==3'b001)  accummulator = R1; 
         else if (regsiter_operand==3'b010)  accummulator = R2; 
			else if (regsiter_operand==3'b011)  accummulator = R3; 
         else if (regsiter_operand==3'b100)  accummulator = R4;
			else if (regsiter_operand==3'b101)  accummulator = R5; 
         else if (regsiter_operand==3'b110)  accummulator = R6;
			else 	accummulator = R7;	
        end
       			 
		else if (opcode==3'b010) begin
		   if (regsiter_operand==3'b000) R0 = accummulator;
			else if (regsiter_operand==3'b001)  R1 = accummulator; 
         else if (regsiter_operand==3'b010)  R2 = accummulator; 
			else if (regsiter_operand==3'b011)  R3 = accummulator; 
         else if (regsiter_operand==3'b100)  R4 = accummulator;
			else if (regsiter_operand==3'b101)  R5 = accummulator; 
         else if (regsiter_operand==3'b110)  R6 = accummulator;
			else 	R7 = accummulator;	
        end
		
			 
		else if (opcode==3'b011)  begin
		      
				signflag=0;
				
				temp_accummulator = accummulator + immediate_operand;
				
				if (temp_accummulator[8] == 1) overflowflag =1; else overflowflag=0;
				
        		accummulator = accummulator + immediate_operand;
				
		      end

			
		else if (opcode==3'b100) begin
		
		     overflowflag=0;
		    
			  if (accummulator < immediate_operand) signflag =1; else signflag = 0;
			      accummulator = accummulator - immediate_operand;
			  
		     end
			  
			  
		else if (opcode==3'b101) begin
		
		     signflag=0;
				
				if (regsiter_operand==3'b000) temp_accummulator = accummulator + R0;
				else if (regsiter_operand==3'b001) temp_accummulator = accummulator + R1;
				else if (regsiter_operand==3'b010) temp_accummulator = accummulator + R2;
				else if (regsiter_operand==3'b011) temp_accummulator = accummulator + R3;
				else if (regsiter_operand==3'b100) temp_accummulator = accummulator + R4;
				else if (regsiter_operand==101) temp_accummulator = accummulator + R5;
				else if (regsiter_operand==3'b110) temp_accummulator = accummulator + R6;
				if (regsiter_operand==3'b111) temp_accummulator = accummulator + R7;
				
						
				if (temp_accummulator[8] == 1) overflowflag =1; else overflowflag=0;
				
        		accummulator = temp_accummulator[7:0];
		
		     end
			  
			  
		else if (opcode==3'b110) begin
		
		      overflowflag=0;
				
				if (regsiter_operand==3'b000) begin if (accummulator < R0) signflag =1; else signflag = 0; accummulator = accummulator - R0; end
				else if (regsiter_operand==3'b001) begin if (accummulator < R1) signflag =1; else signflag = 0;accummulator = accummulator - R1; end
				else if (regsiter_operand==3'b010) begin if (accummulator < R2) signflag =1; else signflag = 0; accummulator = accummulator - R2; end
				else if (regsiter_operand==3'b011) begin if (accummulator < R3) signflag =1; else signflag = 0;accummulator = accummulator - R3; end
				else if (regsiter_operand==3'b100) begin if (accummulator < R4) signflag =1; else signflag = 0;accummulator = accummulator - R4; end
				else if (regsiter_operand==3'b101) begin if (accummulator < R5) signflag =1; else signflag = 0;accummulator = accummulator - R5; end
				else if (regsiter_operand==3'b110) begin if (accummulator < R6) signflag =1; else signflag = 0;accummulator = accummulator - R6; end
				else begin if (accummulator < R7) signflag =1; else signflag = 0;accummulator = accummulator - R7; end
				
						
           end
			  
			  
		  else if (opcode==3'b111)  output_result = accummulator;
		
		
				
	end
	
endmodule