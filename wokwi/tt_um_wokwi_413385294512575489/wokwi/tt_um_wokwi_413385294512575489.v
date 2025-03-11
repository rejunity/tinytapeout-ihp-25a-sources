/* Automatically generated from https://wokwi.com/projects/413385294512575489 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_413385294512575489(
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
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13 = uio_in[0];
  wire net14 = 1'b0;
  wire net15 = uio_in[1];
  wire net16;
  wire net17 = 1'b1;
  wire net18 = 1'b0;
  wire net19 = 1'b1;
  wire net20 = 1'b1;
  wire net21 = 1'b0;
  wire net22 = 1'b1;
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28;

  assign uo_out[0] = net5;
  assign uo_out[1] = net6;
  assign uo_out[2] = net7;
  assign uo_out[3] = net8;
  assign uo_out[4] = net9;
  assign uo_out[5] = net10;
  assign uo_out[6] = net11;
  assign uo_out[7] = net12;
  assign uio_out[0] = net14;
  assign uio_oe[0] = net14;
  assign uio_out[1] = net14;
  assign uio_oe[1] = net14;
  assign uio_out[2] = net16;
  assign uio_oe[2] = net17;
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
    .in (net23),
    .out (net5)
  );
  not_cell not2 (
    .in (net5),
    .out (net6)
  );
  not_cell not3 (
    .in (net6),
    .out (net7)
  );
  not_cell not4 (
    .in (net7),
    .out (net8)
  );
  not_cell not5 (
    .in (net8),
    .out (net24)
  );
  not_cell not6 (
    .in (net24),
    .out (net9)
  );
  not_cell not7 (
    .in (net9),
    .out (net25)
  );
  not_cell not8 (
    .in (net25),
    .out (net10)
  );
  not_cell not9 (
    .in (net10),
    .out (net26)
  );
  not_cell not10 (
    .in (net26),
    .out (net11)
  );
  not_cell not12 (
    .in (net11),
    .out (net27)
  );
  not_cell not13 (
    .in (net27),
    .out (net12)
  );
  and_cell and1 (
    .a (net1),
    .b (net2),
    .out (net28)
  );
  mux_cell mux1 (
    .a (net28),
    .b (net3),
    .sel (net4),
    .out (net23)
  );
  xor_cell xor1 (
    .a (net13),
    .b (net15),
    .out (net16)
  );
endmodule
