/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_eeprom_reader(
  input clk,
  input spi_clk,
  input rst_n,
  input goto_address,
  input [8:0]address,
  input hold_n,
  input cipo,
  output copi,
  output chip_select_n,
  output read_ready,
  output [7:0]byte_read,
  output [8:0]address_read
);
  reg goto_addr_prev;
  reg [3:0]bit_counter;
  reg [7:0]read_buf;


  assign byte_read = read_buf;
  assign read_ready = bit_counter == 0 && comm_state == COMM_READ;
  reg [8:0]address_reading;

  assign address_read = address_reading;

  wire [15:0]adj_addr;
  assign adj_addr = {7'b0, address};
  assign copi = comm_state == COMM_INSTR ? EEPROM_READ_INSTR[bit_counter[2:0]] : adj_addr[bit_counter];
  assign chip_select_n = comm_state == COMM_RESET;

  localparam EEPROM_READ_INSTR = 8'b00000011;

  reg [2:0]comm_state;
  localparam COMM_RESET = 3'h0;
  localparam COMM_INSTR = 3'h1;
  localparam COMM_ADDR  = 3'h2;
  localparam COMM_READ  = 3'h3;

  reg spi_clk_prev;

  wire spi_clk_posedge = !spi_clk_prev && spi_clk;
  wire spi_clk_negedge = spi_clk_prev && !spi_clk;

  always @(negedge clk) begin
    if (!rst_n) begin
      comm_state <= COMM_RESET;
      goto_addr_prev <= 0;
      bit_counter <= 7;
    end else if (hold_n && spi_clk_negedge) begin
      if (!goto_addr_prev && goto_address) {comm_state, bit_counter} <= {COMM_RESET, 4'h7};
      else
        casez ({comm_state, bit_counter})
          {COMM_RESET, 4'b?}: {comm_state, bit_counter} <= {COMM_INSTR, 4'h7};
          {COMM_INSTR, 4'b0}: {comm_state, bit_counter} <= {COMM_ADDR, 4'hF};
          {COMM_ADDR, 4'b0}: {comm_state, bit_counter} <= {COMM_READ, 4'h7};
          {COMM_READ, 4'b0}: {comm_state, bit_counter} <= {COMM_READ, 4'h7};
          default: {comm_state, bit_counter}  <= {comm_state, bit_counter - 4'b1};
        endcase

      goto_addr_prev <= goto_address;
    end
  end
  always @(posedge clk) begin
    spi_clk_prev <= spi_clk;
    if (!rst_n) begin
      read_buf <= 0;
      address_reading <= address;
    end else if (hold_n && spi_clk_posedge) begin
      if (comm_state == COMM_RESET) read_buf <= 0;
      else read_buf[bit_counter[2:0]] <= cipo;

      address_reading <= (comm_state == COMM_READ && bit_counter == 7) ? address_reading + 1 : (
                         comm_state == COMM_ADDR ? address - 1 : (
                         address_reading));
    end
  end
endmodule
