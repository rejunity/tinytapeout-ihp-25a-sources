/*
 * Copyright (c) 2024 Hanyuan (Bob) Huang
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_b_8_array_multiplier(
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




//partial products 
    //partial digit 0 
    wire p00 = m[0] & q[0];
    wire p01 = m[0] & q[1];
    wire p02 = m[0] & q[2];
    wire p03 = m[0] & q[3];
    
    //partial digit 1 
    wire p10 = m[1] & q[0];
    wire p11 = m[1] & q[1];
    wire p12 = m[1] & q[2];
    wire p13 = m[1] & q[3];   
    
    //partial digit 2 
    wire p20 = m[2] & q[0];
    wire p21 = m[2] & q[1];
    wire p22 = m[2] & q[2];
    wire p23 = m[2] & q[3];
    
    //partial digit 3 
    wire p30 = m[3] & q[0];
    wire p31 = m[3] & q[1];
    wire p32 = m[3] & q[2];
    wire p33 = m[3] & q[3];
    
    
    //wiring internal signals for adders 
    wire s1, s2, s3, s4, s5, s6, s7, s8, s9;
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12;
    
    //row 1
    assign p[0] = p00;
    
    //row 2 
    fullad fa1(.cin(1'b0), .x(p01), .y(p10), .sum(p[1]), .cout(c1));
    fullad fa2(.cin(c1), .x(p02), .y(p11), .sum(s1), .cout(c2));
    fullad fa3(.cin(c2), .x(p03), .y(p12), .sum(s2), .cout(c3));
    fullad fa4(.cin(c3), .x(1'b0), .y(p13), .sum(s3), .cout(c4));
    
    //row 3 
    fullad fa5(.cin(1'b0), .x(s1), .y(p20), .sum(p[2]), .cout(c5));
    fullad fa6(.cin(c5), .x(s2), .y(p21), .sum(s4), .cout(c6));
    fullad fa7(.cin(c6), .x(s3), .y(p22), .sum(s5), .cout(c7));
    fullad fa8(.cin(c7), .x(c4), .y(p23), .sum(s6), .cout(c8));
    
    //row 4 
    fullad fa9(.cin(1'b0), .x(s4), .y(p30), .sum(p[3]), .cout(c9));
    fullad fa10(.cin(c9), .x(s5), .y(p31), .sum(s7), .cout(c10));
    fullad fa11(.cin(c10), .x(s6), .y(p32), .sum(s8), .cout(c11));
    fullad fa12(.cin(c11), .x(c8), .y(p33), .sum(s9), .cout(c12));
    
    //rest of digits 
    assign p[4] = s7;
    assign p[5] = s8;
    assign p[6] = s9;
    assign p[7] = c12;


    assign uo_out = p; 


    


  assign uio_out = 0;
  assign uio_oe  = 0;



  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

  endmodule


module fullad(cin, x, y, sum, cout);
    input x, y, cin;
    output sum, cout;
    wire z1, z2, z3;
    
    xor(sum,x,y,cin);
    and(z1,x,y);
    and(z2,x,cin);
    and(z3,y,cin);
    
    or(cout,z1,z2,z3);
     
endmodule


