/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_array_mult_structural_sarahherrera (
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
  
  wire [3:0] m = ui_in[7:4];
  wire [3:0] q = ui_in[3:0];
  wire [7:0] p;

  wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10, carry11;
  wire sum1, sum2, sum3, sum4, sum5, sum6;

  assign p[0] = m[0] & q[0];

  Fadder adder1 (m[0] & q[1], m[1] & q[0], 1'b0, p[1], carry1);
  Fadder adder2 (m[2] & q[0], m[1] & q[1], carry1, sum1, carry2);
  Fadder adder3 (m[3] & q[0], m[2] & q[1], carry2, sum2, carry3);
  Fadder adder4 (m[3] & q[1], 1'b0, carry3, sum3, carry4);

  Fadder adder5 (m[0] & q[2], sum1,1'b0, p[2], carry5);
  Fadder adder6 (m[1] & q[2], sum2, carry5, sum4, carry6);
  Fadder adder7 (m[2] & q[2], sum3, carry6, sum5, carry7);
  Fadder adder8 (m[3] & q[2], carry4, carry7, sum6, carry8);

  Fadder adder9 (m[0] & q[3], sum4, 1'b0, p[3],carry9);
  Fadder adder10 (m[1] & q[3], sum5, carry9, p[4], carry10);
  Fadder adder11 (m[2] & q[3], sum6, carry10, p[5], carry11);
  Fadder adder12 (m[3] & q[3], carry8, carry11, p[6], p[7]);


  assign uo_out = p;

  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

module Fadder(
    input m,
    input q,
    input cin,
    output sum,
    output cout
    );
    
    assign sum = m ^ q ^ cin;
    assign cout = (cin & (m^q)) | (m&q);
    
endmodule 

