/*
 * Copyright (c) 2024 Caio Alonso da Costa
 * SPI Design copied from https://github.com/calonso88/tt07_alu_74181
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_brukstus_tdc_with_spi (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
  );

  // SPI Auxiliars
  wire spi_cs_n;
  wire spi_clk;
  wire spi_miso;
  wire spi_mosi;
  wire cpol;
  wire cpha;

  // Sync'ed
  wire spi_cs_n_sync;
  wire spi_clk_sync;
  wire spi_mosi_sync;
  wire cpol_sync;
  wire cpha_sync;

  wire [2:0] dummy_signal;

  // Bi direction IOs [6:4] as inputs
  assign uio_oe[6:4] = 3'b000;
  // Bi direction IOs [7] and [3:0] as outputs
  assign uio_oe[7]   = 1'b1;
  assign uio_oe[3:0] = 4'b1111;
  assign uo_out[7:1] = 7'b0;

  // Input ports
  assign cpol      = ui_in[0];
  assign cpha      = ui_in[1];
  assign spi_cs_n  = uio_in[4];
  assign spi_clk   = uio_in[5];
  assign spi_mosi  = uio_in[6];

  // MISO Output port
  assign uio_out[3] = spi_miso;
  // Unused ouputs needs to be assigned to 0.
  assign uio_out[2:0] = 3'b000;
  assign uio_out[7:4] = 4'b0000;

  // Unused inputs.
  assign dummy_signal = ui_in[7:5];

  // Number of stages in each synchronizer
  localparam int SYNC_STAGES = 2;
  localparam int SYNC_WIDTH = 1;

  // Synchronizers
  synchronizer #(.STAGES(SYNC_STAGES), .WIDTH(SYNC_WIDTH)) synchronizer_spi_cs_n_inst (.rstb(rst_n), .clk(clk), .ena(ena), .data_in(spi_cs_n), .data_out(spi_cs_n_sync));
  synchronizer #(.STAGES(SYNC_STAGES), .WIDTH(SYNC_WIDTH)) synchronizer_spi_clk_inst  (.rstb(rst_n), .clk(clk), .ena(ena), .data_in(spi_clk),  .data_out(spi_clk_sync));
  synchronizer #(.STAGES(SYNC_STAGES), .WIDTH(SYNC_WIDTH)) synchronizer_spi_mosi_inst (.rstb(rst_n), .clk(clk), .ena(ena), .data_in(spi_mosi), .data_out(spi_mosi_sync));
  synchronizer #(.STAGES(SYNC_STAGES), .WIDTH(SYNC_WIDTH)) synchronizer_spi_mode_cpol (.rstb(rst_n), .clk(clk), .ena(ena), .data_in(cpol), .data_out(cpol_sync));
  synchronizer #(.STAGES(SYNC_STAGES), .WIDTH(SYNC_WIDTH)) synchronizer_spi_mode_cpha (.rstb(rst_n), .clk(clk), .ena(ena), .data_in(cpha), .data_out(cpha_sync));

  // Amount of CFG Regs and Status Regs + Regs Width
  localparam int NUM_CFG = 8;
  localparam int NUM_STATUS = NUM_CFG;
  localparam int REG_WIDTH = 8;

  // Config Regs and Status Regs
  wire [NUM_CFG*REG_WIDTH-1:0] config_regs;
  wire [NUM_STATUS*REG_WIDTH-1:0] status_regs;

  wire [31:0] coarse_result;
  wire [8:0] fine_result;

  // Status registers.
  // assign status_regs[31:0]   = 32'h78B36425;         // [0]
  // assign status_regs[63:32]  = 32'hDEADBEEF;         // [1]
  // assign status_regs[95:64]  = coarse_result;        // [2]
  // assign status_regs[127:96] = {23'b0, fine_result}; // [3]

  assign status_regs[31:0]  = coarse_result;        // [0][1][2][3]
  assign status_regs[40:32] = fine_result; // [4][5]
  assign status_regs[63:41] = 23'b0; // [5][6][7]


  // SPI wrapper.
  spi_wrapper #(.NUM_CFG(NUM_CFG), .NUM_STATUS(NUM_STATUS), .REG_WIDTH(REG_WIDTH)) spi_wrapper_i (.rstb(rst_n), .clk(clk), .ena(ena), .mode({cpol_sync, cpha_sync}), .spi_cs_n(spi_cs_n_sync), .spi_clk(spi_clk_sync), .spi_mosi(spi_mosi_sync), .spi_miso(spi_miso), .config_regs(config_regs), .status_regs(status_regs));

  // TDC part.
  tdc tdc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .sampling_clk(ui_in[2]),
        .start_signal(ui_in[3]),
        .stop_signal(ui_in[4]),
        .busy(uo_out[0]),
        .coarse_result(coarse_result),
        .fine_result(fine_result)
      );

endmodule
