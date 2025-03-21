/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_daobaanh_rng (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:4]  = 4'b0;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{rst_n, ui_in[7:1],uio_in[7:0],  1'b0};

  // ring_osc part
  top_TRNG TRNG_inst(
    .clk_sys(clk),
    .i_en(ena),
    .RX_Serial(ui_in[0]),
    .TX_Serial(uo_out[0]),
    .o_RO(uo_out[1]),
    .o_RG(uo_out[2]),
    .led(uo_out[3]));

endmodule
