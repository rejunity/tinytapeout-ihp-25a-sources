/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_b_2_array_multiplier (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire [3:0] m = ui_in[7:4];
wire [3:0] q = ui_in[3:0];
wire [7:0] p; 

wire [3:0] pp0, pp1, pp2, pp3;  //partial product between m and  one-bit of q
wire c1,c2,c3,c4,c5,c6,c7,c8; //wire from product to full adder 
wire [3:0] s1; //wire between full adders 
//assign partial products between m and q 
assign pp0 = m & {4{q[0]}}; //m & q0 4-bit
    assign pp1 = m & {4{q[1]}}; //m & q1 4-bit
    assign pp2 = m & {4{q[2]}}; //m & q2 4-bit
    assign pp3 = m & {4{q[3]}}; //m & q3 4-bit
   
    //sum the partial products
    assign p[0] = pp0[0]; //for bit 0
   
    full_adder fa1(.a(pp0[1]), .b(pp1[0]), .cin(1'b0), .sum(p[1]), .cout(c1));//full adder for bit 1
    full_adder fa2(.a(pp0[2]), .b(pp1[1]), .cin(c1), .sum(s1[0]), .cout(c2)); //full adder for bit 2
    full_adder fa3(.a(s1[0]), .b(pp2[0]), .cin(1'b0), .sum(p[2]), .cout(c3));
   
    full_adder fa4(.a(pp0[3]), .b(pp1[2]), .cin(c2), .sum(s1[1]), .cout(c4)); //full adder for bit 3
    full_adder fa5(.a(s1[1]), .b(pp2[1]), .cin(c3), .sum(p[3]), .cout(c5));
     
    full_adder fa6(.a(pp1[3]), .b(pp2[2]), .cin(c4), .sum(s1[2]), .cout(c6));  
    full_adder fa7(.a(s1[2]), .b(pp3[0]), .cin(c5), .sum(p[4]), .cout(c7)); //full adder for bit 4
   
    full_adder fa8(.a(pp2[3]), .b(pp3[1]), .cin(c6), .sum(p[5]), .cout(c8));  
    full_adder fa9(.a(pp3[2]), .b(c7), .cin(c8), .sum(p[6]), .cout(p[7]));



// All output pins must be assigned. If not used, assign to 0.
assign uo_out  = p;  // Example: ou_out is the sum of ui_in and uio_in

assign uio_out = 0;
assign uio_oe  = 0;

// List all unused inputs to prevent warnings
wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

module full_adder (
    input wire a, 
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule 