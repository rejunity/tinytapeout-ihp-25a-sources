/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_C8_array_mult (
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
  assign m = ui_in[3:0];
  assign q = ui_in[7:4]; 
  
  wire [3:0] pp0, pp1, pp2, pp3;
  wire [7:0] sum0, sum1, sum2; 
  wire [7:0] shifted_pp1, shifted_pp2, shifted_pp3;
 


  assign pp0 = m & {4{q[0]}};  
  assign pp1 = m & {4{q[1]}};  
  assign pp2 = m & {4{q[2]}};  
  assign pp3 = m & {4{q[3]}};      

  assign shifted_pp1 = {pp1, 1'b0};       
  assign shifted_pp2 = {pp2, 2'b00};       
  assign shifted_pp3 = {pp3, 3'b000};      

  assign sum0 = {4'b0000, pp0};              
  assign sum1 = sum0 + shifted_pp1;          
  assign sum2 = sum1 + shifted_pp2;          
  
  assign uo_out[7:0] = sum2 + shifted_pp3; 
   
 // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 8'b0;
  assign uio_oe = 8'b0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
