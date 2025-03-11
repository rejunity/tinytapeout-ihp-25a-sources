/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_servo(
  input clk,
  input servo_clk,
  input rst_n,
  input [4:0] servo_set_val,
  input [4:0] servo_reset_val,
  input [7:0] servo_freq_val,
  input servo_enabled,
  input servo_value,
  output servo_output
);
  reg [7:0] servo_counter;
  reg servo_output_r;
  reg servo_clk_prev;

  assign servo_output = servo_output_r;
  wire servo_clk_posedge = (!servo_clk_prev && servo_clk);

  always @(posedge clk) begin
    servo_clk_prev <= servo_clk;
    if (!rst_n || !servo_enabled) begin
      servo_output_r <= 1'b1;
      servo_counter <= 0;
    end else begin
      if (servo_clk_posedge) begin
        if ((servo_value == 1'b1) && (servo_counter == {3'b0, servo_set_val})) begin
          servo_counter <= servo_counter + 1;
          servo_output_r <= 0;
        end else if ((servo_value == 1'b0) && (servo_counter == {3'b0, servo_reset_val})) begin
          servo_counter <= servo_counter + 1;
          servo_output_r <= 0;
        end else if (servo_counter == servo_freq_val) begin
          servo_counter <= 8'b0;
          servo_output_r <= 1;
        end else begin
          servo_counter <= servo_counter + 1;
          servo_output_r <= servo_output_r;
        end
      end else begin
          servo_counter <= servo_counter;
          servo_output_r <= servo_output_r;
      end
    end
  end
endmodule
