/* Automatically generated from https://wokwi.com/projects/411783629732984833 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_411783629732984833(
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
  wire net2;
  wire net3;
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10 = uio_in[0];
  wire net11 = uio_in[4];
  wire net12 = 1'b0;
  wire net13 = uio_in[1];
  wire net14 = uio_in[2];
  wire net15 = uio_in[3];
  wire net16;
  wire net17 = 1'b1;
  wire net18;
  wire net19;
  wire net20;
  wire net21 = 1'b1;
  wire net22 = 1'b1;
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30;
  wire net31 = 1'b0;
  wire net32 = 1'b0;
  wire net33 = 1'b1;

  assign uo_out[0] = net2;
  assign uo_out[1] = net3;
  assign uo_out[2] = net4;
  assign uo_out[3] = net5;
  assign uo_out[4] = net6;
  assign uo_out[5] = net7;
  assign uo_out[6] = net8;
  assign uo_out[7] = net9;
  assign uio_out[0] = net11;
  assign uio_oe[0] = net12;
  assign uio_out[1] = net11;
  assign uio_oe[1] = net12;
  assign uio_out[2] = net11;
  assign uio_oe[2] = net12;
  assign uio_out[3] = net11;
  assign uio_oe[3] = net12;
  assign uio_out[4] = net16;
  assign uio_oe[4] = net17;
  assign uio_out[5] = net18;
  assign uio_oe[5] = net17;
  assign uio_out[6] = net19;
  assign uio_oe[6] = net17;
  assign uio_out[7] = net20;
  assign uio_oe[7] = net17;

  dff_cell flipflop1 (
    .d (net23),
    .clk (net1),
    .q (net9),
    .notq (net23)
  );
  dff_cell flipflop2 (
    .d (net24),
    .clk (net9),
    .q (net8),
    .notq (net24)
  );
  dff_cell flipflop3 (
    .d (net25),
    .clk (net3),
    .q (net2),
    .notq (net25)
  );
  dff_cell flipflop4 (
    .d (net26),
    .clk (net4),
    .q (net3),
    .notq (net26)
  );
  dff_cell flipflop5 (
    .d (net27),
    .clk (net5),
    .q (net4),
    .notq (net27)
  );
  dff_cell flipflop6 (
    .d (net28),
    .clk (net6),
    .q (net5),
    .notq (net28)
  );
  dff_cell flipflop7 (
    .d (net29),
    .clk (net8),
    .q (net7),
    .notq (net29)
  );
  dff_cell flipflop8 (
    .d (net30),
    .clk (net7),
    .q (net6),
    .notq (net30)
  );
  and_cell and1 (
    .a (net13),
    .b (net10),
    .out (net16)
  );
  nand_cell nand1 (
    .a (net15),
    .b (net14),
    .out (net19)
  );
  or_cell or1 (
    .a (net19),
    .b (net16),
    .out (net18)
  );
  xor_cell xor1 (
    .a (net16),
    .b (net10),
    .out (net20)
  );
endmodule
