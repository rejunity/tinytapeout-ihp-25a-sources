/* Automatically generated from https://wokwi.com/projects/414120201832165377 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_414120201832165377(
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
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14 = 1'b0;
  wire net15 = 1'b1;
  wire net16 = 1'b0;
  wire net17;
  wire net18;
  wire net19;
  wire net20;

  assign uo_out[0] = net9;
  assign uo_out[1] = 0;
  assign uo_out[2] = 0;
  assign uo_out[3] = 0;
  assign uo_out[4] = 0;
  assign uo_out[5] = 0;
  assign uo_out[6] = 0;
  assign uo_out[7] = net10;
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
    .out ()
  );
  or_cell or2 (
    .a (net17),
    .b (net18),
    .out (net10)
  );
  or_cell or3 (
    .out ()
  );
  or_cell or4 (
    .a (net5),
    .b (net7),
    .out (net19)
  );
  or_cell or5 (
    .a (net1),
    .b (net3),
    .out (net20)
  );
  or_cell or6 (
    .a (net20),
    .b (net19),
    .out (net9)
  );
  or_cell or7 (
    .a (net6),
    .b (net8),
    .out (net18)
  );
  or_cell or8 (
    .a (net2),
    .b (net4),
    .out (net17)
  );
endmodule
