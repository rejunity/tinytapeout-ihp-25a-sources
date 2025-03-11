/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_michaelmcculloch_alu (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Instatiate the ALU:
  wire [7:0] a;
  wire [7:0] b;
  wire [3:0] alu_op;
  wire [7:0] alu_out;

  assign a = {2'b0, uio_in[5:0]};
  assign b = {2'b0, ui_in[3:0], uio_in[7:6]};
  assign alu_op = ui_in[7:4];

  alu theALU(.a(a), .b(b), .alu_op(alu_op), .out(alu_out));

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe = 8'd0;  // All bidirectional will be inputs
  assign uio_out = 8'd0; // Not used
  assign uo_out = alu_out;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};



endmodule
