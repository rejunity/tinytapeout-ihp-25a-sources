/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_project_tt09 (
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
  // assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 8'h0;
  assign uio_oe = 8'h0;

  // List all unused inputs to prevent warnings
  reg [25:0] div;
  wire sec = div == 26'd49_999_999;
  always @(posedge clk) begin
    if (sec) begin
      div <= '0;
    end else begin
      div <= div + 1;
    end
  end

  reg [7:0] U;
  lif lif1(.clk(clk), .I(ui_in), .rst_n(~rst_n), .en(&div), .spike(uo_out[0]));
  assign uo_out[6:1] = {6{uo_out[0]}};
  reg indicator;
  assign uo_out[7] = indicator;
  always_ff @(posedge clk) begin
    if (sec) begin
      indicator <= ~indicator;
    end
  end

endmodule
