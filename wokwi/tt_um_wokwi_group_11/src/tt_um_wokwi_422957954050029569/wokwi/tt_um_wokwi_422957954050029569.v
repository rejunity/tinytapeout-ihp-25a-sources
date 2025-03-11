/* Automatically generated from https://wokwi.com/projects/422957954050029569 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_422957954050029569(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,    // Dedicated outputs
  input  wire [7:0] uio_in,    // IOs: Input path
  output wire [7:0] uio_out,    // IOs: Output path
  output wire [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
  input ena,
  input clk,
  input rst_n
);
  wire net1;
  wire net2;
  wire net3;
  wire net4;
  wire net5;
  wire net6 = ui_in[0];
  wire net7 = ui_in[1];
  wire net8 = ui_in[2];
  wire net9 = ui_in[3];
  wire net10 = ui_in[4];
  wire net11 = ui_in[5];
  wire net12 = ui_in[6];
  wire net13 = ui_in[7];
  wire net14 = 1'b1;
  wire net15 = 1'b0;
  wire net16;
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
  wire net39 = 1'b0;

  assign uo_out[0] = net1;
  assign uo_out[1] = net2;
  assign uo_out[2] = net3;
  assign uo_out[3] = net4;
  assign uo_out[4] = net5;
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

  and_cell and1 (
    .a (net15),
    .b (net7),
    .out (net16)
  );
  and_cell and2 (
    .a (net7),
    .b (net6),
    .out (net17)
  );
  and_cell and3 (
    .a (net15),
    .b (net6),
    .out (net18)
  );
  or_cell or1 (
    .a (net18),
    .b (net16),
    .out (net19)
  );
  or_cell or2 (
    .a (net19),
    .b (net17),
    .out (net20)
  );
  xor_cell xor1 (
    .a (net15),
    .b (net6),
    .out (net21)
  );
  xor_cell xor2 (
    .a (net21),
    .b (net7),
    .out (net1)
  );
  and_cell and4 (
    .a (net20),
    .b (net9),
    .out (net22)
  );
  and_cell and5 (
    .a (net9),
    .b (net8),
    .out (net23)
  );
  and_cell and6 (
    .a (net20),
    .b (net8),
    .out (net24)
  );
  or_cell or3 (
    .a (net24),
    .b (net22),
    .out (net25)
  );
  or_cell or4 (
    .a (net25),
    .b (net23),
    .out (net26)
  );
  xor_cell xor3 (
    .a (net20),
    .b (net8),
    .out (net27)
  );
  xor_cell xor4 (
    .a (net27),
    .b (net9),
    .out (net2)
  );
  and_cell and7 (
    .a (net26),
    .b (net11),
    .out (net28)
  );
  and_cell and8 (
    .a (net11),
    .b (net10),
    .out (net29)
  );
  and_cell and9 (
    .a (net26),
    .b (net10),
    .out (net30)
  );
  or_cell or5 (
    .a (net30),
    .b (net28),
    .out (net31)
  );
  or_cell or6 (
    .a (net31),
    .b (net29),
    .out (net32)
  );
  xor_cell xor5 (
    .a (net26),
    .b (net10),
    .out (net33)
  );
  xor_cell xor6 (
    .a (net33),
    .b (net11),
    .out (net3)
  );
  and_cell and10 (
    .a (net32),
    .b (net13),
    .out (net34)
  );
  and_cell and11 (
    .a (net13),
    .b (net12),
    .out (net35)
  );
  and_cell and12 (
    .a (net32),
    .b (net12),
    .out (net36)
  );
  or_cell or7 (
    .a (net36),
    .b (net34),
    .out (net37)
  );
  or_cell or8 (
    .a (net37),
    .b (net35),
    .out (net5)
  );
  xor_cell xor7 (
    .a (net32),
    .b (net12),
    .out (net38)
  );
  xor_cell xor8 (
    .a (net38),
    .b (net13),
    .out (net4)
  );
endmodule
