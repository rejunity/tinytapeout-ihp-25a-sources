/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_c7_array_mult (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [3:0] m, q;
  wire [7:0] p;

  assign q = ui_in[3:0];
  assign m = ui_in[7:4];


  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;
  

  wire m0q0, m1q0, m2q0, m3q0, m0q1, m1q1, m2q1, m3q1, m0q2, m1q2, m2q2, m3q2, m0q3, m1q3, m2q3, m3q3;   
    
    assign {m3q0, m2q0, m1q0, m0q0} = m & {4{q[0]}};   // m[3] & q0, m[2] & q0, m[1] & q0, 
    assign {m3q1, m2q1, m1q1, m0q1} = m & {4{q[1]}};
    assign {m3q2, m2q2, m1q2, m0q2} = m & {4{q[2]}};
    assign {m3q3, m2q3, m1q3, m0q3} = m & {4{q[3]}};
    
    
    wire int_sig1, int_sig2, int_sig3, int_sig4, int_sig5, int_sig6, int_sig7, int_sig8, int_sig9;
    wire fa01_out, fa02_out, fa03_out, fa13_in, fa11_out, fa12_out, fa13_out, fa23_in;
    
    assign p[0] = m0q0;
    
    full_adder inst1 (m1q0, m0q1, 1'b0, p[1], int_sig1);
    full_adder inst2 (m2q0, m1q1, int_sig1, fa01_out, int_sig2);
    full_adder inst3 (m3q0, m2q1, int_sig2, fa02_out, int_sig3);
    full_adder inst4 (1'b0, m3q1, int_sig3, fa03_out, fa13_in);
    
    full_adder inst5 (fa01_out, m0q2, 1'b0, p[2], int_sig4);
    full_adder inst6 (fa02_out, m1q2, int_sig4, fa11_out, int_sig5);
    full_adder inst7 (fa03_out, m2q2, int_sig5, fa12_out, int_sig6);
    full_adder inst8 (fa13_in, m3q2, int_sig6, fa13_out, fa23_in);
    
    full_adder inst9 (fa11_out, m0q3, 1'b0, p[3], int_sig7);
    full_adder inst10 (fa12_out, m1q3, int_sig7, p[4] , int_sig8);
    full_adder inst11 (fa13_out, m2q3, int_sig7, p[5], int_sig9);
    full_adder inst12 (fa23_in, m3q3, int_sig9, p[6], p[7]);

    assign uo_out[7:0] = p;
   

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