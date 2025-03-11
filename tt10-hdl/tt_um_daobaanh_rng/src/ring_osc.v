// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:35:59 PM
// Design Name: 
// Module Name: ring_osc
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


//////////////////////////////////////////////////////////////////////////////////
(* keep_hierarchy *)
module ring_osc#
	(
		parameter NO_INVs = 5      // No of inverter stage
	)(
		input i_en,
		output [NO_INVs-1:0] o_w
	);

	(*ALLOW_COMBINATORIAL_LOOPS = "true"*)(* dont_touch = "yes"*) wire [NO_INVs-1:0]w;

	/* nand */
	primitive_nand nand1(w[NO_INVs-1], i_en, w[0]);
	
	/* number of inverters */
	genvar i;
	generate
		for(i = 0; i < NO_INVs-1; i = i+1) begin
			primitive_not not1(w[i], w[i+1]);
		end
	endgenerate
		
	/* output */
	assign o_w = w;
	
endmodule



//////////////////////////////////////////////////////////////////////////////////
(* keep_hierarchy *)
module primitive_not(
	input i_a,
	output o_b
	);
		
	// LUT6 #(
   //    .INIT(64'h0000000000000001)  // Specify LUT Contents
   // ) LUT6_inst (
   //    .O(o_b),   // LUT general output
   //    .I0(i_a), // LUT input
   //    .I1(0), // LUT input
   //    .I2(0), // LUT input
   //    .I3(0), // LUT input
   //    .I4(0), // LUT input
   //    .I5(0)  // LUT input
   // );

   // (* keep *) sky130_fd_sc_hd__inv_2   sky_inverter (
   //      .A  (i_a),
   //      .Y  (o_b)
   //  );

   assign o_b = ~i_a;

endmodule


//////////////////////////////////////////////////////////////////////////////////
(* keep_hierarchy *)
module primitive_nand(
	input i_a,
	input i_b,
	output o_c
	);
		
	// LUT6 #(
   //    .INIT(64'h0000000000000007)  // Specify LUT Contents
   // ) LUT6_inst (
   //    .O(o_c),   // LUT general output
   //    .I0(i_a), // LUT input
   //    .I1(i_b), // LUT input
   //    .I2(0), // LUT input
   //    .I3(0), // LUT input
   //    .I4(0), // LUT input
   //    .I5(0)  // LUT input
   // );

   // (* keep *) sky130_fd_sc_hd__nand2_2   sky_nand (
   //      .Y  (o_c),
   //      .A  (i_a),
   //      .B  (i_b)
   //  );

   assign o_c = !(i_a&i_b);

endmodule

