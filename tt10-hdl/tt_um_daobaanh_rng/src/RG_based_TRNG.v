// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:38:31 PM
// Design Name: 
// Module Name: RG_based_TRNG
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

(* dont_touch = "yes"*)
module RG_based_TRNG#
	(
		parameter NO_INVs = 5      // Degree polynominal		
	)(
		
		input i_clk,
		input i_rst, 
		input i_en,
		output o_RO,
		output o_RG,
		output [31:0] o_data
	);
	
	(* dont_touch = "yes"*) wire [NO_INVs-1:0]w;
	(* dont_touch = "yes"*) wire o_RNG;
	
	// ring_osc part
	ring_osc #(NO_INVs) RO_part(
		.i_en(i_en),
		.o_w(w));
	
	// ring_generator part
	ring_generator #(NO_INVs) RG_part(
		.i_clk(i_clk), 
		.i_rst(i_rst), 
		.i_w(w), 
		.o_pulse(o_RNG),
		.o_data(o_data));	
	
	/* output */
	assign o_RO = w[NO_INVs-1];
	assign o_RG = o_RNG;
endmodule
