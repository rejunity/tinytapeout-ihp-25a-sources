/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_array_mult_structural_GnahsLliw (
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
    wire int_sig1, int_sig2, int_sig3, int_sig4, int_sig5, int_sig6;
    wire c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10;
    
    assign p[0] = m[0] & q[0];
    full_adder inst1 (m[1] & q[0], m[0] & q[1], 1'b0, p[1], c0);
    full_adder inst2 (m[2]& q[0], m[1] & q[1], c0 , int_sig1, c1);
    full_adder inst3 (m[3]& q[0], m[2] & q[1], c1 , int_sig2, c2);
    full_adder inst4 (1'b0, m[3] & q[1], c2 , int_sig3, c3);
    full_adder inst5 (int_sig1, m[0] & q[2], 1'b0, p[2], c4);
    full_adder inst6 (int_sig2, m[1] & q[2], c4 , int_sig4, c5);
    full_adder inst7 (int_sig3, m[2] & q[2], c5 , int_sig5, c6);
    full_adder inst8 (c3, m[3] & q[2], c6 , int_sig6, c7);
    full_adder inst9 (int_sig4, m[0] & q[3], 1'b0, p[3], c8);
    full_adder inst10 (int_sig5, m[1] & q[3], c8 , p[4], c9);
    full_adder inst11 (int_sig6, m[2] & q[3], c9 , p[5], c10);
    full_adder inst12 (c7, m[3] & q[3], c10 , p[6], p[7]);

  assign uio_out = 0;
  assign uio_oe  = 0;
  assign uo_out = p;
  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

module full_adder(
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
