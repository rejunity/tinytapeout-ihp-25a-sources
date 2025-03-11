/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module mlp_xls(
  input wire clk,
  input wire [3:0] i,
  input wire [3:0] w,
  input wire [15:0] t,
  output wire [31:0] out
);
  // lint_off SIGNED_TYPE
  // lint_off MULTIPLY
  function automatic [7:0] smul8b_4b_x_4b (input reg [3:0] lhs, input reg [3:0] rhs);
    reg signed [3:0] signed_lhs;
    reg signed [3:0] signed_rhs;
    reg signed [7:0] signed_result;
    begin
      signed_lhs = $signed(lhs);
      signed_rhs = $signed(rhs);
      signed_result = signed_lhs * signed_rhs;
      smul8b_4b_x_4b = $unsigned(signed_result);
    end
  endfunction
  // lint_on MULTIPLY
  // lint_on SIGNED_TYPE

  // ===== Pipe stage 0:
  wire [14:0] p0_bit_slice_47_comb;
  wire [7:0] p0_prod_comb;
  wire [15:0] p0_total_comb;
  wire [15:0] p0_relu_comb;
  assign p0_bit_slice_47_comb = t[14:0];
  assign p0_prod_comb = smul8b_4b_x_4b(i, w);
  assign p0_total_comb = {{1{p0_bit_slice_47_comb[14]}}, p0_bit_slice_47_comb} + {{8{p0_prod_comb[7]}}, p0_prod_comb};
  assign p0_relu_comb = p0_total_comb & {16{$signed(p0_total_comb) > $signed(16'h0000)}};
  assign out = {p0_total_comb, p0_relu_comb};
endmodule

module tt_um_udxs (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg signed [15:0] total;
  wire signed [15:0] new_total;
  wire signed [15:0] relu_out;
  wire [31:0] outp;

  mlp_xls my_mlp(
    .clk(clk),
    .i(uio_in[3:0]),
    .w(uio_in[7:4]),
    .t(total),
    .out(outp)
  );

  assign new_total = outp[31:16];
  assign relu_out = outp[15:0];

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = relu_out[7:0];  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = relu_out[15:8];
  assign uio_oe  = 8'b1111_1111;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

  always @(posedge clk) begin
    if(!rst_n)
      total <= 0;
    else
      total <= new_total;
  end

endmodule
