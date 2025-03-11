/*
 * Copyright (c) 2024 Cybercricetus
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_C_1_4bit_multiplier (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire[3:0] m, q;
    wire[7:0] p; 
    wire[3:0] s1, s2, s3, s4;

    assign m = ui_in[7:4];
    assign q = ui_in[3:0];

    ander an1(m, q[0], s1);          // S1: Q0 AND M
    ander an2(m, q[1], s2);          // S2: Q1 AND M
    ander an3(m, q[2], s3);          // S3: Q2 AND M
    ander an4(m, q[3], s4);          // S4: Q3 AND M
    
    wire[3:0] s_layer1, s_layer2, s_layer3;
    wire[3:0] o1, o2, o3;
    
    // adder layer 1
    adder a1(s1[1], s2[0], 1'b0, s_layer1[0], o1[0]);
    adder a2(s1[2], s2[1], o1[0], s_layer1[1], o1[1]);
    adder a3(s1[3], s2[2], o1[1], s_layer1[2], o1[2]);
    adder a4(1'b0, s2[3], o1[2], s_layer1[3], o1[3]);

    // adder layer 2
    adder a5(s_layer1[1], s3[0], 1'b0, s_layer2[0], o2[0]);
    adder a6(s_layer1[2], s3[1], o2[0], s_layer2[1], o2[1]);
    adder a7(s_layer1[3], s3[2], o2[1], s_layer2[2], o2[2]);
    adder a8(o1[3], s3[3], o2[2], s_layer2[3], o2[3]);

    // adder layer 3
    adder a9(s_layer2[1], s4[0], 1'b0, s_layer3[0], o3[0]);
    adder a10(s_layer2[2], s4[1], o3[0], s_layer3[1], o3[1]);
    adder a11(s_layer2[3], s4[2], o3[1], s_layer3[2], o3[2]);
    adder a12(o2[3], s4[3], o3[2], s_layer3[3], o3[3]);
    
    
    assign p[0] = s1[0];
    assign p[1] = s_layer1[0];
    assign p[2] = s_layer2[0];
    assign p[3] = s_layer3[0];
    assign p[4] = s_layer3[1];
    assign p[5] = s_layer3[2];
    assign p[6] = s_layer3[3];
    assign p[7] = o3[3];

    assign uo_out = p;

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule


module adder(A, B, Cin, Y, Cout);
    input A, B, Cin;
    output Y, Cout;
    assign Y = A^B^Cin;
    assign Cout = (A&B)|(A&Cin)|(B&Cin);
endmodule


module ander(A, b, Y);
    input[3:0] A;
    input b;
    output[3:0] Y;
    assign Y[0] = A[0] & b;
    assign Y[1] = A[1] & b;
    assign Y[2] = A[2] & b;
    assign Y[3] = A[3] & b;
endmodule