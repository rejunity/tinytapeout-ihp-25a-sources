/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_array_mult_joe_leighthardt (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
    

  // All output pins must be assigned. If not used, assign to 0.

    );
    wire [3:0] m = ui_in[7:4];
    wire [3:0] q = ui_in[3:0];
    wire [7:0] p;
    wire [3:0] pp0;
    wire [3:0] pp1;
    wire [3:0] pp2;
    wire [3:0] pp3;
    wire intsig1;
    wire intsig2;
    wire intsig3;
    wire intsig4;
    wire intsig5;
    wire intsig6;
    wire intsig7;
    wire intsig8;
    wire intsig9;
    wire intsig10;
    wire intsig11;
    wire intsig12;
    wire intsig13;
    wire intsig14;
    wire intsig15;
    wire intsig16;
    wire intsig17;
    

    
    
    assign pp0 = {m[3]&q[0],m[2]&q[0],m[1]&q[0],m[0]&q[0]};
    assign pp1 = {m[3]&q[1],m[2]&q[1],m[1]&q[1],m[0]&q[1]};
    assign pp2 = {m[3]&q[2],m[2]&q[2],m[1]&q[2],m[0]&q[2]};
    assign pp3 = {m[3]&q[3],m[2]&q[3],m[1]&q[3],m[0]&q[3]};
    assign p[0] = pp0[0];
    adder inst1(pp0[1],pp1[0],1'b0,p[1],intsig1);
    adder inst2(pp0[2],pp1[1],intsig1,intsig2,intsig3);
    adder inst3(pp0[3],pp1[2],intsig3,intsig4,intsig5);
    adder inst4(1'b0,pp1[3],intsig5,intsig6,intsig7);
    
    adder inst5(pp2[0],1'b0,intsig2,p[2],intsig8);
    adder inst6(pp2[1],intsig4,intsig8, intsig9, intsig10);
    adder inst7(pp2[2], intsig10, intsig6, intsig11, intsig12);
    adder inst8(pp2[3], intsig12, intsig7, intsig13, intsig14);
    
    adder inst9(pp3[0],1'b0,intsig9,p[3],intsig15);
    adder inst10(pp3[1],intsig15, intsig11, p[4],intsig16);
    adder inst11(pp3[2], intsig16, intsig13,p[5],intsig17);
    adder inst12(pp3[3],intsig17, intsig14, p[6],p[7]);
    assign uo_out = p;
    assign uio_out = 0;
    assign uio_oe = 0;
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n,uio_in, 1'b0};
endmodule
module adder(
input  x,
input y,
input carry,
output  z,
output carry_out
    );
    
   
    wire int_sig1, int_sig2,int_sig3,int_sig4,int_sig5,int_sig6,int_sig7,int_sig8;
    assign int_sig1 = x & ~y;
    assign int_sig2 = ~x & y;
    assign int_sig3 = int_sig1 + int_sig2;
    assign int_sig4 = int_sig3 & ~carry ;
    
    assign int_sig5 = ~int_sig3 & carry;
    assign z = int_sig4 + int_sig5; 
    assign int_sig6 = x & y;
    assign int_sig7 = y & carry;
    assign int_sig8 = carry & x;    
    assign carry_out = int_sig6 | int_sig7 | int_sig8;
endmodule
