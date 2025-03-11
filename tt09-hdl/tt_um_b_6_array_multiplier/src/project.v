/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_b_6_array_multiplier (
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

  wire [3:0] m = ui_in [7:4];
  wire [3:0] q = ui_in [3:0];
  wire [7:0] p;

    wire C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11;
    wire sum1, sum2, sum3, sum4, sum5, sum6;

    assign p[0] = m[0] & q[0];

    fulladd fa1 (m[0] & q[1], m[1] & q[0], 1'b0, p[1], C1);
    fulladd fa2 (m[2] & q[0], m[1] & q[1], C1, sum1, C2);
    fulladd fa3 (m[3] & q[0], m[2] & q[1], C2, sum2, C3);
    fulladd fa4 (m[3] & q[1], 1'b0, C3, sum3, C4);
    fulladd fa5 (m[0] & q[2], sum1,1'b0, p[2], C5);
    fulladd fa6 (m[1] & q[2], sum2, C5, sum4, C6);
    fulladd fa7 (m[2] & q[2], sum3, C6, sum5, C7);
    fulladd fa8 (m[3] & q[2], C4, C7, sum6, C8);
    fulladd fa9 (m[0] & q[3], sum4, 1'b0, p[3],C9);
    fulladd fa10 (m[1] & q[3], sum5, C9, p[4], C10);
    fulladd fa11 (m[2] & q[3], sum6, C10, p[5], C11);
    fulladd fa12 (m[3] & q[3], C8, C11, p[6], p[7]);    

  assign uo_out = p;

  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

module fulladd(Cin, x, y, s, Cout);
    input x, y, Cin;
    output s, Cout;
    wire z1, z2, z3;

    assign s = x ^ y ^ Cin; 
    assign z1 = x & y;
    assign z2 = x & Cin;
    assign z3 = y & Cin;
    assign Cout = z1 | z2 | z3;
endmodule