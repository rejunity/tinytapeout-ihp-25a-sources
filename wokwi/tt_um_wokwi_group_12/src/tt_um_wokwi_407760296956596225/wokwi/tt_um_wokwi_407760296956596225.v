/* Automatically generated from https://wokwi.com/projects/407760296956596225 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_407760296956596225(
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
  wire net14;
  wire net15;
  wire net16;
  wire net17 = 1'b0;
  wire net18 = 1'b1;
  wire net19 = 1'b1;
  wire net20 = 1'b0;
  wire net21 = 1'b1;
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
  wire net49;
  wire net50;
  wire net51;
  wire net52;
  wire net53;
  wire net54;
  wire net55;
  wire net56;
  wire net57;
  wire net58;
  wire net59;
  wire net60;
  wire net61;
  wire net62;
  wire net63 = 1'b0;
  wire net64;
  wire net65;
  wire net66;
  wire net67;
  wire net68;
  wire net69;
  wire net70;
  wire net71;
  wire net72;
  wire net73;
  wire net74;
  wire net75;
  wire net76;
  wire net77;
  wire net78;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86;
  wire net87;
  wire net88;
  wire net89;
  wire net90;
  wire net91;
  wire net92;
  wire net93;
  wire net94;
  wire net95;
  wire net96;
  wire net97;
  wire net98;
  wire net99;
  wire net100;
  wire net101;
  wire net102;
  wire net103;
  wire net104;
  wire net105;
  wire net106;
  wire net107;
  wire net108;
  wire net109;
  wire net110;
  wire net111;
  wire net112;
  wire net113;
  wire net114;

  assign uo_out[0] = net9;
  assign uo_out[1] = net10;
  assign uo_out[2] = net11;
  assign uo_out[3] = net12;
  assign uo_out[4] = net13;
  assign uo_out[5] = net14;
  assign uo_out[6] = net15;
  assign uo_out[7] = net16;
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
    .a (net22),
    .b (net2),
    .out (net23)
  );
  or_cell nand1 (
    .a (net2),
    .b (net1),
    .out (net24)
  );
  or_cell or1 (
    .a (net3),
    .b (net6),
    .out (net25)
  );
  xor_cell xor1 (
    .a (net3),
    .b (net6),
    .out (net26)
  );
  not_cell not1 (
    .in (net1),
    .out (net22)
  );
  or_cell or2 (
    .a (net4),
    .b (net7),
    .out (net27)
  );
  or_cell or3 (
    .a (net5),
    .b (net8),
    .out (net28)
  );
  or_cell or4 (
    .a (net29),
    .b (net30),
    .out (net31)
  );
  or_cell or5 (
    .a (net32),
    .b (net33),
    .out (net34)
  );
  or_cell or6 (
    .a (net31),
    .b (net34),
    .out (net35)
  );
  or_cell or7 (
    .a (net36),
    .b (net37),
    .out (net38)
  );
  or_cell or8 (
    .a (net39),
    .b (net40),
    .out (net41)
  );
  or_cell or9 (
    .a (net38),
    .b (net41),
    .out (net42)
  );
  or_cell or10 (
    .a (net43),
    .b (net44),
    .out (net45)
  );
  or_cell or11 (
    .a (net46),
    .b (net47),
    .out (net48)
  );
  or_cell or12 (
    .a (net45),
    .b (net48),
    .out (net49)
  );
  and_cell and2 (
    .a (net1),
    .b (net50),
    .out (net51)
  );
  not_cell not2 (
    .in (net2),
    .out (net50)
  );
  and_cell and3 (
    .a (net1),
    .b (net2),
    .out (net52)
  );
  and_cell and7 (
    .a (net51),
    .b (net53),
    .out (net30)
  );
  and_cell and8 (
    .a (net23),
    .b (net25),
    .out (net29)
  );
  and_cell and9 (
    .a (net54),
    .b (net55),
    .out (net33)
  );
  and_cell and10 (
    .a (net52),
    .b (net26),
    .out (net32)
  );
  and_cell and11 (
    .a (net51),
    .b (net56),
    .out (net37)
  );
  and_cell and12 (
    .a (net27),
    .b (net23),
    .out (net36)
  );
  and_cell and13 (
    .a (net54),
    .b (net57),
    .out (net40)
  );
  and_cell and14 (
    .a (net52),
    .b (net58),
    .out (net39)
  );
  and_cell and15 (
    .a (net51),
    .b (net59),
    .out (net44)
  );
  and_cell and16 (
    .a (net28),
    .b (net23),
    .out (net43)
  );
  and_cell and17 (
    .a (net54),
    .b (net60),
    .out (net47)
  );
  and_cell and18 (
    .a (net52),
    .b (net61),
    .out (net46)
  );
  and_cell and4 (
    .a (net3),
    .b (net6),
    .out (net53)
  );
  and_cell and5 (
    .a (net4),
    .b (net7),
    .out (net56)
  );
  and_cell and6 (
    .a (net5),
    .b (net8),
    .out (net59)
  );
  xor_cell xor2 (
    .a (net4),
    .b (net7),
    .out (net58)
  );
  xor_cell xor3 (
    .a (net5),
    .b (net8),
    .out (net61)
  );
  xor_cell xor4 (
    .a (net62),
    .b (net63),
    .out (net60)
  );
  xor_cell xor5 (
    .a (net5),
    .b (net8),
    .out (net62)
  );
  and_cell and19 (
    .a (net62),
    .b (net63),
    .out (net64)
  );
  and_cell and20 (
    .a (net5),
    .b (net8),
    .out (net65)
  );
  or_cell or13 (
    .a (net64),
    .b (net65),
    .out (net66)
  );
  xor_cell xor6 (
    .a (net67),
    .b (net66),
    .out (net57)
  );
  xor_cell xor7 (
    .a (net4),
    .b (net7),
    .out (net67)
  );
  and_cell and21 (
    .a (net67),
    .b (net66),
    .out (net68)
  );
  and_cell and22 (
    .a (net4),
    .b (net7),
    .out (net69)
  );
  or_cell or14 (
    .a (net68),
    .b (net69),
    .out (net70)
  );
  xor_cell xor8 (
    .a (net3),
    .b (net6),
    .out (net71)
  );
  and_cell and23 (
    .a (net71),
    .b (net70),
    .out (net72)
  );
  and_cell and24 (
    .a (net3),
    .b (net6),
    .out (net73)
  );
  or_cell or15 (
    .a (net72),
    .b (net73),
    .out (net74)
  );
  xor_cell xor9 (
    .a (net71),
    .b (net70),
    .out (net55)
  );
  not_cell not3 (
    .in (net24),
    .out (net54)
  );
  and_cell and25 (
    .a (net54),
    .b (net74),
    .out (net16)
  );
  and_cell and26 (
    .a (net35),
    .b (net75),
    .out (net76)
  );
  xor_cell xor10 (
    .a (net42),
    .b (net49),
    .out (net75)
  );
  not_cell not4 (
    .in (net35),
    .out (net77)
  );
  not_cell not5 (
    .in (net49),
    .out (net78)
  );
  and_cell and27 (
    .a (net42),
    .b (net79),
    .out (net80)
  );
  and_cell and28 (
    .a (net77),
    .b (net78),
    .out (net79)
  );
  and_cell and29 (
    .a (net49),
    .b (net81),
    .out (net82)
  );
  and_cell and30 (
    .a (net83),
    .b (net84),
    .out (net81)
  );
  or_cell or16 (
    .a (net82),
    .b (net85),
    .out (net86)
  );
  or_cell or17 (
    .a (net87),
    .b (net88),
    .out (net85)
  );
  not_cell not6 (
    .in (net42),
    .out (net89)
  );
  not_cell not7 (
    .in (net49),
    .out (net90)
  );
  and_cell and31 (
    .a (net89),
    .b (net90),
    .out (net91)
  );
  and_cell and32 (
    .a (net91),
    .b (net35),
    .out (net87)
  );
  not_cell not8 (
    .in (net35),
    .out (net83)
  );
  not_cell not9 (
    .in (net42),
    .out (net84)
  );
  and_cell and33 (
    .a (net35),
    .b (net42),
    .out (net92)
  );
  and_cell and34 (
    .a (net92),
    .b (net49),
    .out (net88)
  );
  not_cell not10 (
    .in (net76),
    .out (net10)
  );
  not_cell not11 (
    .in (net80),
    .out (net11)
  );
  not_cell not12 (
    .in (net86),
    .out (net12)
  );
  and_cell and35 (
    .a (net93),
    .b (net94),
    .out (net95)
  );
  not_cell not13 (
    .in (net49),
    .out (net94)
  );
  or_cell or18 (
    .a (net35),
    .b (net42),
    .out (net96)
  );
  not_cell not14 (
    .in (net96),
    .out (net93)
  );
  or_cell or19 (
    .a (net95),
    .b (net97),
    .out (net98)
  );
  or_cell or20 (
    .a (net98),
    .b (net99),
    .out (net13)
  );
  and_cell and36 (
    .a (net100),
    .b (net42),
    .out (net97)
  );
  or_cell or21 (
    .a (net49),
    .b (net35),
    .out (net101)
  );
  not_cell not15 (
    .in (net101),
    .out (net100)
  );
  and_cell and37 (
    .a (net35),
    .b (net42),
    .out (net102)
  );
  not_cell not16 (
    .in (net49),
    .out (net103)
  );
  and_cell and38 (
    .a (net102),
    .b (net103),
    .out (net99)
  );
  or_cell or22 (
    .a (net95),
    .b (net87),
    .out (net104)
  );
  or_cell or23 (
    .a (net99),
    .b (net105),
    .out (net106)
  );
  or_cell or24 (
    .a (net104),
    .b (net106),
    .out (net14)
  );
  and_cell and39 (
    .a (net35),
    .b (net49),
    .out (net107)
  );
  not_cell not17 (
    .in (net42),
    .out (net108)
  );
  and_cell and40 (
    .a (net107),
    .b (net108),
    .out (net105)
  );
  or_cell or25 (
    .a (net109),
    .b (net87),
    .out (net110)
  );
  not_cell not18 (
    .in (net110),
    .out (net9)
  );
  or_cell or26 (
    .a (net35),
    .b (net42),
    .out (net111)
  );
  not_cell not19 (
    .in (net111),
    .out (net112)
  );
  and_cell and41 (
    .a (net112),
    .b (net49),
    .out (net109)
  );
  or_cell or27 (
    .a (net109),
    .b (net95),
    .out (net113)
  );
  or_cell or28 (
    .a (net113),
    .b (net88),
    .out (net114)
  );
  not_cell not20 (
    .in (net114),
    .out (net15)
  );
endmodule
