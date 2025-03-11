/* Automatically generated from https://wokwi.com/projects/422957918936350721 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_422957918936350721(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,    // Dedicated outputs
  input  wire [7:0] uio_in,    // IOs: Input path
  output wire [7:0] uio_out,    // IOs: Output path
  output wire [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
  input ena,
  input clk,
  input rst_n
);
  wire net1 = ui_in[0];
  wire net2 = ui_in[1];
  wire net3 = ui_in[2];
  wire net4 = ui_in[3];
  wire net5 = ui_in[4];
  wire net6 = ui_in[5];
  wire net7 = ui_in[6];
  wire net8 = ui_in[7];
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14 = 1'b1;
  wire net15;
  wire net16;
  wire net17 = 1'b0;
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
  wire net39 = 1'b0;

  assign uo_out[0] = net9;
  assign uo_out[1] = net10;
  assign uo_out[2] = net11;
  assign uo_out[3] = net12;
  assign uo_out[4] = net13;
  assign uo_out[5] = 0;
  assign uo_out[6] = 0;
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

  xor_cell xor1 (
    .a (net1),
    .b (net5),
    .out (net15)
  );
  and_cell and2 (
    .a (net1),
    .b (net5),
    .out (net16)
  );
  and_cell and1 (
    .a (net17),
    .b (net17),
    .out (net18)
  );
  and_cell and3 (
    .a (net17),
    .b (net17),
    .out (net19)
  );
  xor_cell xor2 (
    .a (net17),
    .b (net15),
    .out (net9)
  );
  or_cell or1 (
    .a (net16),
    .b (net18),
    .out (net20)
  );
  or_cell or2 (
    .a (net20),
    .b (net19),
    .out (net21)
  );
  xor_cell xor3 (
    .a (net2),
    .b (net6),
    .out (net22)
  );
  and_cell and4 (
    .a (net2),
    .b (net6),
    .out (net23)
  );
  and_cell and5 (
    .a (net2),
    .b (net21),
    .out (net24)
  );
  and_cell and6 (
    .a (net6),
    .b (net21),
    .out (net25)
  );
  xor_cell xor4 (
    .a (net21),
    .b (net22),
    .out (net10)
  );
  or_cell or3 (
    .a (net23),
    .b (net24),
    .out (net26)
  );
  or_cell or4 (
    .a (net26),
    .b (net25),
    .out (net27)
  );
  xor_cell xor5 (
    .a (net3),
    .b (net7),
    .out (net28)
  );
  and_cell and7 (
    .a (net4),
    .b (net7),
    .out (net29)
  );
  and_cell and8 (
    .a (net3),
    .b (net27),
    .out (net30)
  );
  and_cell and9 (
    .a (net7),
    .b (net27),
    .out (net31)
  );
  xor_cell xor6 (
    .a (net27),
    .b (net28),
    .out (net11)
  );
  or_cell or5 (
    .a (net29),
    .b (net30),
    .out (net32)
  );
  or_cell or6 (
    .a (net32),
    .b (net31),
    .out (net33)
  );
  xor_cell xor7 (
    .a (net4),
    .b (net8),
    .out (net34)
  );
  and_cell and10 (
    .a (net4),
    .b (net8),
    .out (net35)
  );
  and_cell and11 (
    .a (net4),
    .b (net33),
    .out (net36)
  );
  and_cell and12 (
    .a (net8),
    .b (net33),
    .out (net37)
  );
  xor_cell xor8 (
    .a (net33),
    .b (net34),
    .out (net12)
  );
  or_cell or7 (
    .a (net35),
    .b (net36),
    .out (net38)
  );
  or_cell or8 (
    .a (net38),
    .b (net37),
    .out (net13)
  );
endmodule
