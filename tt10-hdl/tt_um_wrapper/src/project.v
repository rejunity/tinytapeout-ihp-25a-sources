/*
 * Copyright (c) 2025 Patrick Lampl
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none

module tt_um_wrapper (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  tt_digclock4_top dc4 (
        .clk_i(clk),
        .rstn_i(rst_n),
        .pb_i(ui_in[1:0]),	 //hour inc, min inc
        .seg_o(uo_out[7:0]), //segment format dot,a,b,c,d,e,f,g
        .sel_o(uio_out[5:0]) //digit select format: hhmmss
    );

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:6] = 0;
  assign uio_oe[7:0]  = {8{ena}};

  // List all unused inputs to prevent warnings
  wire _unused = &{ui_in[7:2], uio_in, 1'b0};

endmodule
