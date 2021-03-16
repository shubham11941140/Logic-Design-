`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:17:36 04/28/2019
// Design Name:   processor
// Module Name:   /home/ise/simpleprocessor/test_processor.v
// Project Name:  simpleprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_processor;

	// Inputs
	reg [10:0] instruction;
	reg clk;
	reg execute_next;

	// Outputs
	wire [7:0] output_result;
	wire signflag;
	reg  reset;
	wire overflowflag;
	wire [7:0] accummulator, R1;
	wire [2:0] regsiter_operand, opcode;

	// Instantiate the Unit Under Test (UUT)
	processor uut (
		.instruction(instruction), 
		.clk(clk), 
		.execute_next(execute_next), 
		.output_result(output_result), 
		.signflag(signflag), 
		.overflowflag(overflowflag),
		.reset(reset),
		.accummulator(accummulator),
		.R1(R1),
		.regsiter_operand(regsiter_operand),
		.opcode(opcode)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset=0;
		#10
		reset=1;
		#10
		clk = 1;
		#10
		clk=0;
		#10
		reset=0;
		
	end
	
	initial begin
	   execute_next = 0;
		#30
		instruction = 11'b00000000100;
		#10
		execute_next = 1;
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b01000111111;
		#10
		execute_next = 1;
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b00000000110;
		#10
		execute_next = 1;
		
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b01001011111;
		#10
		execute_next = 1;
		
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b00100111111;
		#10
		execute_next = 1;
		
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b11001011111;
		#10
		execute_next = 1;
		
		
		#30
		execute_next = 0;
		#30
		instruction = 11'b11111111111;
		#10
		execute_next = 1;
		
		
		#30
		execute_next = 0;
	end

always #10 clk = ~clk;
      
endmodule