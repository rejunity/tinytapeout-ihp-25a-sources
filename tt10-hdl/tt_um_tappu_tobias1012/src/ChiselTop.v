module TapeVecMemory(
  input         clock,
  input         reset,
  input  [8:0]  io_dataShift,
  input  [1:0]  io_wrMode,
  input  [7:0]  io_wrData,
  output [7:0]  io_outData,
  input  [8:0]  io_instrStep,
  output [15:0] io_instr
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] tape [0:2]; // @[TapeVecMemory.scala 16:25]
  wire  tape_readData_en; // @[TapeVecMemory.scala 16:25]
  wire [1:0] tape_readData_addr; // @[TapeVecMemory.scala 16:25]
  wire [7:0] tape_readData_data; // @[TapeVecMemory.scala 16:25]
  wire [7:0] tape_MPORT_data; // @[TapeVecMemory.scala 16:25]
  wire [1:0] tape_MPORT_addr; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_mask; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_en; // @[TapeVecMemory.scala 16:25]
  wire [7:0] tape_MPORT_1_data; // @[TapeVecMemory.scala 16:25]
  wire [1:0] tape_MPORT_1_addr; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_1_mask; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_1_en; // @[TapeVecMemory.scala 16:25]
  wire [7:0] tape_MPORT_2_data; // @[TapeVecMemory.scala 16:25]
  wire [1:0] tape_MPORT_2_addr; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_2_mask; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_2_en; // @[TapeVecMemory.scala 16:25]
  wire [7:0] tape_MPORT_3_data; // @[TapeVecMemory.scala 16:25]
  wire [1:0] tape_MPORT_3_addr; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_3_mask; // @[TapeVecMemory.scala 16:25]
  wire  tape_MPORT_3_en; // @[TapeVecMemory.scala 16:25]
  reg  tape_readData_en_pipe_0;
  reg [1:0] tape_readData_addr_pipe_0;
  reg  state; // @[TapeVecMemory.scala 19:22]
  reg [15:0] tapeCounterReg; // @[TapeVecMemory.scala 20:31]
  reg [5:0] pc; // @[TapeVecMemory.scala 21:19]
  wire  _T = ~state; // @[TapeVecMemory.scala 27:17]
  wire  _T_1 = tapeCounterReg != 16'h3; // @[TapeVecMemory.scala 29:27]
  wire [15:0] _tapeCounterReg_T_1 = tapeCounterReg + 16'h1; // @[TapeVecMemory.scala 32:42]
  wire [15:0] _GEN_194 = {{8'd0}, io_dataShift[7:0]}; // @[TapeVecMemory.scala 42:48]
  wire [15:0] _tapeCounterReg_T_4 = tapeCounterReg + _GEN_194; // @[TapeVecMemory.scala 42:48]
  wire [15:0] _tapeCounterReg_T_9 = _tapeCounterReg_T_4 >= 16'h3 ? 16'h2 : _tapeCounterReg_T_4; // @[TapeVecMemory.scala 42:32]
  wire [15:0] _tapeCounterReg_T_14 = tapeCounterReg - _GEN_194; // @[TapeVecMemory.scala 45:89]
  wire [15:0] _tapeCounterReg_T_15 = _GEN_194 >= tapeCounterReg ? 16'h0 : _tapeCounterReg_T_14; // @[TapeVecMemory.scala 45:32]
  wire [15:0] _GEN_7 = ~io_dataShift[8] ? _tapeCounterReg_T_9 : _tapeCounterReg_T_15; // @[TapeVecMemory.scala 41:39 42:26 45:26]
  wire  _T_8 = io_wrMode == 2'h1; // @[TapeVecMemory.scala 50:24]
  wire  _T_16 = io_wrMode == 2'h2; // @[TapeVecMemory.scala 52:30]
  wire  _T_17 = tape_readData_data < io_wrData; // @[TapeVecMemory.scala 53:51]
  wire [7:0] _T_19 = tape_readData_data - io_wrData; // @[TapeVecMemory.scala 53:78]
  wire  _T_22 = io_wrMode == 2'h3; // @[TapeVecMemory.scala 54:30]
  wire  _GEN_25 = io_wrMode == 2'h2 ? 1'h0 : _T_22; // @[TapeVecMemory.scala 16:25 52:48]
  wire  _GEN_35 = io_wrMode == 2'h1 ? 1'h0 : _T_16; // @[TapeVecMemory.scala 16:25 50:41]
  wire  _GEN_40 = io_wrMode == 2'h1 ? 1'h0 : _GEN_25; // @[TapeVecMemory.scala 16:25 50:41]
  wire  _GEN_45 = io_wrMode != 2'h0 & _T_8; // @[TapeVecMemory.scala 16:25 49:39]
  wire  _GEN_50 = io_wrMode != 2'h0 & _GEN_35; // @[TapeVecMemory.scala 16:25 49:39]
  wire  _GEN_55 = io_wrMode != 2'h0 & _GEN_40; // @[TapeVecMemory.scala 16:25 49:39]
  wire [5:0] _instrHigh_T_1 = pc + 6'h1; // @[TapeVecMemory.scala 60:34]
  wire [7:0] _GEN_59 = 6'h1 == _instrHigh_T_1 ? 8'h1 : 8'h20; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_60 = 6'h2 == _instrHigh_T_1 ? 8'h70 : _GEN_59; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_61 = 6'h3 == _instrHigh_T_1 ? 8'h1 : _GEN_60; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_62 = 6'h4 == _instrHigh_T_1 ? 8'h0 : _GEN_61; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_63 = 6'h5 == _instrHigh_T_1 ? 8'h1 : _GEN_62; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_64 = 6'h6 == _instrHigh_T_1 ? 8'h20 : _GEN_63; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_65 = 6'h7 == _instrHigh_T_1 ? 8'hff : _GEN_64; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_66 = 6'h8 == _instrHigh_T_1 ? 8'h50 : _GEN_65; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_67 = 6'h9 == _instrHigh_T_1 ? 8'h1 : _GEN_66; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_68 = 6'ha == _instrHigh_T_1 ? 8'h0 : _GEN_67; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_69 = 6'hb == _instrHigh_T_1 ? 8'h1 : _GEN_68; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_70 = 6'hc == _instrHigh_T_1 ? 8'h20 : _GEN_69; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_71 = 6'hd == _instrHigh_T_1 ? 8'h10 : _GEN_70; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_72 = 6'he == _instrHigh_T_1 ? 8'h70 : _GEN_71; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_73 = 6'hf == _instrHigh_T_1 ? 8'h1 : _GEN_72; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_74 = 6'h10 == _instrHigh_T_1 ? 8'h30 : _GEN_73; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_75 = 6'h11 == _instrHigh_T_1 ? 8'h1 : _GEN_74; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_76 = 6'h12 == _instrHigh_T_1 ? 8'h80 : _GEN_75; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_77 = 6'h13 == _instrHigh_T_1 ? 8'h2 : _GEN_76; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_78 = 6'h14 == _instrHigh_T_1 ? 8'h10 : _GEN_77; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_79 = 6'h15 == _instrHigh_T_1 ? 8'h1 : _GEN_78; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_80 = 6'h16 == _instrHigh_T_1 ? 8'h30 : _GEN_79; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_81 = 6'h17 == _instrHigh_T_1 ? 8'hff : _GEN_80; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_82 = 6'h18 == _instrHigh_T_1 ? 8'h50 : _GEN_81; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_83 = 6'h19 == _instrHigh_T_1 ? 8'h1 : _GEN_82; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_84 = 6'h1a == _instrHigh_T_1 ? 8'h0 : _GEN_83; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_85 = 6'h1b == _instrHigh_T_1 ? 8'h1 : _GEN_84; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_86 = 6'h1c == _instrHigh_T_1 ? 8'h20 : _GEN_85; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_87 = 6'h1d == _instrHigh_T_1 ? 8'h10 : _GEN_86; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_88 = 6'h1e == _instrHigh_T_1 ? 8'h70 : _GEN_87; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_89 = 6'h1f == _instrHigh_T_1 ? 8'h1 : _GEN_88; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_90 = 6'h20 == _instrHigh_T_1 ? 8'h30 : _GEN_89; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_91 = 6'h21 == _instrHigh_T_1 ? 8'h1 : _GEN_90; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_92 = 6'h22 == _instrHigh_T_1 ? 8'h80 : _GEN_91; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_93 = 6'h23 == _instrHigh_T_1 ? 8'h2 : _GEN_92; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_94 = 6'h24 == _instrHigh_T_1 ? 8'h10 : _GEN_93; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_95 = 6'h25 == _instrHigh_T_1 ? 8'h1 : _GEN_94; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_96 = 6'h26 == _instrHigh_T_1 ? 8'h10 : _GEN_95; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_97 = 6'h27 == _instrHigh_T_1 ? 8'h1 : _GEN_96; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_98 = 6'h28 == _instrHigh_T_1 ? 8'h80 : _GEN_97; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_99 = 6'h29 == _instrHigh_T_1 ? 8'h13 : _GEN_98; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_101 = 6'h1 == pc ? 8'h1 : 8'h20; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_102 = 6'h2 == pc ? 8'h70 : _GEN_101; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_103 = 6'h3 == pc ? 8'h1 : _GEN_102; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_104 = 6'h4 == pc ? 8'h0 : _GEN_103; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_105 = 6'h5 == pc ? 8'h1 : _GEN_104; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_106 = 6'h6 == pc ? 8'h20 : _GEN_105; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_107 = 6'h7 == pc ? 8'hff : _GEN_106; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_108 = 6'h8 == pc ? 8'h50 : _GEN_107; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_109 = 6'h9 == pc ? 8'h1 : _GEN_108; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_110 = 6'ha == pc ? 8'h0 : _GEN_109; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_111 = 6'hb == pc ? 8'h1 : _GEN_110; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_112 = 6'hc == pc ? 8'h20 : _GEN_111; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_113 = 6'hd == pc ? 8'h10 : _GEN_112; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_114 = 6'he == pc ? 8'h70 : _GEN_113; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_115 = 6'hf == pc ? 8'h1 : _GEN_114; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_116 = 6'h10 == pc ? 8'h30 : _GEN_115; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_117 = 6'h11 == pc ? 8'h1 : _GEN_116; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_118 = 6'h12 == pc ? 8'h80 : _GEN_117; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_119 = 6'h13 == pc ? 8'h2 : _GEN_118; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_120 = 6'h14 == pc ? 8'h10 : _GEN_119; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_121 = 6'h15 == pc ? 8'h1 : _GEN_120; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_122 = 6'h16 == pc ? 8'h30 : _GEN_121; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_123 = 6'h17 == pc ? 8'hff : _GEN_122; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_124 = 6'h18 == pc ? 8'h50 : _GEN_123; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_125 = 6'h19 == pc ? 8'h1 : _GEN_124; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_126 = 6'h1a == pc ? 8'h0 : _GEN_125; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_127 = 6'h1b == pc ? 8'h1 : _GEN_126; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_128 = 6'h1c == pc ? 8'h20 : _GEN_127; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_129 = 6'h1d == pc ? 8'h10 : _GEN_128; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_130 = 6'h1e == pc ? 8'h70 : _GEN_129; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_131 = 6'h1f == pc ? 8'h1 : _GEN_130; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_132 = 6'h20 == pc ? 8'h30 : _GEN_131; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_133 = 6'h21 == pc ? 8'h1 : _GEN_132; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_134 = 6'h22 == pc ? 8'h80 : _GEN_133; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_135 = 6'h23 == pc ? 8'h2 : _GEN_134; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_136 = 6'h24 == pc ? 8'h10 : _GEN_135; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_137 = 6'h25 == pc ? 8'h1 : _GEN_136; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_138 = 6'h26 == pc ? 8'h10 : _GEN_137; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_139 = 6'h27 == pc ? 8'h1 : _GEN_138; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_140 = 6'h28 == pc ? 8'h80 : _GEN_139; // @[Cat.scala 33:{92,92}]
  wire [7:0] _GEN_141 = 6'h29 == pc ? 8'h13 : _GEN_140; // @[Cat.scala 33:{92,92}]
  wire [15:0] _io_instr_T = {_GEN_99,_GEN_141}; // @[Cat.scala 33:92]
  wire [5:0] _pc_T_1 = pc + 6'h2; // @[TapeVecMemory.scala 66:20]
  wire [8:0] _pc_T_3 = {io_instrStep[7:0], 1'h0}; // @[TapeVecMemory.scala 68:42]
  wire [8:0] _GEN_198 = {{3'd0}, pc}; // @[TapeVecMemory.scala 68:20]
  wire [8:0] _pc_T_5 = _GEN_198 - _pc_T_3; // @[TapeVecMemory.scala 68:20]
  wire [8:0] _GEN_142 = io_instrStep[7:0] == 8'h0 ? {{3'd0}, _pc_T_1} : _pc_T_5; // @[TapeVecMemory.scala 65:42 66:14 68:14]
  wire [8:0] _GEN_143 = io_instrStep[8] ? _GEN_142 : {{3'd0}, pc}; // @[TapeVecMemory.scala 21:19 64:42]
  wire  _GEN_150 = state & _GEN_45; // @[TapeVecMemory.scala 27:17 16:25]
  wire  _GEN_155 = state & _GEN_50; // @[TapeVecMemory.scala 27:17 16:25]
  wire  _GEN_160 = state & _GEN_55; // @[TapeVecMemory.scala 27:17 16:25]
  wire [15:0] _GEN_163 = state ? _io_instr_T : 16'h0; // @[TapeVecMemory.scala 24:12 27:17 61:16]
  wire [7:0] _GEN_164 = state ? tape_readData_data : 8'h0; // @[TapeVecMemory.scala 25:14 27:17 62:18]
  wire [8:0] _GEN_165 = state ? _GEN_143 : {{3'd0}, pc}; // @[TapeVecMemory.scala 27:17 21:19]
  wire [8:0] _GEN_193 = ~state ? {{3'd0}, pc} : _GEN_165; // @[TapeVecMemory.scala 27:17 21:19]
  wire [8:0] _GEN_199 = reset ? 9'h0 : _GEN_193; // @[TapeVecMemory.scala 21:{19,19}]
  assign tape_readData_en = tape_readData_en_pipe_0;
  assign tape_readData_addr = tape_readData_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign tape_readData_data = tape[tape_readData_addr]; // @[TapeVecMemory.scala 16:25]
  `else
  assign tape_readData_data = tape_readData_addr >= 2'h3 ? _RAND_1[7:0] : tape[tape_readData_addr]; // @[TapeVecMemory.scala 16:25]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign tape_MPORT_data = 8'h0;
  assign tape_MPORT_addr = tapeCounterReg[1:0];
  assign tape_MPORT_mask = 1'h1;
  assign tape_MPORT_en = _T & _T_1;
  assign tape_MPORT_1_data = tape_readData_data + io_wrData;
  assign tape_MPORT_1_addr = tapeCounterReg[1:0];
  assign tape_MPORT_1_mask = 1'h1;
  assign tape_MPORT_1_en = _T ? 1'h0 : _GEN_150;
  assign tape_MPORT_2_data = _T_17 ? 8'h0 : _T_19;
  assign tape_MPORT_2_addr = tapeCounterReg[1:0];
  assign tape_MPORT_2_mask = 1'h1;
  assign tape_MPORT_2_en = _T ? 1'h0 : _GEN_155;
  assign tape_MPORT_3_data = io_wrData;
  assign tape_MPORT_3_addr = tapeCounterReg[1:0];
  assign tape_MPORT_3_mask = 1'h1;
  assign tape_MPORT_3_en = _T ? 1'h0 : _GEN_160;
  assign io_outData = ~state ? 8'h0 : _GEN_164; // @[TapeVecMemory.scala 25:14 27:17]
  assign io_instr = ~state ? 16'h0 : _GEN_163; // @[TapeVecMemory.scala 24:12 27:17]
  always @(posedge clock) begin
    if (tape_MPORT_en & tape_MPORT_mask) begin
      tape[tape_MPORT_addr] <= tape_MPORT_data; // @[TapeVecMemory.scala 16:25]
    end
    if (tape_MPORT_1_en & tape_MPORT_1_mask) begin
      tape[tape_MPORT_1_addr] <= tape_MPORT_1_data; // @[TapeVecMemory.scala 16:25]
    end
    if (tape_MPORT_2_en & tape_MPORT_2_mask) begin
      tape[tape_MPORT_2_addr] <= tape_MPORT_2_data; // @[TapeVecMemory.scala 16:25]
    end
    if (tape_MPORT_3_en & tape_MPORT_3_mask) begin
      tape[tape_MPORT_3_addr] <= tape_MPORT_3_data; // @[TapeVecMemory.scala 16:25]
    end
    if (_T) begin
      tape_readData_en_pipe_0 <= 1'h0;
    end else begin
      tape_readData_en_pipe_0 <= state;
    end
    if (_T ? 1'h0 : state) begin
      tape_readData_addr_pipe_0 <= tapeCounterReg[1:0];
    end
    if (reset) begin // @[TapeVecMemory.scala 19:22]
      state <= 1'h0; // @[TapeVecMemory.scala 19:22]
    end else if (~state) begin // @[TapeVecMemory.scala 27:17]
      if (!(tapeCounterReg != 16'h3)) begin // @[TapeVecMemory.scala 29:39]
        state <= 1'h1; // @[TapeVecMemory.scala 35:15]
      end
    end
    if (reset) begin // @[TapeVecMemory.scala 20:31]
      tapeCounterReg <= 16'h0; // @[TapeVecMemory.scala 20:31]
    end else if (~state) begin // @[TapeVecMemory.scala 27:17]
      if (tapeCounterReg != 16'h3) begin // @[TapeVecMemory.scala 29:39]
        tapeCounterReg <= _tapeCounterReg_T_1; // @[TapeVecMemory.scala 32:24]
      end else begin
        tapeCounterReg <= 16'h0; // @[TapeVecMemory.scala 34:24]
      end
    end else if (state) begin // @[TapeVecMemory.scala 27:17]
      if (io_dataShift != 9'h0) begin // @[TapeVecMemory.scala 40:34]
        tapeCounterReg <= _GEN_7;
      end
    end
    pc <= _GEN_199[5:0]; // @[TapeVecMemory.scala 21:{19,19}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    tape[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  tape_readData_en_pipe_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  tape_readData_addr_pipe_0 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  tapeCounterReg = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  pc = _RAND_6[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tappu(
  input        clock,
  input        reset,
  input  [7:0] io_in,
  output [7:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  mem_clock; // @[Tappu.scala 42:11]
  wire  mem_reset; // @[Tappu.scala 42:11]
  wire [8:0] mem_io_dataShift; // @[Tappu.scala 42:11]
  wire [1:0] mem_io_wrMode; // @[Tappu.scala 42:11]
  wire [7:0] mem_io_wrData; // @[Tappu.scala 42:11]
  wire [7:0] mem_io_outData; // @[Tappu.scala 42:11]
  wire [8:0] mem_io_instrStep; // @[Tappu.scala 42:11]
  wire [15:0] mem_io_instr; // @[Tappu.scala 42:11]
  reg [7:0] inReg; // @[Tappu.scala 35:22]
  reg [7:0] outReg; // @[Tappu.scala 38:23]
  reg [8:0] instrStepReg; // @[Tappu.scala 53:29]
  reg [2:0] cpuState; // @[Tappu.scala 78:25]
  wire [15:0] instr = mem_io_instr; // @[Tappu.scala 48:19 57:9]
  wire [8:0] _dataShift_T_1 = {1'h1,instr[15:8]}; // @[Cat.scala 33:92]
  wire [8:0] _dataShift_T_3 = {1'h0,instr[15:8]}; // @[Cat.scala 33:92]
  wire [8:0] _GEN_0 = ~(mem_io_outData == 8'h0) ? _dataShift_T_1 : 9'h100; // @[Tappu.scala 117:44 118:26 75:16]
  wire [2:0] _GEN_1 = ~(mem_io_outData == 8'h0) ? 3'h0 : 3'h3; // @[Tappu.scala 117:44 119:22 89:16]
  wire [2:0] _GEN_2 = 8'hff == instr[7:0] ? 3'h5 : 3'h3; // @[Tappu.scala 126:20 89:16 90:26]
  wire [8:0] _GEN_3 = 8'h80 == instr[7:0] ? _GEN_0 : 9'h100; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_4 = 8'h80 == instr[7:0] ? _GEN_1 : _GEN_2; // @[Tappu.scala 90:26]
  wire [8:0] _GEN_5 = 8'h70 == instr[7:0] ? 9'h100 : _GEN_3; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_6 = 8'h70 == instr[7:0] ? 3'h3 : _GEN_4; // @[Tappu.scala 89:16 90:26]
  wire [1:0] _GEN_7 = 8'h30 == instr[7:0] ? 2'h2 : 2'h0; // @[Tappu.scala 110:18 72:10 90:26]
  wire [7:0] _GEN_8 = 8'h30 == instr[7:0] ? instr[15:8] : 8'h0; // @[Tappu.scala 111:18 73:10 90:26]
  wire [8:0] _GEN_9 = 8'h30 == instr[7:0] ? 9'h100 : _GEN_5; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_10 = 8'h30 == instr[7:0] ? 3'h3 : _GEN_6; // @[Tappu.scala 89:16 90:26]
  wire [1:0] _GEN_11 = 8'h20 == instr[7:0] ? 2'h1 : _GEN_7; // @[Tappu.scala 106:18 90:26]
  wire [7:0] _GEN_12 = 8'h20 == instr[7:0] ? instr[15:8] : _GEN_8; // @[Tappu.scala 107:18 90:26]
  wire [8:0] _GEN_13 = 8'h20 == instr[7:0] ? 9'h100 : _GEN_9; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_14 = 8'h20 == instr[7:0] ? 3'h3 : _GEN_10; // @[Tappu.scala 89:16 90:26]
  wire [8:0] _GEN_15 = 8'h0 == instr[7:0] ? _dataShift_T_3 : 9'h0; // @[Tappu.scala 103:21 74:13 90:26]
  wire [1:0] _GEN_16 = 8'h0 == instr[7:0] ? 2'h0 : _GEN_11; // @[Tappu.scala 72:10 90:26]
  wire [7:0] _GEN_17 = 8'h0 == instr[7:0] ? 8'h0 : _GEN_12; // @[Tappu.scala 73:10 90:26]
  wire [8:0] _GEN_18 = 8'h0 == instr[7:0] ? 9'h100 : _GEN_13; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_19 = 8'h0 == instr[7:0] ? 3'h3 : _GEN_14; // @[Tappu.scala 89:16 90:26]
  wire [8:0] _GEN_20 = 8'h10 == instr[7:0] ? _dataShift_T_1 : _GEN_15; // @[Tappu.scala 100:21 90:26]
  wire [1:0] _GEN_21 = 8'h10 == instr[7:0] ? 2'h0 : _GEN_16; // @[Tappu.scala 72:10 90:26]
  wire [7:0] _GEN_22 = 8'h10 == instr[7:0] ? 8'h0 : _GEN_17; // @[Tappu.scala 73:10 90:26]
  wire [8:0] _GEN_23 = 8'h10 == instr[7:0] ? 9'h100 : _GEN_18; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_24 = 8'h10 == instr[7:0] ? 3'h3 : _GEN_19; // @[Tappu.scala 89:16 90:26]
  wire [7:0] _GEN_25 = 8'h50 == instr[7:0] ? mem_io_outData : outReg; // @[Tappu.scala 90:26 97:18 38:23]
  wire [8:0] _GEN_26 = 8'h50 == instr[7:0] ? 9'h0 : _GEN_20; // @[Tappu.scala 74:13 90:26]
  wire [1:0] _GEN_27 = 8'h50 == instr[7:0] ? 2'h0 : _GEN_21; // @[Tappu.scala 72:10 90:26]
  wire [7:0] _GEN_28 = 8'h50 == instr[7:0] ? 8'h0 : _GEN_22; // @[Tappu.scala 73:10 90:26]
  wire [8:0] _GEN_29 = 8'h50 == instr[7:0] ? 9'h100 : _GEN_23; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_30 = 8'h50 == instr[7:0] ? 3'h3 : _GEN_24; // @[Tappu.scala 89:16 90:26]
  wire [1:0] _GEN_31 = 8'h60 == instr[7:0] ? 2'h3 : _GEN_27; // @[Tappu.scala 90:26 93:18]
  wire [7:0] _GEN_32 = 8'h60 == instr[7:0] ? inReg : _GEN_28; // @[Tappu.scala 90:26 94:18]
  wire [7:0] _GEN_33 = 8'h60 == instr[7:0] ? outReg : _GEN_25; // @[Tappu.scala 38:23 90:26]
  wire [8:0] _GEN_34 = 8'h60 == instr[7:0] ? 9'h0 : _GEN_26; // @[Tappu.scala 74:13 90:26]
  wire [8:0] _GEN_35 = 8'h60 == instr[7:0] ? 9'h100 : _GEN_29; // @[Tappu.scala 75:16 90:26]
  wire [2:0] _GEN_36 = 8'h60 == instr[7:0] ? 3'h3 : _GEN_30; // @[Tappu.scala 89:16 90:26]
  wire [2:0] _GEN_37 = 3'h4 == cpuState ? 3'h0 : cpuState; // @[Tappu.scala 137:16 80:20 78:25]
  wire [2:0] _GEN_38 = 3'h3 == cpuState ? 3'h4 : _GEN_37; // @[Tappu.scala 133:16 80:20]
  wire [1:0] _GEN_40 = 3'h2 == cpuState ? _GEN_31 : 2'h0; // @[Tappu.scala 72:10 80:20]
  wire [7:0] _GEN_41 = 3'h2 == cpuState ? _GEN_32 : 8'h0; // @[Tappu.scala 73:10 80:20]
  wire [8:0] _GEN_43 = 3'h2 == cpuState ? _GEN_34 : 9'h0; // @[Tappu.scala 74:13 80:20]
  wire [1:0] _GEN_46 = 3'h1 == cpuState ? 2'h0 : _GEN_40; // @[Tappu.scala 72:10 80:20]
  wire [7:0] _GEN_47 = 3'h1 == cpuState ? 8'h0 : _GEN_41; // @[Tappu.scala 73:10 80:20]
  wire [8:0] _GEN_49 = 3'h1 == cpuState ? 9'h0 : _GEN_43; // @[Tappu.scala 74:13 80:20]
  wire [7:0] _GEN_54 = 3'h0 == cpuState ? 8'h0 : _GEN_47; // @[Tappu.scala 73:10 80:20]
  wire [8:0] wrData = {{1'd0}, _GEN_54}; // @[Tappu.scala 50:20]
  TapeVecMemory mem ( // @[Tappu.scala 42:11]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_dataShift(mem_io_dataShift),
    .io_wrMode(mem_io_wrMode),
    .io_wrData(mem_io_wrData),
    .io_outData(mem_io_outData),
    .io_instrStep(mem_io_instrStep),
    .io_instr(mem_io_instr)
  );
  assign io_out = outReg; // @[Tappu.scala 144:10]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_dataShift = 3'h0 == cpuState ? 9'h0 : _GEN_49; // @[Tappu.scala 74:13 80:20]
  assign mem_io_wrMode = 3'h0 == cpuState ? 2'h0 : _GEN_46; // @[Tappu.scala 72:10 80:20]
  assign mem_io_wrData = wrData[7:0]; // @[Tappu.scala 60:17]
  assign mem_io_instrStep = 3'h0 == cpuState ? instrStepReg : 9'h0; // @[Tappu.scala 80:20 82:17 47:30]
  always @(posedge clock) begin
    if (reset) begin // @[Tappu.scala 35:22]
      inReg <= 8'h0; // @[Tappu.scala 35:22]
    end else begin
      inReg <= io_in; // @[Tappu.scala 36:9]
    end
    if (reset) begin // @[Tappu.scala 38:23]
      outReg <= 8'h0; // @[Tappu.scala 38:23]
    end else if (!(3'h0 == cpuState)) begin // @[Tappu.scala 80:20]
      if (!(3'h1 == cpuState)) begin // @[Tappu.scala 80:20]
        if (3'h2 == cpuState) begin // @[Tappu.scala 80:20]
          outReg <= _GEN_33;
        end
      end
    end
    if (reset) begin // @[Tappu.scala 53:29]
      instrStepReg <= 9'h100; // @[Tappu.scala 53:29]
    end else if (3'h0 == cpuState) begin // @[Tappu.scala 80:20]
      instrStepReg <= 9'h100; // @[Tappu.scala 75:16]
    end else if (3'h1 == cpuState) begin // @[Tappu.scala 80:20]
      instrStepReg <= 9'h100; // @[Tappu.scala 75:16]
    end else if (3'h2 == cpuState) begin // @[Tappu.scala 80:20]
      instrStepReg <= _GEN_35;
    end else begin
      instrStepReg <= 9'h100; // @[Tappu.scala 75:16]
    end
    if (reset) begin // @[Tappu.scala 78:25]
      cpuState <= 3'h0; // @[Tappu.scala 78:25]
    end else if (3'h0 == cpuState) begin // @[Tappu.scala 80:20]
      cpuState <= 3'h1; // @[Tappu.scala 83:16]
    end else if (3'h1 == cpuState) begin // @[Tappu.scala 80:20]
      cpuState <= 3'h2; // @[Tappu.scala 86:16]
    end else if (3'h2 == cpuState) begin // @[Tappu.scala 80:20]
      cpuState <= _GEN_36;
    end else begin
      cpuState <= _GEN_38;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  inReg = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  outReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  instrStepReg = _RAND_2[8:0];
  _RAND_3 = {1{`RANDOM}};
  cpuState = _RAND_3[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ChiselTop(
  input        clock,
  input        reset,
  input  [7:0] io_ui_in,
  output [7:0] io_uo_out,
  input  [7:0] io_uio_in,
  output [7:0] io_uio_out,
  output [7:0] io_uio_oe
);
  wire  tappu_clock; // @[ChiselTop.scala 28:21]
  wire  tappu_reset; // @[ChiselTop.scala 28:21]
  wire [7:0] tappu_io_in; // @[ChiselTop.scala 28:21]
  wire [7:0] tappu_io_out; // @[ChiselTop.scala 28:21]
  Tappu tappu ( // @[ChiselTop.scala 28:21]
    .clock(tappu_clock),
    .reset(tappu_reset),
    .io_in(tappu_io_in),
    .io_out(tappu_io_out)
  );
  assign io_uo_out = tappu_io_out; // @[ChiselTop.scala 30:13]
  assign io_uio_out = 8'h0; // @[ChiselTop.scala 18:14]
  assign io_uio_oe = 8'h0; // @[ChiselTop.scala 20:13]
  assign tappu_clock = clock;
  assign tappu_reset = reset;
  assign tappu_io_in = io_ui_in; // @[ChiselTop.scala 29:15]
endmodule
