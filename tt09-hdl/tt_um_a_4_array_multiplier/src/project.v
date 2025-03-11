/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_a_4_array_multiplier (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    wire [3:0] m = ui_in[7:4]; 
    wire [3:0] q = ui_in[3:0]; 
    wire [7:0] p;              

    wire [3:0] pp0, pp1, pp2, pp3;
    wire [4:0] sum1, sum2, sum3;
    wire [4:0] carry1, carry2, carry3;

    assign pp0 = m & {4{q[0]}};
    assign pp1 = m & {4{q[1]}};
    assign pp2 = m & {4{q[2]}};
    assign pp3 = m & {4{q[3]}};

    assign p[0] = pp0[0];
    half_add ha1 (pp0[1], pp1[0], p[1], carry1[0]);
    full_add fa1 (pp0[2], pp1[1], carry1[0], sum1[0], carry1[1]);
    full_add fa2 (pp0[3], pp1[2], carry1[1], sum1[1], carry1[2]);
    full_add fa3 (1'b0, pp1[3], carry1[2], sum1[2], carry1[3]);

    half_add ha2 (sum1[0], pp2[0], p[2], carry2[0]);
    full_add fa4 (sum1[1], pp2[1], carry2[0], sum2[0], carry2[1]);
    full_add fa5 (sum1[2], pp2[2], carry2[1], sum2[1], carry2[2]);
    full_add fa6 (carry1[3], pp2[3], carry2[2], sum2[2], carry2[3]);

    half_add ha3 (sum2[0], pp3[0], p[3], carry3[0]);
    full_add fa7 (sum2[1], pp3[1], carry3[0], p[4], carry3[1]);
    full_add fa8 (sum2[2], pp3[2], carry3[1], p[5], carry3[2]);
    full_add fa9 (carry2[3], pp3[3], carry3[2], p[6], p[7]);

    assign uo_out = p;
    assign uio_out = 0;
    assign uio_oe  = 0;

    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

module half_add (
    input a, b,
    output sum, cout
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule

module full_add (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule
