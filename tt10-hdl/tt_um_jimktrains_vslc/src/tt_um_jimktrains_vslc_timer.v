/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_timer(
  input clk,
  input timer_clk,
  input rst_n,
  input [7:0] timer_period_a,
  input [7:0] timer_period_b,
  input timer_enabled,
  output timer_output
);
  reg [15:0] timer_counter;
  reg timer_phase;
  reg timer_output_r;
  reg timer_clk_prev;

  assign timer_output = timer_output_r;
  wire timer_clk_posedge = (!timer_clk_prev && timer_clk);

  always @(posedge clk) begin
    timer_clk_prev <= timer_clk;
    if (!rst_n || !timer_enabled) begin
      timer_phase <= 1'b0;
      timer_output_r <= 1'b0;
      timer_counter <= 0;
    end else begin
      if (timer_clk_posedge) begin
        if (timer_phase == 1'b0 && timer_counter == {8'b0, timer_period_a}) begin
          timer_counter <= 16'b0;
          timer_phase <= 1'b1;
          timer_output_r <= ~timer_output_r;
        end else if (timer_phase == 1'b1 && timer_counter == {8'b0, timer_period_b}) begin
          timer_counter <= 16'b0;
          timer_phase <= 1'b0;
          timer_output_r <= timer_period_b == 0 ? timer_output : ~timer_output;
        end else begin
          timer_counter <= timer_counter + 1;
        end
      end
    end
  end
endmodule
