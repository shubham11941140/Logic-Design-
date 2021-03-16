`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:55 06/18/2020 
// Design Name: 
// Module Name:    traf3 
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
module traf3(
     input wire clk , 
	  input wire clr , 
	  output reg [5:0] lights
	  ); 
	  reg[2:0] state; 
	  reg [24:0] count = 26'd11111111;
	  parameter S0 = 3'b000,
	  S1 =3'b001, S2 = 3'b010, // states
	  S3 = 3'b011, S4 = 3'b100, S5 = 3'b101; 
	  parameter SEC5 = 26'd33333333, SEC1 = 26'd22222222; // delays 
	  always @(posedge clk )
begin 
if (clr == 1) 
begin 
state <= S0; 
count <= 0; 
end 
else 
case(state) 
S0: if(count < SEC5) 
begin
 state <= S0; 
count <= count + 1; 
end 
else 
begin 
state <= S1; 
count <= 0; 
end
S1: if(count < SEC1) 
begin 
state <= S1; 
count <= count + 1; 
end
 else 
 begin state <= S2; 
 count <= 0; 
 end 
 S2: if(count < SEC1) 
 begin 
 state <= S2; 
 count <= count + 1; 
 end 
 else 
 begin state <= S3; 
 count <= 0; 
 end
S3: if(count < SEC5) 
begin 
state <= S3; 
count <= count + 1; 
end 
else 
begin 
state <= S4;
 count <= 0; 
 end
S4: if(count < SEC1)
 begin 
 state <= S4;
 count <= count + 1; 
 end 
 else
 begin 
 state <= S5; 
 count <= 0; 
 end
S5: if(count < SEC1)
 begin 
 state <= S5;
 count <= count + 1; 
 end 
 else 
 begin 
 state <= S0; 
 count <= 0; 
 end 
 default state <= S0; 
 endcase
 end
always @(*) 
begin 
case(state) 
S0: lights = 6'b100001; 
S1: lights = 6'b100010; 
S2: lights = 6'b100100; 
S3: lights = 6'b001100; 
S4: lights = 6'b010100; 
S5: lights = 6'b100100; 
default lights = 6'b100001; 
endcase 
end 
endmodule

