/* Automatically generated from https://wokwi.com/projects/407852791999030273 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_407852791999030273(
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
  wire net18 = 1'b1;
  wire net19 = 1'b1;
  wire net20 = 1'b0;
  wire net21 = 1'b1;
  wire net22 = 1'b0;
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
  wire net63;
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
  wire net115;
  wire net116;
  wire net117;
  wire net118;
  wire net119;
  wire net120;
  wire net121;
  wire net122;
  wire net123;
  wire net124;
  wire net125;
  wire net126;
  wire net127;
  wire net128;
  wire net129;
  wire net130;
  wire net131;
  wire net132;
  wire net133;
  wire net134;
  wire net135;
  wire net136;
  wire net137;
  wire net138;
  wire net139;
  wire net140;
  wire net141;
  wire net142;
  wire net143;
  wire net144;
  wire net145;
  wire net146;
  wire net147;
  wire net148;
  wire net149;
  wire net150;
  wire net151;
  wire net152;
  wire net153;
  wire net154;
  wire net155;
  wire net156;
  wire net157;
  wire net158;
  wire net159;
  wire net160;
  wire net161;
  wire net162;
  wire net163;
  wire net164;
  wire net165;
  wire net166;
  wire net167;
  wire net168;
  wire net169;
  wire net170;
  wire net171;
  wire net172;
  wire net173;
  wire net174;
  wire net175;
  wire net176;
  wire net177;
  wire net178;
  wire net179;
  wire net180;
  wire net181;
  wire net182;
  wire net183;
  wire net184;
  wire net185;
  wire net186;
  wire net187;
  wire net188;
  wire net189;
  wire net190;
  wire net191;
  wire net192;
  wire net193;
  wire net194;
  wire net195;
  wire net196;
  wire net197;
  wire net198;
  wire net199;
  wire net200;
  wire net201;
  wire net202;
  wire net203;
  wire net204;
  wire net205;
  wire net206;
  wire net207;
  wire net208;
  wire net209;
  wire net210;
  wire net211;
  wire net212;
  wire net213 = 1'b0;
  wire net214;
  wire net215;
  wire net216;
  wire net217;
  wire net218;
  wire net219;
  wire net220;

  assign uo_out[0] = net10;
  assign uo_out[1] = net11;
  assign uo_out[2] = net12;
  assign uo_out[3] = net13;
  assign uo_out[4] = net14;
  assign uo_out[5] = net15;
  assign uo_out[6] = net16;
  assign uo_out[7] = net17;
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

  xor_cell xor3 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  and_cell and3 (
    .a (net23),
    .b (net24),
    .out (net26)
  );
  xor_cell xor4 (
    .a (net9),
    .b (net25),
    .out (net27)
  );
  and_cell and4 (
    .a (net9),
    .b (net25),
    .out (net28)
  );
  or_cell or2 (
    .a (net26),
    .b (net28),
    .out (net29)
  );
  xor_cell xor5 (
    .a (net30),
    .b (net31),
    .out (net32)
  );
  and_cell and5 (
    .a (net30),
    .b (net31),
    .out (net33)
  );
  xor_cell xor6 (
    .a (net29),
    .b (net32),
    .out (net34)
  );
  and_cell and6 (
    .a (net29),
    .b (net32),
    .out (net35)
  );
  or_cell or3 (
    .a (net33),
    .b (net35),
    .out (net36)
  );
  xor_cell xor7 (
    .a (net37),
    .b (net38),
    .out (net39)
  );
  and_cell and7 (
    .a (net37),
    .b (net38),
    .out (net40)
  );
  xor_cell xor8 (
    .a (net36),
    .b (net39),
    .out (net41)
  );
  and_cell and8 (
    .a (net36),
    .b (net39),
    .out (net42)
  );
  or_cell or4 (
    .a (net40),
    .b (net42),
    .out (net43)
  );
  xor_cell xor9 (
    .a (net44),
    .b (net45),
    .out (net46)
  );
  and_cell and9 (
    .a (net44),
    .b (net45),
    .out (net47)
  );
  xor_cell xor10 (
    .a (net43),
    .b (net46),
    .out (net48)
  );
  and_cell and10 (
    .a (net43),
    .b (net46),
    .out (net49)
  );
  or_cell or5 (
    .a (net47),
    .b (net49),
    .out (net50)
  );
  xor_cell xor11 (
    .a (net51),
    .b (net52),
    .out (net53)
  );
  and_cell and11 (
    .a (net51),
    .b (net52),
    .out (net54)
  );
  xor_cell xor12 (
    .a (net50),
    .b (net53),
    .out (net55)
  );
  and_cell and12 (
    .a (net50),
    .b (net53),
    .out (net56)
  );
  or_cell or6 (
    .a (net54),
    .b (net56),
    .out (net57)
  );
  xor_cell xor13 (
    .a (net58),
    .b (net59),
    .out (net60)
  );
  and_cell and13 (
    .a (net58),
    .b (net59),
    .out (net61)
  );
  xor_cell xor14 (
    .a (net57),
    .b (net60),
    .out (net62)
  );
  and_cell and14 (
    .a (net57),
    .b (net60),
    .out (net63)
  );
  or_cell or7 (
    .a (net61),
    .b (net63),
    .out (net64)
  );
  xor_cell xor15 (
    .a (net65),
    .b (net66),
    .out (net67)
  );
  and_cell and15 (
    .a (net65),
    .b (net66),
    .out (net68)
  );
  xor_cell xor16 (
    .a (net64),
    .b (net67),
    .out (net69)
  );
  and_cell and16 (
    .a (net64),
    .b (net67),
    .out (net70)
  );
  or_cell or8 (
    .a (net68),
    .b (net70),
    .out (net71)
  );
  xor_cell xor17 (
    .a (net72),
    .b (net73),
    .out (net74)
  );
  and_cell and17 (
    .a (net72),
    .b (net73),
    .out (net75)
  );
  xor_cell xor18 (
    .a (net71),
    .b (net74),
    .out (net76)
  );
  and_cell and18 (
    .a (net71),
    .b (net74),
    .out (net77)
  );
  or_cell or9 (
    .a (net75),
    .b (net77),
    .out ()
  );
  dff_cell flop1 (
    .d (net78),
    .clk (net1),
    .q (net23),
    .notq ()
  );
  dff_cell flop2 (
    .d (net79),
    .clk (net1),
    .q (net30),
    .notq ()
  );
  dff_cell flop3 (
    .d (net80),
    .clk (net1),
    .q (net37),
    .notq ()
  );
  dff_cell flop4 (
    .d (net81),
    .clk (net1),
    .q (net44),
    .notq ()
  );
  dff_cell flop5 (
    .d (net82),
    .clk (net1),
    .q (net51),
    .notq ()
  );
  dff_cell flop6 (
    .d (net83),
    .clk (net1),
    .q (net58),
    .notq ()
  );
  dff_cell flop7 (
    .d (net84),
    .clk (net1),
    .q (net65),
    .notq ()
  );
  dff_cell flop8 (
    .d (net85),
    .clk (net1),
    .q (net72),
    .notq ()
  );
  dff_cell flop9 (
    .d (net86),
    .clk (net1),
    .q (net87),
    .notq ()
  );
  dff_cell flop10 (
    .d (net88),
    .clk (net1),
    .q (net89),
    .notq ()
  );
  dff_cell flop11 (
    .d (net90),
    .clk (net1),
    .q (net91),
    .notq ()
  );
  dff_cell flop12 (
    .d (net92),
    .clk (net1),
    .q (net93),
    .notq ()
  );
  dff_cell flop13 (
    .d (net94),
    .clk (net1),
    .q (net95),
    .notq ()
  );
  dff_cell flop14 (
    .d (net96),
    .clk (net1),
    .q (net97),
    .notq ()
  );
  dff_cell flop15 (
    .d (net98),
    .clk (net1),
    .q (net99),
    .notq ()
  );
  dff_cell flop16 (
    .d (net100),
    .clk (net1),
    .q (net101),
    .notq ()
  );
  dff_cell flop17 (
    .d (net2),
    .clk (net1),
    .q (net102),
    .notq ()
  );
  dff_cell flop18 (
    .d (net102),
    .clk (net1),
    .q (net103),
    .notq ()
  );
  dff_cell flop19 (
    .d (net103),
    .clk (net1),
    .q (net104),
    .notq ()
  );
  dff_cell flop20 (
    .d (net104),
    .clk (net1),
    .q (net105),
    .notq ()
  );
  dff_cell flop21 (
    .d (net105),
    .clk (net1),
    .q (net106),
    .notq ()
  );
  dff_cell flop22 (
    .d (net106),
    .clk (net1),
    .q (net107),
    .notq ()
  );
  dff_cell flop23 (
    .d (net107),
    .clk (net1),
    .q (net108),
    .notq ()
  );
  dff_cell flop24 (
    .d (net108),
    .clk (net1),
    .q (net109),
    .notq ()
  );
  and_cell and1 (
    .a (net10),
    .b (net110),
    .out (net111)
  );
  and_cell and2 (
    .a (net11),
    .b (net110),
    .out (net112)
  );
  and_cell and19 (
    .a (net12),
    .b (net110),
    .out (net113)
  );
  and_cell and20 (
    .a (net13),
    .b (net110),
    .out (net114)
  );
  and_cell and21 (
    .a (net14),
    .b (net110),
    .out (net115)
  );
  and_cell and22 (
    .a (net15),
    .b (net110),
    .out (net116)
  );
  and_cell and23 (
    .a (net16),
    .b (net110),
    .out (net117)
  );
  and_cell and24 (
    .a (net17),
    .b (net110),
    .out (net118)
  );
  and_cell and25 (
    .a (net23),
    .b (net119),
    .out (net120)
  );
  and_cell and26 (
    .a (net30),
    .b (net119),
    .out (net121)
  );
  and_cell and27 (
    .a (net37),
    .b (net119),
    .out (net122)
  );
  and_cell and28 (
    .a (net44),
    .b (net119),
    .out (net123)
  );
  and_cell and29 (
    .a (net51),
    .b (net119),
    .out (net124)
  );
  and_cell and30 (
    .a (net58),
    .b (net119),
    .out (net125)
  );
  and_cell and31 (
    .a (net65),
    .b (net119),
    .out (net126)
  );
  and_cell and32 (
    .a (net72),
    .b (net119),
    .out (net127)
  );
  not_cell not1 (
    .in (net110),
    .out (net119)
  );
  or_cell or1 (
    .a (net128),
    .b (net120),
    .out (net10)
  );
  or_cell or10 (
    .a (net129),
    .b (net121),
    .out (net11)
  );
  or_cell or11 (
    .a (net130),
    .b (net122),
    .out (net12)
  );
  or_cell or12 (
    .a (net131),
    .b (net123),
    .out (net13)
  );
  or_cell or13 (
    .a (net132),
    .b (net124),
    .out (net14)
  );
  or_cell or14 (
    .a (net133),
    .b (net125),
    .out (net15)
  );
  or_cell or15 (
    .a (net134),
    .b (net126),
    .out (net16)
  );
  or_cell or16 (
    .a (net135),
    .b (net127),
    .out (net17)
  );
  and_cell and33 (
    .a (net102),
    .b (net3),
    .out (net136)
  );
  and_cell and34 (
    .a (net103),
    .b (net3),
    .out (net137)
  );
  and_cell and35 (
    .a (net104),
    .b (net3),
    .out (net138)
  );
  and_cell and36 (
    .a (net105),
    .b (net3),
    .out (net139)
  );
  and_cell and37 (
    .a (net106),
    .b (net3),
    .out (net140)
  );
  and_cell and38 (
    .a (net107),
    .b (net3),
    .out (net141)
  );
  and_cell and39 (
    .a (net108),
    .b (net3),
    .out (net142)
  );
  and_cell and40 (
    .a (net109),
    .b (net3),
    .out (net143)
  );
  and_cell and41 (
    .a (net10),
    .b (net144),
    .out (net145)
  );
  and_cell and42 (
    .a (net11),
    .b (net144),
    .out (net146)
  );
  and_cell and43 (
    .a (net12),
    .b (net144),
    .out (net147)
  );
  and_cell and44 (
    .a (net13),
    .b (net144),
    .out (net148)
  );
  and_cell and45 (
    .a (net14),
    .b (net144),
    .out (net149)
  );
  and_cell and46 (
    .a (net15),
    .b (net144),
    .out (net150)
  );
  and_cell and47 (
    .a (net16),
    .b (net144),
    .out (net151)
  );
  and_cell and48 (
    .a (net17),
    .b (net144),
    .out (net152)
  );
  and_cell and49 (
    .a (net87),
    .b (net153),
    .out (net154)
  );
  and_cell and50 (
    .a (net89),
    .b (net153),
    .out (net155)
  );
  and_cell and51 (
    .a (net91),
    .b (net153),
    .out (net156)
  );
  and_cell and52 (
    .a (net93),
    .b (net153),
    .out (net157)
  );
  and_cell and53 (
    .a (net95),
    .b (net153),
    .out (net158)
  );
  and_cell and54 (
    .a (net97),
    .b (net153),
    .out (net159)
  );
  and_cell and55 (
    .a (net99),
    .b (net153),
    .out (net160)
  );
  and_cell and56 (
    .a (net101),
    .b (net153),
    .out (net161)
  );
  not_cell not2 (
    .in (net144),
    .out (net153)
  );
  not_cell not3 (
    .in (net5),
    .out (net144)
  );
  not_cell not4 (
    .in (net4),
    .out (net110)
  );
  or_cell or17 (
    .a (net162),
    .b (net136),
    .out (net128)
  );
  or_cell or18 (
    .a (net163),
    .b (net137),
    .out (net129)
  );
  or_cell or19 (
    .a (net164),
    .b (net138),
    .out (net130)
  );
  or_cell or20 (
    .a (net165),
    .b (net139),
    .out (net131)
  );
  or_cell or21 (
    .a (net166),
    .b (net140),
    .out (net132)
  );
  or_cell or22 (
    .a (net167),
    .b (net141),
    .out (net133)
  );
  or_cell or23 (
    .a (net168),
    .b (net142),
    .out (net134)
  );
  or_cell or24 (
    .a (net169),
    .b (net143),
    .out (net135)
  );
  and_cell and57 (
    .a (net145),
    .b (net8),
    .out (net170)
  );
  or_cell or25 (
    .a (net171),
    .b (net170),
    .out (net86)
  );
  not_cell not5 (
    .in (net8),
    .out (net172)
  );
  and_cell and58 (
    .a (net172),
    .b (net87),
    .out (net171)
  );
  and_cell and59 (
    .a (net146),
    .b (net8),
    .out (net173)
  );
  and_cell and60 (
    .a (net172),
    .b (net89),
    .out (net174)
  );
  or_cell or26 (
    .a (net174),
    .b (net173),
    .out (net88)
  );
  and_cell and61 (
    .a (net147),
    .b (net8),
    .out (net175)
  );
  and_cell and62 (
    .a (net172),
    .b (net91),
    .out (net176)
  );
  or_cell or27 (
    .a (net176),
    .b (net175),
    .out (net90)
  );
  and_cell and63 (
    .a (net148),
    .b (net8),
    .out (net177)
  );
  and_cell and64 (
    .a (net172),
    .b (net93),
    .out (net178)
  );
  or_cell or28 (
    .a (net178),
    .b (net177),
    .out (net92)
  );
  and_cell and65 (
    .a (net149),
    .b (net8),
    .out (net179)
  );
  and_cell and66 (
    .a (net172),
    .b (net95),
    .out (net180)
  );
  or_cell or29 (
    .a (net180),
    .b (net179),
    .out (net94)
  );
  and_cell and67 (
    .a (net150),
    .b (net8),
    .out (net181)
  );
  and_cell and68 (
    .a (net172),
    .b (net97),
    .out (net182)
  );
  or_cell or30 (
    .a (net182),
    .b (net181),
    .out (net96)
  );
  and_cell and69 (
    .a (net151),
    .b (net8),
    .out (net183)
  );
  and_cell and70 (
    .a (net172),
    .b (net99),
    .out (net184)
  );
  or_cell or31 (
    .a (net184),
    .b (net183),
    .out (net98)
  );
  and_cell and71 (
    .a (net152),
    .b (net8),
    .out (net185)
  );
  and_cell and72 (
    .a (net172),
    .b (net101),
    .out (net186)
  );
  or_cell or32 (
    .a (net186),
    .b (net185),
    .out (net100)
  );
  and_cell and73 (
    .a (net111),
    .b (net7),
    .out (net187)
  );
  and_cell and74 (
    .a (net188),
    .b (net23),
    .out (net189)
  );
  or_cell or33 (
    .a (net189),
    .b (net187),
    .out (net78)
  );
  and_cell and75 (
    .a (net112),
    .b (net7),
    .out (net190)
  );
  and_cell and76 (
    .a (net188),
    .b (net30),
    .out (net191)
  );
  or_cell or34 (
    .a (net191),
    .b (net190),
    .out (net79)
  );
  and_cell and77 (
    .a (net113),
    .b (net7),
    .out (net192)
  );
  and_cell and78 (
    .a (net188),
    .b (net37),
    .out (net193)
  );
  or_cell or35 (
    .a (net193),
    .b (net192),
    .out (net80)
  );
  and_cell and79 (
    .a (net114),
    .b (net7),
    .out (net194)
  );
  and_cell and80 (
    .a (net188),
    .b (net44),
    .out (net195)
  );
  or_cell or36 (
    .a (net195),
    .b (net194),
    .out (net81)
  );
  and_cell and81 (
    .a (net115),
    .b (net7),
    .out (net196)
  );
  and_cell and82 (
    .a (net188),
    .b (net51),
    .out (net197)
  );
  or_cell or37 (
    .a (net197),
    .b (net196),
    .out (net82)
  );
  and_cell and83 (
    .a (net116),
    .b (net7),
    .out (net198)
  );
  and_cell and84 (
    .a (net188),
    .b (net58),
    .out (net199)
  );
  or_cell or38 (
    .a (net199),
    .b (net198),
    .out (net83)
  );
  and_cell and85 (
    .a (net117),
    .b (net7),
    .out (net200)
  );
  and_cell and86 (
    .a (net188),
    .b (net65),
    .out (net201)
  );
  or_cell or39 (
    .a (net201),
    .b (net200),
    .out (net84)
  );
  and_cell and87 (
    .a (net118),
    .b (net7),
    .out (net202)
  );
  and_cell and88 (
    .a (net188),
    .b (net72),
    .out (net203)
  );
  or_cell or40 (
    .a (net203),
    .b (net202),
    .out (net85)
  );
  not_cell not6 (
    .in (net7),
    .out (net188)
  );
  xor_cell xor1 (
    .a (net9),
    .b (net87),
    .out (net24)
  );
  xor_cell xor2 (
    .a (net9),
    .b (net89),
    .out (net31)
  );
  xor_cell xor19 (
    .a (net9),
    .b (net91),
    .out (net38)
  );
  xor_cell xor20 (
    .a (net9),
    .b (net93),
    .out (net45)
  );
  xor_cell xor21 (
    .a (net9),
    .b (net95),
    .out (net52)
  );
  xor_cell xor22 (
    .a (net9),
    .b (net97),
    .out (net59)
  );
  xor_cell xor23 (
    .a (net9),
    .b (net99),
    .out (net66)
  );
  xor_cell xor24 (
    .a (net9),
    .b (net101),
    .out (net73)
  );
  or_cell or41 (
    .a (net154),
    .b (net204),
    .out (net162)
  );
  or_cell or42 (
    .a (net155),
    .b (net205),
    .out (net163)
  );
  or_cell or43 (
    .a (net156),
    .b (net206),
    .out (net164)
  );
  or_cell or44 (
    .a (net157),
    .b (net207),
    .out (net165)
  );
  or_cell or45 (
    .a (net158),
    .b (net208),
    .out (net166)
  );
  or_cell or46 (
    .a (net159),
    .b (net209),
    .out (net167)
  );
  or_cell or47 (
    .a (net160),
    .b (net210),
    .out (net168)
  );
  or_cell or48 (
    .a (net161),
    .b (net211),
    .out (net169)
  );
  or_cell or49 (
    .a (net212),
    .b (net213),
    .out (net204)
  );
  or_cell or50 (
    .a (net214),
    .b (net213),
    .out (net205)
  );
  or_cell or51 (
    .a (net215),
    .b (net213),
    .out (net206)
  );
  or_cell or52 (
    .a (net216),
    .b (net213),
    .out (net207)
  );
  or_cell or53 (
    .a (net217),
    .b (net213),
    .out (net208)
  );
  or_cell or54 (
    .a (net218),
    .b (net213),
    .out (net209)
  );
  or_cell or55 (
    .a (net219),
    .b (net213),
    .out (net210)
  );
  or_cell or56 (
    .a (net220),
    .b (net213),
    .out (net211)
  );
  and_cell and89 (
    .a (net6),
    .b (net27),
    .out (net212)
  );
  and_cell and90 (
    .a (net6),
    .b (net34),
    .out (net214)
  );
  and_cell and91 (
    .a (net6),
    .b (net41),
    .out (net215)
  );
  and_cell and92 (
    .a (net6),
    .b (net48),
    .out (net216)
  );
  and_cell and93 (
    .a (net6),
    .b (net55),
    .out (net217)
  );
  and_cell and94 (
    .a (net6),
    .b (net62),
    .out (net218)
  );
  and_cell and95 (
    .a (net6),
    .b (net69),
    .out (net219)
  );
  and_cell and96 (
    .a (net6),
    .b (net76),
    .out (net220)
  );
endmodule
