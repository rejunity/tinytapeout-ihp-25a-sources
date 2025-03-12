// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 01:45:00 PM
// Design Name: 
// Module Name: UART_controller
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


module Main_controller(
	input i_Clk,
	output reg led,
	
	// connect to UART_interface
	input RX_DV,
	input [7:0] RX_Byte,	// data comme from UART_RX (received data from PC)	
		
	output reg TX_DV,	
	output reg [7:0] TX_Byte,	// data sent to UART_TX	(for sending to PC)
	input TX_Active,
	input TX_Done,
	
	// connect to TRNG
	input [31:0] data,
	output reg reset);
	
	localparam [2:0]s_Idle	 		= 3'd0,
					s_Read_command	= 3'd1,
					s_Init_TRNG		= 3'd2,
					s_Wait_TRNG		= 3'd3,
					s_TX_start		= 3'd4,
					s_TX_data		= 3'd5,
					s_cleanup		= 3'd6;
					
	localparam 	[7:0] cmd_Init = 8'h31;	
	
	reg [2:0] state = 3'd0;
	
	reg [31:0] tmp_reg = 32'd0;
		
	reg [2:0] cnt_bytes = 3'd0;
	reg [10:0] cnt_delay = 11'd0;

	
	// -------------------------------------------- process_state_Machine
	always @(posedge i_Clk)
	begin
		case(state)
		//----------------------- s_Idle
		s_Idle:	
			begin
				TX_DV <= 0;
				reset <= 0;
				led  <= 0;	
				if (RX_DV == 1) 
					state <= s_Read_command;
				else
					state <= s_Idle;
			end
			
		//----------------------- s_Read_command
		s_Read_command:	
			begin
				tmp_reg <= 3'd0;
				reset   <= 0;
				led  <= 1;	
				if (RX_DV == 1) begin
					if (RX_Byte == cmd_Init) begin
						state	<= s_Init_TRNG;
					end else
						state <= state;	
				end else
					state <= state;
			end
			
		//----------------------- s_Init_TRNG
		s_Init_TRNG:	
			begin
				reset <= 1;
				state <= s_Wait_TRNG;
			end
			
		//----------------------- s_Wait_TRNG
		// TRNG_Done, save desired data to tmp_reg
		s_Wait_TRNG:	
			begin				
				reset  <= 0;
				if (cnt_delay < 2047) begin
					cnt_delay <= cnt_delay + 1;
				end else begin		
					cnt_delay <= 0;
					tmp_reg <= data;
					state <= s_TX_start;																					
				end

										
			end
			
		//----------------------- s_TX_start
		// Transmit TRNG
		s_TX_start:	
			begin
				TX_DV   <= 1;			// indicates transmit byte
				state   <= s_TX_data;
				TX_Byte <= tmp_reg[7:0];
			end
		
		//----------------------- s_TX_data
		s_TX_data:	
			begin
				if (cnt_bytes < 4) begin
					if ( (TX_Active == 0) && (TX_Done == 1) ) begin
						TX_DV <= 1;
						cnt_bytes <= cnt_bytes + 1;
					end else begin
						TX_DV <= 0;
					end
					
					case(cnt_bytes)
						3'd1: TX_Byte <= tmp_reg[ 15:  8];
						3'd2: TX_Byte <= tmp_reg[ 23: 16];
						3'd3: TX_Byte <= tmp_reg[ 31: 24];
					endcase	
					
				end else begin
					state <= s_cleanup;
					TX_DV <= 0;
					cnt_bytes <= 0;
				end
			end
		
		//----------------------- s_cleanup
		s_cleanup:	
			begin
				state <= s_Read_command;
				reset <= 0;
				TX_DV <= 0;
			end
			
		default:
			begin
				state <= s_Idle;
			end
		endcase
	end

endmodule

