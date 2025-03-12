/*
 * Copyright (c) 2025 Marcus Sand (Hero)
 * SPDX-License-Identifier: Apache-2.0
 *
 * Inspired by:
 * https://wokwi.com/projects/347069718502310484
 * https://wokwi.com/projects/378227921057396737
 */

`default_nettype none

module tt_um_wokwi_422960078645704705 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  //------------------------------------------------------------------------

  // Define the pins of the LCD (to use with our Verilog code)
  // RS: Register Select
  // E: Enable
  // D4: Data 4
  // D5: Data 5
  // D6: Data 6
  // D7: Data 7
  reg RS, E, D4, D5, D6, D7;

  //------------------------------------------------------------------------

  // All output pins must be assigned. If not used, assign to 0.
  // assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Map the LCD pins to the module pins
  assign uo_out[0] = RS;
  assign uo_out[1] = E;
  assign uo_out[2] = D4;
  assign uo_out[3] = D5;
  assign uo_out[4] = D6;
  assign uo_out[5] = D7;

  // Assign the remaining pins to match their inputs (doesn't matter)
  assign uo_out[6] = ui_in[6];
  assign uo_out[7] = ui_in[7];

  //------------------------------------------------------------------------

  reg [5:0] counter = 6'h0;
  reg [6:0] seq = 7'h0;
  reg [4:0] data;

  assign {RS, D7, D6, D5, D4} = data;
  
  always @(posedge clk) begin
      counter <= counter + 1'b1;
      if (counter == 6'b0) begin
          E <= 1'b1;
          seq <= seq + 1'b1;
          case(seq)
              // Switch to 4-bit mode
              0 : data <= 5'b00011;
              1 : data <= 5'b00010;

              // Display on
              2 : data <= 5'b00000;
              3 : data <= 5'b01110;

              // https://mil.ufl.edu/4744/docs/lcdmanual/characterset.html

              // Write I
              4 : data <= 5'b10100;
              5 : data <= 5'b11001;

              // Write '
              6 : data <= 5'b10010;
              7 : data <= 5'b10111;

              // Write m
              8 : data <= 5'b10110;
              9 : data <= 5'b11101;

              // Write space
              10 : data <= 5'b10010;
              11 : data <= 5'b10000;

              // Write H
              12 : data <= 5'b10100;
              13 : data <= 5'b11000;

              // Write e
              14 : data <= 5'b10110;
              15 : data <= 5'b10101;

              // Write r
              16 : data <= 5'b10111;
              17 : data <= 5'b10010;
              
              // Write o
              18 : data <= 5'b10110;
              19 : data <= 5'b11111;

              // Write space
              20 : data <= 5'b10010;
              21 : data <= 5'b10000;

              // Write /
              22 : data <= 5'b10010;
              23 : data <= 5'b11111;

              // Write space (again)
              24 : data <= 5'b10010;
              25 : data <= 5'b10000;

              // Write hi (katakana)
              26 : data <= 5'b11100;
              27 : data <= 5'b11011;

              // Write -
              28 : data <= 5'b11011;
              29 : data <= 5'b10000;

              // Write ro (katakana)
              30 : data <= 5'b11101;
              31 : data <= 5'b11011;

              // Write -
              32 : data <= 5'b11011;
              33 : data <= 5'b10000;

              // Put cursor on line 2
              34 : data <= 5'b01100;
              35 : data <= 5'b00001;

              // Write h
              36 : data <= 5'b10110;
              37 : data <= 5'b11000;

              // Write e
              38 : data <= 5'b10110;
              39 : data <= 5'b10101;

              // Write r
              40 : data <= 5'b10111;
              41 : data <= 5'b10010;
              
              // Write o
              42 : data <= 5'b10110;
              43 : data <= 5'b11111;

              // Write g
              44 : data <= 5'b10110;
              45 : data <= 5'b10111;
              
              // Write a
              46 : data <= 5'b10110;
              47 : data <= 5'b10001;
              
              // Write m
              48 : data <= 5'b10110;
              49 : data <= 5'b11101;

              // Write e
              50 : data <= 5'b10110;
              51 : data <= 5'b10101;
              
              // Write r
              52 : data <= 5'b10111;
              53 : data <= 5'b10010;

              // Write s
              54 : data <= 5'b10111;
              55 : data <= 5'b10011;

              // Write dot (.)
              56 : data <= 5'b10010;
              57 : data <= 5'b11110;

              // Write d
              58 : data <= 5'b10110;
              59 : data <= 5'b10100;

              // Write e
              60 : data <= 5'b10110;
              61 : data <= 5'b10101;

              // Write v
              62 : data <= 5'b10111;
              63 : data <= 5'b10110;

              // Dummy data
              64 : data <= 5'b10000;

              default : begin
                  // don't send any further data
                  E   <= 1'b0;
                  seq <= seq;
              end
          endcase
      end else
      begin
          E <= 1'b0;
      end
  end

  //------------------------------------------------------------------------

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
