/* Automatically generated from https://wokwi.com/projects/408237988946759681 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_408237988946759681(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,    // Dedicated outputs
  input  wire [7:0] uio_in,    // IOs: Input path
  output wire [7:0] uio_out,    // IOs: Output path
  output wire [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
  input ena,
  input clk,
  input rst_n
);
  wire net1 = clk;
  wire net2 = rst_n;
  wire net3 = ui_in[0];
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12 = 1'b1;
  wire net13;
  wire net14 = 1'b1;
  wire net15;
  wire net16 = 1'b1;
  wire net17;
  wire net18 = 1'b1;
  wire net19 = 1'b1;
  wire net20 = 1'b0;
  wire net21 = 1'b0;
  wire net22 = 1'b1;
  wire net23 = 1'b0;
  wire net24 = 1'b1;
  wire net25 = 1'b0;
  wire net26 = 1'b0;
  wire net27 = 1'b0;

  assign uo_out[0] = net4;
  assign uo_out[1] = net5;
  assign uo_out[2] = net6;
  assign uo_out[3] = net7;
  assign uo_out[4] = net8;
  assign uo_out[5] = net9;
  assign uo_out[6] = net10;
  assign uo_out[7] = 0;
  assign uio_out[0] = net11;
  assign uio_oe[0] = net12;
  assign uio_out[1] = 0;
  assign uio_oe[1] = 0;
  assign uio_out[2] = 0;
  assign uio_oe[2] = 0;
  assign uio_out[3] = 0;
  assign uio_oe[3] = 0;
  assign uio_out[4] = net13;
  assign uio_oe[4] = net14;
  assign uio_out[5] = net15;
  assign uio_oe[5] = net16;
  assign uio_out[6] = net17;
  assign uio_oe[6] = net18;
  assign uio_out[7] = 0;
  assign uio_oe[7] = 0;

endmodule
