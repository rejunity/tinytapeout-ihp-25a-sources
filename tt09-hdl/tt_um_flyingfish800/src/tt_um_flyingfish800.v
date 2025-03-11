/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_flyingfish800 (
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
  assign uo_out  = Q[7:0];  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = Q[15:8];
  assign uio_oe  = 1;

  reg [15:0] Q;
  reg [15:0] D;

  always @(posedge clk) begin
    Q <= D;
  end

  always @(*) begin
    if (rst_n)
      D = Q + {8'h0, ui_in};
    else 
      D = 0;
  end

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
