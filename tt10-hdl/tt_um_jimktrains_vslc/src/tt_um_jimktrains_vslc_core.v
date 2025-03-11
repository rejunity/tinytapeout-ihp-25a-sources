/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_core (
  input  wire [7:0] ui_in,
  output wire [7:0] uo_out,
  input  wire [7:0] uio_in,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe,
  input  wire       ena,
  input  wire       clk,
  input  wire       rst_n
);
  wire instr_ready;

  wire [7:0] eeprom_read_buf;
  wire [8:0] eeprom_addr_read;
  wire eeprom_read_ready;

  reg eeprom_restart_read;

  wire eeprom_cs_n;

  reg rst_n_sync_reg;
  wire rst_n_sync;
  assign rst_n_sync = rst_n_sync_reg;

  reg eeprom_hold_n;
  wire eeprom_hold_n_w;
  assign eeprom_hold_n_w = eeprom_hold_n;

  reg [3:0] spi_clk_div;
  reg [15:0] counter;

  // This isn't being used in any sensetivities. It acts as a strobe.
  wire spi_clk;
  assign spi_clk = spi_clk_div == 0 ? clk : counter[spi_clk_div-1];

  tt_um_jimktrains_vslc_eeprom_reader eereader(
    clk,
    spi_clk,
    rst_n_sync,
    eeprom_restart_read,
    eeprom_start_addr,
    eeprom_hold_n_w,
    cipo,
    copi,
    eeprom_cs_n,
    eeprom_read_ready,
    eeprom_read_buf,
    eeprom_addr_read
  );

  wire timer_enabled;
  wire timer_output;
  wire servo_output;

  tt_um_jimktrains_vslc_executor exec(
    clk,
    counter,
    instr_ready,
    rst_n_sync,
    eeprom_read_buf,
    ui_in_reg_w,
    ui_in_prev_reg_w,
    uo_out,
    timer_enabled,
    timer_output,
    servo_output
  );

  wire _unused = ena;

  // uio_out
  localparam EEPROM_CS  = 3'h0;
  localparam SPI_COPI   = 3'h1;
  localparam SPI_CIPO   = 3'h2;
  localparam SPI_CLK    = 3'h3;
  localparam TIMER_OUT  = 3'h4;
  localparam TIMER_CMPL = 3'h5;
  localparam SERVO_OUT  = 3'h6;
  localparam UIO_7      = 3'h7;

  wire copi;
  wire cipo;

  assign uio_oe[EEPROM_CS] = 1;
  assign uio_oe[SPI_COPI]  = 1;
  assign uio_oe[SPI_CIPO]  = 0;
  assign uio_oe[SPI_CLK]  = 1;

  assign uio_oe[TIMER_OUT] = 1;
  assign uio_oe[TIMER_CMPL] = 1;
  assign uio_oe[SERVO_OUT] = 1;
  assign uio_oe[UIO_7] = 0;

  assign uio_out[EEPROM_CS]  = eeprom_cs_n;
  assign uio_out[SPI_CIPO]   = 0;
  assign cipo = uio_in[SPI_CIPO];
  assign uio_out[SPI_COPI]   = copi;
  assign uio_out[SPI_CLK]    = spi_clk;
  assign uio_out[TIMER_OUT]  = timer_enabled && timer_output && timer_dead_time;
  assign uio_out[TIMER_CMPL] = timer_enabled && !timer_output && timer_dead_time;
  assign uio_out[SERVO_OUT]  = servo_output;
  assign uio_out[UIO_7]      = 0;

  reg timer_output_prev;
  wire timer_dead_time = timer_output_prev == timer_output;



  reg [7:0]ui_in_reg;
  reg [7:0]ui_in_prev_reg;

  wire [7:0]ui_in_reg_w;
  wire [7:0]ui_in_prev_reg_w;

  assign ui_in_reg_w = ui_in_reg;
  assign ui_in_prev_reg_w = ui_in_prev_reg;

  reg [4:0]start_addr;
  wire [8:0] eeprom_start_addr = {4'b0, start_addr};
  reg [8:0]end_addr;

  wire auto_scan_cycle;
  assign auto_scan_cycle = eeprom_restart_read;

  reg scan_cycle_clk;
  reg scan_cycle_clk_prev;

  assign instr_ready = eeprom_read_ready && (eeprom_addr_read > 3);

  always @(posedge clk) begin
    if (!rst_n_sync) begin
      counter <= 0;
      ui_in_reg <= ui_in;
      ui_in_prev_reg <= ui_in;
      scan_cycle_clk_prev <= 0;
      spi_clk_div <= 3;
      scan_cycle_clk <= 0;
    end else begin
      counter <= counter + 1;
      scan_cycle_clk <= auto_scan_cycle;
      scan_cycle_clk_prev <= scan_cycle_clk;
      if (scan_cycle_clk && !scan_cycle_clk_prev) begin
        ui_in_reg <= ui_in;
        ui_in_prev_reg <= ui_in_reg;
      end
    end
  end

  always @(negedge clk) begin
    rst_n_sync_reg <= rst_n;
    timer_output_prev <= timer_output;
    if (!rst_n_sync) begin
      start_addr <= 0;
      end_addr <= 0;
      eeprom_restart_read <= 0;
      eeprom_hold_n <= 1;
    end else begin
      if (eeprom_read_ready) begin
        //start_addr[8] <= (eeprom_addr_read == 0) ? eeprom_read_buf[0] : start_addr[8];
        start_addr[4:0] <= (eeprom_addr_read == 1) ? eeprom_read_buf[4:0] : start_addr;
        end_addr[8] <= (eeprom_addr_read == 2) ? eeprom_read_buf[0] : end_addr[8];
        end_addr[7:0] <= (eeprom_addr_read == 3) ? eeprom_read_buf : end_addr[7:0];

        eeprom_restart_read <= end_addr != 9'b0 && eeprom_addr_read == end_addr;
      end else begin
        eeprom_restart_read <= eeprom_restart_read;
      end

    end
  end
endmodule
