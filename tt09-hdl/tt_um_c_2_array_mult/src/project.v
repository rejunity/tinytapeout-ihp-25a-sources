/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_c_2_array_mult (
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
  array_mult_structural array_mult_inst (
      .m(ui_in[3:0]),
      .q(ui_in[7:4]),
      .p(uo_out)
  );

  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0, uio_in};
endmodule

module array_mult_structural (
    input [3:0] m,
    input [3:0] q,
    output [7:0] p
);
    wire cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10, cout11, cout12;
    wire s2, s3, s4, s6, s7, s8;
    assign p[0] = m[0] & q[0];
    full_adder fa1 (m[1] & q[0], m[0] & q[1], 1'b0, p[1], cout1);
    full_adder fa2 (m[2] & q[0], m[1] & q[1], cout1, s2, cout2);
    full_adder fa3 (m[3] & q[0], m[2] & q[1], cout2, s3, cout3);
    full_adder fa4 (1'b0, m[3] & q[1], cout2, s4, cout4);
    full_adder fa5 (s2, m[0] & q[2], 1'b0, p[2], cout5);
    full_adder fa6 (s3, m[1] & q[2], cout5, s6, cout6);
    full_adder fa7 (s4, m[2] & q[2], cout6, s7, cout7);
    full_adder fa8 (m[3] & q[2], cout4, cout7, s8, cout8);
    full_adder fa9 (m[0] & q[3], s6, 1'b0, p[3], cout9);
    full_adder fa10 (m[1] & q[3], s7, cout9, p[4], cout10);
    full_adder fa11 (m[2] & q[3], s8, cout10, p[5], cout11);
    full_adder fa12 (m[3] & q[3], cout8, cout11, p[6], p[7]);


endmodule

module full_adder (
    input a,b,cin,
    output sum,carry
);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin)  | (cin & a) ;

endmodule