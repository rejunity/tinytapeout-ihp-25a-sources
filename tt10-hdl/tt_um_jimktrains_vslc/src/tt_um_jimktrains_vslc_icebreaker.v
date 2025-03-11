/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_icebreaker (
	input  CLK,
	input  BTN_N,
  input  BTN1,
  input  BTN2,
  input  BTN3,
  output P1A1,
  output P1A2,
  output P1A3,
  output P1A4,
  output P1A7,
  output P1A8,
  output P1A9,
  output P1A10,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LEDR_N,
  output LEDG_N,
  output LED_BLU_N,
  output LED_GRN_N,
  output LED_RED_N,
  inout [7:0]uio
);

wire [7:0] uio_oe;
wire [7:0] uio_in;
wire [7:0] uio_out;

wire [7:0] ui_in;
wire [7:0] uo_out;

assign ui_in[0] = BTN_N;
assign ui_in[1] = BTN1;
assign ui_in[2] = BTN2;
assign ui_in[3] = BTN3;
assign ui_in[4] = 0;
assign ui_in[5] = 0;
assign ui_in[6] = 0;
assign ui_in[7] = 0;

assign LED1 = uo_out[0];
assign LED2 = uo_out[1];
assign LED3 = uo_out[2];
assign LED4 = uo_out[3];
assign LED5 = uo_out[4];
assign LEDR_N = !uo_out[5];
assign LEDG_N = !uo_out[6];
// assign LED_BLU_N = !uo_out[7];
assign LED_BLU_N = BTN_N;

assign uio[0] = uio_oe[0] ? uio_out[0] : 1'bz;
assign uio[1] = uio_oe[1] ? uio_out[1] : 1'bz;
assign uio[2] = uio_oe[2] ? uio_out[2] : 1'bz;
assign uio[3] = uio_oe[3] ? uio_out[3] : 1'bz;
assign uio[4] = uio_oe[4] ? uio_out[4] : 1'bz;
assign uio[5] = uio_oe[5] ? uio_out[5] : 1'bz;
assign uio[6] = uio_oe[6] ? uio_out[6] : 1'bz;
assign uio[7] = uio_oe[7] ? uio_out[7] : 1'bz;
assign uio_in[0] = uio[0];
assign uio_in[1] = uio[1];
assign uio_in[2] = uio[2];
assign uio_in[3] = uio[3];
assign uio_in[4] = uio[4];
assign uio_in[5] = uio[5];
assign uio_in[6] = uio[6];
// I made a solder-bridge to ground on the board, but it's still high
// constantly. I'm just hard-coding this to 0 to solve the problem.
// I need to have this accessible for the testbench, although I just
// realized I can access internal variables in the dut, so that might
// be the best option.
assign uio_in[7] = 0;

wire ena = 1;

reg [31:0]counter = 0;

reg rst_n = 0;
assign LED_GRN_N = !uo_out[7];
assign LED_RED_N = 1;

// assign {P1A1, FLASH_IO0, P1A2, P1A3, P1A4, P1A7, P1A8, P1A9, P1A10, FLASH_IO1} =  {en1, en2, a,f,b,g,c,d,e,dp};
assign P1A1 = uo_out[0];
assign P1A2 = uo_out[1];
assign P1A3 = uo_out[2];
assign P1A4 = uo_out[3];

assign P1A7 = uo_out[4];
assign P1A8 = uo_out[5];
assign P1A9 = uo_out[6];
assign P1A10= uo_out[7];


tt_um_jimktrains_vslc_core core (
  ui_in,
  uo_out,
  uio_in,
  uio_out,
  uio_oe,
  ena,
  CLK,
  rst_n
);

always @(posedge CLK) begin
  counter <= rst_n ? counter : counter + 1;
  rst_n <= rst_n ? rst_n : counter < 8;
end
endmodule
