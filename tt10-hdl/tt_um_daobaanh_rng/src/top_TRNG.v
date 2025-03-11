// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:50:26 PM
// Design Name: 
// Module Name: top_TRNG
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=10020151
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_TRNG#
	(
		parameter g_CLKS_PER_BIT = 435,
		parameter NO_INVs = 11
	)(
		input  clk_sys,
		input  i_en,
		input  RX_Serial,		// serial Data from PC
		output TX_Serial,		// serial Data to PC
		output o_RO,
		output o_RG,
		output led
	);
	
	wire clk_50;
	
	// for TRNG
	wire reset;
	wire [31:0] data;
	
	// connect to UART_controller
	wire RX_DV;
	wire [7:0] RX_Byte;
		
	wire TX_DV;	
	wire [7:0] TX_Byte;
	wire TX_Active;
	wire TX_Done; 
	
	DCM_clk U0_fixed(
				.clk_in(clk_sys),
				.clk_50(clk_50));
	
	RG_based_TRNG #(NO_INVs) U1_TRNG(
				.i_clk(clk_50),
				.i_rst(reset),
				.i_en(i_en),
				.o_RO(o_RO),
				.o_RG(o_RG),
				.o_data(data));
	
	UART_interface #(g_CLKS_PER_BIT) U2_UART_interface(
				.i_clk(clk_50),
				.i_RX_Serial(RX_Serial),
				.o_RX_DV(RX_DV),
				.o_RX_Byte(RX_Byte),
				
				.o_TX_Serial(TX_Serial),
				.i_TX_DV(TX_DV),
				.o_TX_Active(TX_Active),
				.o_TX_Done(TX_Done),
				.i_TX_Byte(TX_Byte));
				
	Main_controller U3_Main_controller(
				.i_Clk(clk_50),
				.led(led),
				.reset(reset),
				.data(data),
				.RX_DV(RX_DV),
				.RX_Byte(RX_Byte),
				.TX_DV(TX_DV),
				.TX_Active(TX_Active),
				.TX_Done(TX_Done),
				.TX_Byte(TX_Byte));			
endmodule
