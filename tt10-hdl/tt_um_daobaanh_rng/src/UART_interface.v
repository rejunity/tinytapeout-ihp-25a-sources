// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:46:56 PM
// Design Name: 
// Module Name: UART_interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 	This file contains the UART Transmitter and UART Receiver
//		When transmit is complete o_TX_Done will be
//		driven high for one clock cycle.
//
// 		When receive is complete, o_rx_dv will be
//		driven high for one clock cycle.
//
//		Set Generic g_CLKS_PER_BIT as follows:
//		g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
//		Example: 50 MHz Clock, 115200 baud UART
//		(50000000)/(115200) = 435

// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_interface#
	(
		parameter g_CLKS_PER_BIT = 435
	)(
		input i_clk,
		
		input i_RX_Serial,			// serial Data from PC
		output o_RX_DV,				// successful receiver
		output [7:0] o_RX_Byte,		// data comme from UART_RX (received data from PC)
		
		input i_TX_DV,				// enable sending		
		input [7:0] i_TX_Byte,		// data sent to UART_TX	(for sending to PC)	
		output o_TX_Active,			// successful transmitter
		output o_TX_Serial,			// serial Data to PC
		output o_TX_Done			// successful transmitter
	);
	
	UART_RX #(g_CLKS_PER_BIT) RX_part (
				.i_clk(i_clk),
				.i_RX_Serial(i_RX_Serial),
				.o_RX_DV(o_RX_DV),
				.o_RX_Byte(o_RX_Byte));
	
	UART_TX #(g_CLKS_PER_BIT) TX_part (
				.i_clk(i_clk),
				.i_TX_DV(i_TX_DV),
				.i_TX_Byte(i_TX_Byte),
				.o_TX_Active(o_TX_Active),
				.o_TX_Serial(o_TX_Serial),
				.o_TX_Done(o_TX_Done));
				
endmodule


//////////////////////////////////////////////////////////////////////////////////
module UART_RX#
	(
		parameter g_CLKS_PER_BIT = 435
	)(
		input i_clk,
		input i_RX_Serial,
		output o_RX_DV,
		output [7:0] o_RX_Byte
	);
	
	localparam [2:0]s_Idle	 		= 3'd0,
					s_RX_Start_Bit	= 3'd1,
					s_RX_Data_Bits	= 3'd2,
					s_RX_Stop_Bit	= 3'd3,
					s_Cleanup		= 3'd4;
	
	reg [2:0] r_SM_Main = 3'd0;
	
	reg r_RX_Data_R = 1'b1;
	reg r_RX_Data = 1'b1;
	
	reg [9:0] r_Clk_Count = 10'd0;
	reg [2:0] r_Bit_Index = 3'd0;	// 8 Bits Total
	reg [7:0] r_RX_Byte = 8'd0;
	reg r_RX_DV = 1'b0;
	
	// Purpose: Double-register the incoming data.
	// This allows it to be used in the UART RX Clock Domain.
	// (It removes problems caused by metastabiliy)
	
	// --------------------------------------------- p_SAMPLE
	always @(posedge i_clk)
	begin
		r_RX_Data_R <= i_RX_Serial;
		r_RX_Data   <= r_RX_Data_R;
	end
	
	// -------------------------------------------- process_state_Machine
	always @(posedge i_clk)
	begin
		case(r_SM_Main)
		//----------------------- s_Idle
		s_Idle:	
			begin
				r_RX_DV     <= 0;
				r_Clk_Count <= 0;
				r_Bit_Index <= 0;
				
				if (r_RX_Data == 0)	// Start bit detected
					r_SM_Main <= s_RX_Start_Bit;
				else
					r_SM_Main <= s_Idle;
			end
			
		//----------------------- s_RX_Start_Bit
		// Check middle of start bit to make sure it's still low
		s_RX_Start_Bit:	
			begin
				if (r_Clk_Count == (g_CLKS_PER_BIT-1)/2) begin
					if (r_RX_Data == 0) begin
						r_Clk_Count <= 0;  // reset counter since we found the middle
						r_SM_Main   <= s_RX_Data_Bits;
					end else
						r_SM_Main   <= s_Idle;
				
				end else begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_RX_Start_Bit;
				end
			end
			
		//----------------------- s_RX_Data_Bits
		// Wait g_CLKS_PER_BIT-1 clock cycles to sample serial data
		s_RX_Data_Bits:	
			begin
				if (r_Clk_Count < g_CLKS_PER_BIT-1) begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_RX_Data_Bits;
				end else begin
					r_Clk_Count <= 0;
					r_RX_Byte[r_Bit_Index] <= r_RX_Data;
				
					// Check if we have sent out all bits
					if (r_Bit_Index < 7) begin
						r_Bit_Index <= r_Bit_Index + 1;
						r_SM_Main   <= s_RX_Data_Bits;
					end else begin
						r_Bit_Index <= 0;
						r_SM_Main   <= s_RX_Stop_Bit;
					end
				end
			end
			
		//----------------------- s_RX_Stop_Bit
		// Receive Stop bit.  Stop bit = 1
		s_RX_Stop_Bit:	
			begin				
				// Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
				if (r_Clk_Count < g_CLKS_PER_BIT-1) begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_RX_Stop_Bit;
				end else begin
					r_RX_DV     <= 1;
					r_Clk_Count <= 0;
					r_SM_Main   <= s_Cleanup;
				end
			end
			
		//----------------------- s_Cleanup
		// Stay here 1 clock
		s_Cleanup:	
			begin
				r_RX_DV   <= 0;
				r_SM_Main <= s_Idle;
			end
			
		default:
			begin
				r_SM_Main <= s_Idle;
			end
		endcase
	end
	
	assign o_RX_DV   = r_RX_DV;
	assign o_RX_Byte = r_RX_Byte;
	
