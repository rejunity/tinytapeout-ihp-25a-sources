// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:44:20 PM
// Design Name: 
// Module Name: DCM_clk
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

module DCM_clk(
	input  clk_in,
	output clk_50
    );
	
	// reg [1:0] cnt = 2'd0;
	reg clk_buf = 1'b0;
	
	// --------------------------------------------- process_DCM
	always @(posedge clk_in)
	begin
        clk_buf <= ~ clk_buf;
	end
	
	assign clk_50 = clk_buf;
endmodule
