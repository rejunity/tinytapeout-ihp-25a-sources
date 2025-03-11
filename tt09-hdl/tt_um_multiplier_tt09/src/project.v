/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none


module tt_um_multiplier_tt09 (
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
  array_mult_structural sol(ui_in[7:4], ui_in[3:0], uo_out[7:0]);  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

module array_mult_structural(
    input [3:0] m,
    input [3:0] q,
    output [7:0] p
    );

    wire [3:0] x0_in, x1_in, x2_in, x3_in;
    wire [3:0] int1, int2, int3, int4, int5, int6, int7, int8, int9, int10;

    and(x0_in[0], m[0], q[0]);
    and(x0_in[1], m[0], q[1]);
    and(x0_in[2], m[0], q[2]);
    and(x0_in[3], m[0], q[3]);
    black_box bb_00(x0_in[0], 1'b0, 1'b0, int1[0], int2[0]);
    black_box bb_01(x0_in[1], 1'b0, 1'b0, int1[1], int2[1]);
    black_box bb_02(x0_in[2], 1'b0, 1'b0, int1[2], int2[2]);
    black_box bb_03(x0_in[3], 1'b0, 1'b0, int1[3], int2[3]);

    and(x1_in[0], m[1], q[0]);
    and(x1_in[1], m[1], q[1]);
    and(x1_in[2], m[1], q[2]);
    and(x1_in[3], m[1], q[3]);
    black_box bb_10(x1_in[0], int1[1], int2[0], int3[0], int4[0]);
    black_box bb_11(x1_in[1], int1[2], int2[1], int3[1], int4[1]);
    black_box bb_12(x1_in[2], int1[3], int2[2], int3[2], int4[2]);
    black_box bb_13(x1_in[3], 1'b0, int2[3], int3[3], int4[3]);

    and(x2_in[0], m[2], q[0]);
    and(x2_in[1], m[2], q[1]);
    and(x2_in[2], m[2], q[2]);
    and(x2_in[3], m[2], q[3]);
    black_box bb_20(x2_in[0], int3[1], int4[0], int5[0], int6[0]);
    black_box bb_21(x2_in[1], int3[2], int4[1], int5[1], int6[1]);
    black_box bb_22(x2_in[2], int3[3], int4[2], int5[2], int6[2]);
    black_box bb_23(x2_in[3], 1'b0, int4[3], int5[3], int6[3]);

    and(x3_in[0], m[3], q[0]);
    and(x3_in[1], m[3], q[1]);
    and(x3_in[2], m[3], q[2]);
    and(x3_in[3], m[3], q[3]);
    black_box bb_30(x3_in[0], int5[1], int6[0], int7[0], int8[0]);
    black_box bb_31(x3_in[1], int5[2], int6[1], int7[1], int8[1]);
    black_box bb_32(x3_in[2], int5[3], int6[2], int7[2], int8[2]);
    black_box bb_33(x3_in[3], 1'b0, int6[3], int7[3], int8[3]);

    black_box bb4(int7[1], int8[0], 1'b0, int9[0], int10[0]);
    black_box bb5(int7[2], int8[1], int10[0], int9[1], int10[1]);
    black_box bb6(int7[3], int8[2], int10[1], int9[2], int10[2]);
    black_box bb7(1'b0, int8[3], int10[2], int9[3], int10[3]);

    assign p = {int9[3], int9[2], int9[1], int9[0], int7[0], int5[0], int3[0], int1[0]};

endmodule

module black_box(
    input a,
    input b,
    input c,
    output y,
    output z
    );

// Internal Signals
    wire int_sig1;
    wire int_sig2;
    wire int_sig3;
    wire int_sig4;
    wire int_sig5;
    wire int_sig6;
    wire int_sig7;
    wire int_sig8;

    assign int_sig1 = a & ~b;
    assign int_sig2 = ~a & b;
    assign int_sig3 = int_sig1 + int_sig2;
    assign int_sig4 = int_sig3 & ~c;
    assign int_sig5 = ~int_sig3 & c;
    assign y = int_sig4 + int_sig5;
    assign int_sig6 = a & b;
    assign int_sig7 = b & c;
    assign int_sig8 = c & a;
    assign z = int_sig6 | int_sig7 | int_sig8;

endmodule
