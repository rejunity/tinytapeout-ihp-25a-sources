/* Automatically generated from https://wokwi.com/projects/422964381148718081 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_422964381148718081(
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
  wire net16 = 1'b0;
  wire net17 = 1'b1;
  wire net18 = 1'b1;
  wire net19 = 1'b0;
  wire net20 = 1'b1;
  wire net21;
  wire net22;
  wire net23;
  wire net24;
  wire net25;
  wire net26;

  assign uo_out[0] = net11;
  assign uo_out[1] = net11;
  assign uo_out[2] = net12;
  assign uo_out[3] = net12;
  assign uo_out[4] = net13;
  assign uo_out[5] = net13;
  assign uo_out[6] = net14;
  assign uo_out[7] = net15;
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

  or_cell or1 (
    .a (net9),
    .b (net10),
    .out (net15)
  );
  or_cell or2 (
    .a (net7),
    .b (net8),
    .out ()
  );
  or_cell or3 (
    .a (net5),
    .b (net6),
    .out (net21)
  );
  or_cell or4 (
    .a (net3),
    .b (net4),
    .out (net22)
  );
  not_cell not1 (
    .in (net2),
    .out (net23)
  );
  xor_cell xor1 (
    .a (net23),
    .b (net1),
    .out (net24)
  );
  nand_cell nand1 (
    .a (net24),
    .b (net22),
    .out (net11)
  );
  and_cell and1 (
    .a (net21),
    .b (net22),
    .out (net12)
  );
  and_cell and2 (
    .a (net21),
    .b (net22),
    .out (net25)
  );
  nand_cell nand2 (
    .a (net24),
    .b (net15),
    .out (net26)
  );
  and_cell and3 (
    .a (net25),
    .b (net26),
    .out (net13)
  );
  nand_cell nand3 (
    .a (net25),
    .b (net26),
    .out (net14)
  );
endmodule
