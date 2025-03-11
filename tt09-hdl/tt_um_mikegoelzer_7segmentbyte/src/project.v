/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mikegoelzer_7segmentbyte (
    input  wire [7:0] ui_in,    // byte to display
    output wire [7:0] uo_out,   // [0] = 7-segment a, [1] = 7-segment b, etc.
                                // [7] = cathode control (0=right, 1=left)
    input  wire [7:0] uio_in,   // [0] = write enable, rest unused
    output wire [7:0] uio_out,  // (not used)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;  // not used
  assign uio_oe  = 0;  // only uio[0] is used (as a WE input, active high)

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

  seven_seg seven_seg(
    .clk     (clk      ),
    .rst_n   (rst_n    ),
    .disp_off(1'b0     ),
    .valid   (uio_in[0]),
    .val     (ui_in    ),
    .aa      (uo_out[0]),
    .ab      (uo_out[1]),
    .ac      (uo_out[2]),
    .ad      (uo_out[3]),
    .ae      (uo_out[4]),
    .af      (uo_out[5]),
    .ag      (uo_out[6]),
    .cathode (uo_out[7])
  );

endmodule
