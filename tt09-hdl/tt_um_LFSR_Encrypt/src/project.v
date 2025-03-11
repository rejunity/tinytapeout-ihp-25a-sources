/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_LFSR_Encrypt (
    input  wire [7:0] ui_in,    // Data in
    output wire [7:0] uo_out,   // LFSR output
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [7:0] lfsr_d, lfsr_q;

  always @(*) begin
    lfsr_d = {lfsr_q[6:0], (lfsr_q[0] ^ lfsr_q[5] ^ lfsr_q[6] ^ lfsr_q[7])};
  end

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      lfsr_q <= 8'b01000001;
    end else if(ena) begin
      lfsr_q <= lfsr_d;
    end
  end

assign uo_out = lfsr_q ^ ui_in;
assign uio_out = lfsr_q;

assign uio_oe  = 0;

wire _unused = &{uio_oe, uio_in};

endmodule
