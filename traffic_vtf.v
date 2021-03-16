`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:07:01 06/18/2020
// Design Name:   traffic
// Module Name:   /home/ise/traffic/traffic_vtf.v
// Project Name:  traffic
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module traffic_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg nscar;
	reg ewcar;

	// Outputs
	wire [5:0] lights;

	// Instantiate the Unit Under Test (UUT)
	traffic uut (
		.clk(clk), 
		.clr(clr), 
		.nscar(nscar), 
		.ewcar(ewcar), 
		.lights(lights)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		nscar = 0;
		ewcar = 1;
		clr = 1;
		#2;
		clr = 0;
		#2;
		// we are selecting the range when we can establish the priority of the North South is more so
		// we can switch the signal
		#200;
		nscar = 1;
		#50;   // for a period of 50 ns it is range of being green in East-West Road
		// So in simulation we will see that the traffic light will image in this time in state 3(S3)
		nscar = 0;
		#2;
		#500;
		// It is important to notice that even if there is a car on the East-West Road it
		// is not given priority even for a long time and the code progresses.
		
      // Later on there is no car on priority in North - South so it progresses as usual.
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule
