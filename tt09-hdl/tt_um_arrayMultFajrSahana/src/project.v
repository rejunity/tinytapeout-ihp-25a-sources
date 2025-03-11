/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_arrayMultFajrSahana (
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
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in, ena, clk, rst_n, 1'b0};

wire [3:0] m, q;
assign m = ui_in[7:4]; // m is the top 4 bits of the 8 bit input
assign q = ui_in[3:0];

wire [7:0] p;
assign uo_out = p;

wire s1, s2, s3, s4, s5, s6;
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11;
assign p[0] = m[0] & q[0];

fulladd a1 (m[0] & q[1], m[1] & q[0], 1'b0, p[1], c1);
fulladd a2 (m[2] & q[0], m[1] & q[1], c1, s1, c2);
fulladd a3 (m[3] & q[0], m[2] & q[1], c2, s2, c3);
fulladd a4 (m[3] & q[1], 1'b0, c3, s3, c4);

fulladd a5 (m[0] & q[2], s1,1'b0, p[2], c5);
fulladd a6 (m[1] & q[2], s2, c5, s4, c6);
fulladd a7 (m[2] & q[2], s3, c6, s5, c7);
fulladd a8 (m[3] & q[2], c4, c7, s6, c8);

fulladd a9 (m[0] & q[3], s4, 1'b0, p[3],c9);
fulladd a10 (m[1] & q[3], s5, c9, p[4], c10);
fulladd a11 (m[2] & q[3], s6, c10, p[5], c11);
fulladd a12 (m[3] & q[3], c8, c11, p[6], p[7]);

endmodule


module fulladd(
    input m,
    input q,
    input carryin,
    output sum,
    output carryout
    );
   
    assign sum = m ^ q ^ carryin;
    assign carryout = (carryin & (m^q)) | (m&q);

endmodule
