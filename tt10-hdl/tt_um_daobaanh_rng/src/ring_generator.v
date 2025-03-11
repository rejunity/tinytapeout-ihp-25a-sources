// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:37:14 PM
// Design Name: 
// Module Name: ring_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// x32 + x27 + x21 + x16 + x10 + x5 + 1
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy *)
module ring_generator#
	(
		parameter NO_INVs = 5      // No of inverter stage
	)(
		input i_clk,
		input i_rst,
		input [NO_INVs-1:0] i_w,
		output o_pulse,
		output [31:0] o_data
	);
	
	(*ALLOW_COMBINATORIAL_LOOPS = "true"*)(* dont_touch = "yes"*) wire [31:0] i_r;
	(*ALLOW_COMBINATORIAL_LOOPS = "true"*)(* dont_touch = "yes"*) wire [31:0] o_r;
	
   genvar i;
	generate
		for(i = 0; i < 32; i = i+1) begin
			D_FF FF(.i_clk(i_clk), .i_rst(i_rst), .i_D(i_r[i]), .o_Q(o_r[i]));
		end
	endgenerate
   
   // top part of RG
	assign i_r[0]	= o_r[1];
	assign i_r[1]	= o_r[2];
	assign i_r[2]	= o_r[3] ^ i_w[0];
	assign i_r[3]	= o_r[4];
	assign i_r[4]	= o_r[5];
	assign i_r[5]	= o_r[6] ^ i_w[1];
	assign i_r[6]	= o_r[7];
	assign i_r[7]	= o_r[8];
	assign i_r[8]	= o_r[9] ^ i_w[2];
	assign i_r[9]	= o_r[10];
	assign i_r[10]	= o_r[11];
	assign i_r[11] = o_r[12] ^ i_w[3];
	assign i_r[12] = o_r[13];
	assign i_r[13] = o_r[14];
	assign i_r[14] = o_r[15] ^ i_w[4];
	assign i_r[15] = o_r[16];
	
	// bottom part of RG
	assign i_r[16] = o_r[17];
	assign i_r[17] = o_r[18] ^ o_r[13];
	assign i_r[18] = o_r[19];
	assign i_r[19] = o_r[20];
	assign i_r[20] = o_r[21] ^ o_r[11];
	assign i_r[21] = o_r[22];
	assign i_r[22] = o_r[23];
	assign i_r[23] = o_r[24] ^ o_r[8];
	assign i_r[24] = o_r[25];
	assign i_r[25] = o_r[26] ^ o_r[5];
	assign i_r[26] = o_r[27];
	assign i_r[27] = o_r[28];
	assign i_r[28] = o_r[29] ^ o_r[2];
	assign i_r[29] = o_r[30];
	assign i_r[30] = o_r[31];
	assign i_r[31] = o_r[0];	
	
	assign o_pulse = o_r[0];
	assign o_data = o_r;
	
endmodule

(* keep_hierarchy *)
module D_FF(
	input i_clk,
	input i_rst,
	input i_D,
	output reg o_Q
	);
	
	always @(posedge i_clk or posedge i_rst)
	begin
		if (i_rst)
			o_Q <= 1'b0;
		else
			o_Q <= i_D;
	end
   
endmodule
