/* Automatically generated from https://wokwi.com/projects/413387014781302785 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_413387014781302785(
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
  wire net10 = 1'b0;
  wire net11;
  wire net12 = 1'b0;
  wire net13 = 1'b0;
  wire net14 = 1'b0;
  wire net15 = 1'b1;
  wire net16 = 1'b1;
  wire net17 = 1'b0;
  wire net18 = 1'b1;
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

  assign uo_out[0] = net10;
  assign uo_out[1] = net10;
  assign uo_out[2] = net10;
  assign uo_out[3] = net11;
  assign uo_out[4] = net11;
  assign uo_out[5] = net11;
  assign uo_out[6] = net10;
  assign uo_out[7] = net10;
  assign uio_out[0] = 0;
  assign uio_oe[0] = net12;
  assign uio_out[1] = 0;
  assign uio_oe[1] = net12;
  assign uio_out[2] = 0;
  assign uio_oe[2] = net12;
  assign uio_out[3] = 0;
  assign uio_oe[3] = net12;
  assign uio_out[4] = 0;
  assign uio_oe[4] = net13;
  assign uio_out[5] = 0;
  assign uio_oe[5] = net13;
  assign uio_out[6] = 0;
  assign uio_oe[6] = net13;
  assign uio_out[7] = 0;
  assign uio_oe[7] = net13;

  and_cell and1 (
    .a (net8),
    .b (net9),
    .out (net19)
  );
  not_cell not1 (
    .in (net5),
    .out (net20)
  );
  and_cell and2 (
    .a (net20),
    .b (net6),
    .out (net21)
  );
  and_cell and3 (
    .a (net21),
    .b (net7),
    .out (net22)
  );
  not_cell not2 (
    .in (net2),
    .out (net23)
  );
  not_cell not3 (
    .in (net3),
    .out (net24)
  );
  and_cell and4 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  and_cell and5 (
    .a (net25),
    .b (net4),
    .out (net26)
  );
  and_cell and6 (
    .a (net26),
    .b (net22),
    .out (net27)
  );
  and_cell and7 (
    .a (net27),
    .b (net19),
    .out (net28)
  );
  and_cell and8 (
    .a (net1),
    .b (net28),
    .out (net11)
  );
endmodule
