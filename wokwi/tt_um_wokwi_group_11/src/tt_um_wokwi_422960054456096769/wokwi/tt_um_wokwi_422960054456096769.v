/* Automatically generated from https://wokwi.com/projects/422960054456096769 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_422960054456096769(
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
  wire net2 = ui_in[0];
  wire net3 = ui_in[1];
  wire net4 = ui_in[2];
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12 = 1'b0;
  wire net13 = 1'b1;
  wire net14 = 1'b1;
  wire net15 = 1'b0;
  wire net16 = 1'b1;
  wire net17;
  wire net18;
  wire net19;
  wire net20;
  wire net21;
  wire net22;
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33;
  wire net34;
  wire net35;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40;
  wire net41;
  wire net42;
  wire net43;
  wire net44;
  wire net45;
  wire net46;
  wire net47;
  wire net48;

  assign uo_out[0] = net5;
  assign uo_out[1] = net6;
  assign uo_out[2] = net7;
  assign uo_out[3] = net8;
  assign uo_out[4] = net9;
  assign uo_out[5] = net10;
  assign uo_out[6] = net11;
  assign uo_out[7] = 0;
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

  dff_cell flop1 (
    .d (net2),
    .clk (net1),
    .q (net17),
    .notq (net18)
  );
  dff_cell flop2 (
    .d (net3),
    .clk (net1),
    .q (net19),
    .notq (net20)
  );
  dff_cell flop3 (
    .d (net4),
    .clk (net1),
    .q (net21),
    .notq (net22)
  );
  xor_cell xor1 (
    .a (net17),
    .b (net19),
    .out (net23)
  );
  xor_cell xor2 (
    .a (net17),
    .b (net21),
    .out (net24)
  );
  not_cell not1 (
    .in (net25),
    .out (net26)
  );
  or_cell or1 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  not_cell not2 (
    .in (net24),
    .out (net27)
  );
  and_cell and1 (
    .a (net17),
    .b (net19),
    .out (net28)
  );
  and_cell and2 (
    .a (net28),
    .b (net22),
    .out (net29)
  );
  or_cell or2 (
    .a (net26),
    .b (net27),
    .out (net30)
  );
  or_cell or3 (
    .a (net30),
    .b (net29),
    .out (net5)
  );
  xor_cell xor3 (
    .a (net17),
    .b (net19),
    .out (net31)
  );
  and_cell and3 (
    .a (net31),
    .b (net21),
    .out (net32)
  );
  not_cell not3 (
    .in (net32),
    .out (net6)
  );
  and_cell and4 (
    .a (net18),
    .b (net20),
    .out (net33)
  );
  xor_cell xor4 (
    .a (net17),
    .b (net19),
    .out (net34)
  );
  and_cell and5 (
    .a (net34),
    .b (net21),
    .out (net35)
  );
  or_cell or4 (
    .a (net33),
    .b (net35),
    .out (net10)
  );
  or_cell or5 (
    .a (net35),
    .b (net36),
    .out (net11)
  );
  and_cell and6 (
    .a (net22),
    .b (net19),
    .out (net37)
  );
  or_cell or6 (
    .a (net37),
    .b (net38),
    .out (net36)
  );
  and_cell and7 (
    .a (net21),
    .b (net20),
    .out (net39)
  );
  and_cell and8 (
    .a (net39),
    .b (net18),
    .out (net38)
  );
  or_cell or7 (
    .a (net40),
    .b (net41),
    .out (net9)
  );
  and_cell and9 (
    .a (net18),
    .b (net19),
    .out (net40)
  );
  and_cell and10 (
    .a (net42),
    .b (net22),
    .out (net41)
  );
  and_cell and11 (
    .a (net18),
    .b (net20),
    .out (net42)
  );
  or_cell or8 (
    .a (net35),
    .b (net43),
    .out (net8)
  );
  and_cell and12 (
    .a (net18),
    .b (net22),
    .out (net44)
  );
  or_cell or9 (
    .a (net44),
    .b (net45),
    .out (net43)
  );
  and_cell and13 (
    .a (net22),
    .b (net19),
    .out (net46)
  );
  and_cell and14 (
    .a (net46),
    .b (net17),
    .out (net45)
  );
  and_cell and15 (
    .a (net18),
    .b (net19),
    .out (net47)
  );
  and_cell and16 (
    .a (net47),
    .b (net22),
    .out (net48)
  );
  not_cell not4 (
    .in (net48),
    .out (net7)
  );
endmodule
