/* Automatically generated from https://wokwi.com/projects/413387093939376129 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_413387093939376129(
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
  wire net5 = ui_in[3];
  wire net6 = ui_in[4];
  wire net7 = ui_in[5];
  wire net8 = ui_in[6];
  wire net9 = ui_in[7];
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18 = 1'b0;
  wire net19 = 1'b1;
  wire net20 = 1'b1;
  wire net21 = 1'b0;
  wire net22 = 1'b1;
  wire net23;
  wire net24 = 1'b0;
  wire net25;
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30 = 1'b0;
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

  assign uo_out[0] = net10;
  assign uo_out[1] = net11;
  assign uo_out[2] = net12;
  assign uo_out[3] = net13;
  assign uo_out[4] = net14;
  assign uo_out[5] = net15;
  assign uo_out[6] = net16;
  assign uo_out[7] = net17;
  assign uio_out[0] = net18;
  assign uio_oe[0] = net18;
  assign uio_out[1] = net18;
  assign uio_oe[1] = net18;
  assign uio_out[2] = net18;
  assign uio_oe[2] = net18;
  assign uio_out[3] = net18;
  assign uio_oe[3] = net18;
  assign uio_out[4] = net18;
  assign uio_oe[4] = net18;
  assign uio_out[5] = net18;
  assign uio_oe[5] = net18;
  assign uio_out[6] = net18;
  assign uio_oe[6] = net18;
  assign uio_out[7] = net18;
  assign uio_oe[7] = net18;

  and_cell and1 (
    .a (net3),
    .b (net2),
    .out (net23)
  );
  dff_cell flop1 (
    .d (net2),
    .clk (net1),
    .q (net16),
    .notq (net17)
  );
  and_cell and2 (
    .a (net5),
    .b (net4),
    .out (net25)
  );
  and_cell and3 (
    .a (net7),
    .b (net6),
    .out (net26)
  );
  and_cell and4 (
    .a (net9),
    .b (net8),
    .out (net27)
  );
  and_cell and5 (
    .a (net25),
    .b (net23),
    .out (net28)
  );
  and_cell and7 (
    .a (net27),
    .b (net26),
    .out (net29)
  );
  and_cell and8 (
    .a (net29),
    .b (net28),
    .out (net10)
  );
  not_cell not1 (
    .in (net10),
    .out (net11)
  );
  or_cell or1 (
    .a (net3),
    .b (net2),
    .out (net31)
  );
  or_cell or2 (
    .a (net5),
    .b (net4),
    .out (net32)
  );
  or_cell or3 (
    .a (net7),
    .b (net6),
    .out (net33)
  );
  or_cell or4 (
    .a (net9),
    .b (net8),
    .out (net34)
  );
  or_cell or5 (
    .a (net32),
    .b (net31),
    .out (net35)
  );
  or_cell or6 (
    .a (net34),
    .b (net33),
    .out (net36)
  );
  or_cell or7 (
    .a (net36),
    .b (net35),
    .out (net12)
  );
  not_cell not2 (
    .in (net12),
    .out (net13)
  );
  xor_cell xor1 (
    .a (net3),
    .b (net2),
    .out (net37)
  );
  xor_cell xor2 (
    .a (net5),
    .b (net4),
    .out (net38)
  );
  xor_cell xor3 (
    .a (net7),
    .b (net6),
    .out (net39)
  );
  xor_cell xor4 (
    .a (net9),
    .b (net8),
    .out (net40)
  );
  xor_cell xor5 (
    .a (net38),
    .b (net37),
    .out (net41)
  );
  xor_cell xor7 (
    .a (net40),
    .b (net39),
    .out (net42)
  );
  xor_cell xor6 (
    .a (net42),
    .b (net41),
    .out (net14)
  );
  mux_cell mux1 (
    .a (net3),
    .b (net4),
    .sel (net2),
    .out (net15)
  );
endmodule
