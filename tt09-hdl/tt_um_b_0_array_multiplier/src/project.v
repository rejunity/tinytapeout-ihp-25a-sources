/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_b_0_array_multiplier (
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


  wire [3:0] m = ui_in[3:0];
  wire [3:0] q = ui_in[7:4];
  wire [7:0] p;


  wire int_sig1, int_sig2, int_sig3, int_sig4, int_sig5, int_sig6, int_sig7, int_sig8, int_sig9, int_sig10, int_sig11;
  wire result1, result2, result3, result4, result5, result6;

  assign p[0] = m[0] & q[0];

  FullAdder adder1 (m[0] & q[1], m[1] & q[0], 1'b0, p[1], int_sig1);
  FullAdder adder2 (m[2] & q[0], m[1] & q[1], int_sig1, result1, int_sig2);
  FullAdder adder3 (m[3] & q[0], m[2] & q[1], int_sig2, result2, int_sig3);
  FullAdder adder4 (m[3] & q[1],1'b0,int_sig3, result3, int_sig4);

  FullAdder adder5 (m[0] & q[2], result1,1'b0, p[2], int_sig5);
  FullAdder adder6 (m[1] & q[2], result2, int_sig5, result4, int_sig6);
  FullAdder adder7 (m[2] & q[2], result3, int_sig6, result5, int_sig7);
  FullAdder adder8 (m[3] & q[2], int_sig4, int_sig7, result6, int_sig8);

  FullAdder adder9 (m[0] & q[3], result4,1'b0, p[3], int_sig9);
  FullAdder adder10 (m[1] & q[3], result5, int_sig9, p[4], int_sig10);
  FullAdder adder11 (m[2] & q[3], result6, int_sig10, p[5], int_sig11);
  FullAdder adder12 (m[3] & q[3], int_sig8, int_sig11, p[6], p[7]);
  
  assign uo_out = p;

  assign uio_out = 0;
  assign uio_oe  = 0;
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_oe, 1'b0};

endmodule

module FullAdder(
    input m,
    input q,
    input cin,
    output result,
    output cout
    );
    
    assign result = m ^ q ^ cin;
    assign cout = (cin & (m^q)) | (m&q);
    
  endmodule


