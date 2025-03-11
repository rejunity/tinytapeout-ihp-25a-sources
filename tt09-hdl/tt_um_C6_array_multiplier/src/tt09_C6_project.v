/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_C6_array_multiplier(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire [3:0] m= ui_in[7:4];
    wire [3:0] q= ui_in[3:0];
    wire[7:0] p;
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = p;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n,uio_in, 1'b0};
    array_mult_structural inst1(m,q,p);
endmodule
module array_mult_structural(m,q,p);
    input [3:0] m,q;
    output [7:0] p;
    wire[3:0] w1, w2, w3, w4, partial1, partial2, partial3;
    wire[2:0] C;
    
    assign w1 = {m[3]&q[0], m[2]&q[0], m[1]&q[0], m[0]&q[0]};
    assign w2 = {m[3]&q[1], m[2]&q[1], m[1]&q[1], m[0]&q[1]};
    assign w3 = {m[3]&q[2], m[2]&q[2], m[1]&q[2], m[0]&q[2]};
    assign w4 = {m[3]&q[3], m[2]&q[3], m[1]&q[3], m[0]&q[3]};
    
    add_4bit stage0 (w2,{1'b0, w1[3:1]},partial1,C[0]);
    add_4bit stage1 (w3,{C[0], partial1[3:1]},partial2,C[1]);
    add_4bit stage2 (w4,{C[1], partial2[3:1]},partial3,C[2]);
    
    assign p = {C[2], partial3, partial2[0], partial1[0],w1[0]};
endmodule
module fulladd(
    input a,b,cin,
    output sum,carry
);

wire w1,w2,w3,w4;       //Internal connections

xor(w1,a,b);
xor(sum,w1,cin);        //Sum output

and(w2,a,b);
and(w3,b,cin);
and(w4,cin,a);

or(carry,w2,w3,w4);     //carry output

endmodule
module add_4bit(x,y,z,carry_out);
    input [3:0] x,y;
    output [3:0] z;
    output carry_out;
    wire [3:1] C;
    
    fulladd stage0 (x[0],y[0],1'b0,z[0],C[1]);
    fulladd stage1 (x[1],y[1],C[1],z[1],C[2]);
    fulladd stage2 (x[2],y[2],C[2],z[2],C[3]);
    fulladd stage3 (x[3],y[3],C[3],z[3],carry_out);
endmodule