endmodule

//////////////////////////////////////////////////////////////////////////////////
module UART_TX#
	(
		parameter g_CLKS_PER_BIT = 435
	)(
		input i_clk,
		input i_TX_DV,
		input [7:0] i_TX_Byte,
		output reg o_TX_Active,
		output reg o_TX_Serial,
		output o_TX_Done
	);
	
	localparam [2:0]s_Idle	 		= 3'd0,
					s_TX_Start_Bit	= 3'd1,
					s_TX_Data_Bits	= 3'd2,
					s_TX_Stop_Bit	= 3'd3,
					s_Cleanup		= 3'd4;
	
	reg [2:0] r_SM_Main = 3'd0;
	
	reg [9:0] r_Clk_Count = 10'd0;
	reg [2:0] r_Bit_Index = 3'd0;
	reg [7:0] r_TX_Data = 8'd0;
	reg r_TX_Done = 1'b0;
	
	// process_state_Machine
	always @(posedge i_clk)
	begin
		case(r_SM_Main)
		//----------------------- s_Idle
		s_Idle:	
			begin
				o_TX_Active <= 0;
				o_TX_Serial <= 1;  // Drive Line High for Idle
				r_TX_Done   <= 0;
				r_Clk_Count <= 0;
				r_Bit_Index <= 0;
				
				if (i_TX_DV == 1) begin
					r_TX_Data <= i_TX_Byte;
					r_SM_Main <= s_TX_Start_Bit;
				end else
					r_SM_Main <= s_Idle;
			end
			
		//----------------------- s_TX_Start_Bit
		// Send out Start Bit. Start bit = 0
		s_TX_Start_Bit:	
			begin
				o_TX_Active <= 1;
				o_TX_Serial <= 0;
				
				// Wait g_CLKS_PER_BIT-1 clock cycles for start bit to finish
				if (r_Clk_Count < g_CLKS_PER_BIT-1) begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_TX_Start_Bit;
				end else begin
					r_Clk_Count <= 0;
					r_SM_Main   <= s_TX_Data_Bits;
				end
			end
			
		//----------------------- s_TX_Data_Bits
		// Wait g_CLKS_PER_BIT-1 clock cycles for data bits to finish 
		s_TX_Data_Bits:	
			begin
				o_TX_Serial <= r_TX_Data[r_Bit_Index];
				if (r_Clk_Count < g_CLKS_PER_BIT-1) begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_TX_Data_Bits;
				end else begin
					r_Clk_Count <= 0;
					
					// Check if we have sent out all bits
					if (r_Bit_Index < 7) begin
						r_Bit_Index <= r_Bit_Index + 1;
						r_SM_Main   <= s_TX_Data_Bits;
					end else begin
						r_Bit_Index <= 0;
						r_SM_Main   <= s_TX_Stop_Bit;
					end
				end
			end
			
		//----------------------- s_TX_Stop_Bit
		// Send out Stop bit.  Stop bit = 1 and time to IDLE
		s_TX_Stop_Bit:	
			begin
				o_TX_Serial <= 1;
				
				// Wait 2*g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
				if (r_Clk_Count < 2*g_CLKS_PER_BIT-1) begin
					r_Clk_Count <= r_Clk_Count + 1;
					r_SM_Main   <= s_TX_Stop_Bit;
				end else begin
					r_TX_Done   <= 1;
					r_Clk_Count <= 0;
					r_SM_Main   <= s_Cleanup;
				end
			end
			
		//----------------------- s_Cleanup
		// Stay here 1 clock
		s_Cleanup:	
			begin
				o_TX_Active <= 0;
				r_TX_Done   <= 1;
				r_SM_Main   <= s_Idle;
			end
			
		default:
			begin
				r_SM_Main <= s_Idle;
			end
		endcase
	end
	
	assign o_TX_Done = r_TX_Done;
	
endmodule