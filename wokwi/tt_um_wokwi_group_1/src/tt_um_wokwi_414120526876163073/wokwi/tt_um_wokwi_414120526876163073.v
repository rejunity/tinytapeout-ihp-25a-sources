/* Automatically generated from https://wokwi.com/projects/414120526876163073 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_414120526876163073(
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
  wire net4 = ui_in[1];
  wire net5 = ui_in[2];
  wire net6 = ui_in[3];
  wire net7 = ui_in[4];
  wire net8 = ui_in[5];
  wire net9 = ui_in[6];
  wire net10 = ui_in[7];
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18;
  wire net19 = 1'b1;
  wire net20 = 1'b1;
  wire net21 = 1'b0;
  wire net22 = 1'b1;
  wire net23 = 1'b0;
  wire net24 = 1'b0;
  wire net25 = 1'b0;
  wire net26 = 1'b0;
  wire net27 = 1'b0;
  wire net28 = 1'b0;
  wire net29 = 1'b0;
  wire net30 = 1'b0;
  wire net31 = 1'b0;
  wire net32 = 1'b1;
  wire net33;

  assign uo_out[0] = net11;
  assign uo_out[1] = net12;
  assign uo_out[2] = net13;
  assign uo_out[3] = net14;
  assign uo_out[4] = net15;
  assign uo_out[5] = net16;
  assign uo_out[6] = net17;
  assign uo_out[7] = net18;
  assign uio_out[0] = 0;
  assign uio_oe[0] = 0;
  assign uio_out[1] = 0;
  assign uio_oe[1] = 0;
  assign uio_out[2] = 0;
  assign uio_oe[2] = 0;
  assign uio_out[3] = 0;
  assign uio_oe[3] = 0;
  assign uio_out[4] = 0;
  assign uio_oe[4] = 0;
  assign uio_out[5] = 0;
  assign uio_oe[5] = 0;
  assign uio_out[6] = 0;
  assign uio_oe[6] = 0;
  assign uio_out[7] = 0;
  assign uio_oe[7] = 0;

  not_cell not1 (
    .in (net2),
    .out (net33)
  );
endmodule
