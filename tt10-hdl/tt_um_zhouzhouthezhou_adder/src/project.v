/*
 * Copyright (c) 2024 Kyle Zhou
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_zhouzhouthezhou_adder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [7:0] sum = ui_in[7:4] + ui_in[3:0];
  reg [7:0] out = 8'h3f;

  always @ (posedge clk) begin
    if (sum == 0) begin
      out <= 8'h3f;
    end else if (sum == 1) begin
      out <= 8'h06;
    end else if (sum == 2) begin
      out <= 8'h5b;
    end else if (sum == 3) begin
      out <= 8'h4f;
    end else if (sum == 4) begin
      out <= 8'h66;
    end else if (sum == 5) begin
      out <= 8'h6d;
    end else if (sum == 6) begin
      out <= 8'h7d;
    end else if (sum == 7) begin
      out <= 8'h07;
    end else if (sum == 8) begin
      out <= 8'h7f;
    end else if (sum == 9) begin
      out <= 8'h67;
    end else begin
      out <= 8'h80;
    end
  end


  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out = out;
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in, ena, rst_n, 1'b0};

endmodule
