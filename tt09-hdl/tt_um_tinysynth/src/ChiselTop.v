module PulseWidthModulator(
  input        clock,
  input        reset,
  output       io_out,
  input  [7:0] io_dutyCycle
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] counter; // @[PulseWidthModulator.scala 9:24]
  wire [7:0] _counter_T_1 = counter + 8'h1; // @[PulseWidthModulator.scala 10:22]
  assign io_out = counter < io_dutyCycle; // @[PulseWidthModulator.scala 11:16]
  always @(posedge clock) begin
    if (reset) begin // @[PulseWidthModulator.scala 9:24]
      counter <= 8'h0; // @[PulseWidthModulator.scala 9:24]
    end else begin
      counter <= _counter_T_1; // @[PulseWidthModulator.scala 10:11]
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
  counter = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Merge(
  input  [7:0] io_wavesIn_0,
  output [7:0] io_wavesOut
);
  assign io_wavesOut = io_wavesIn_0; // @[Filter.scala 10:15]
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[Uart.scala 76:30]
  reg  rxReg; // @[Uart.scala 76:22]
  reg  falling_REG; // @[Uart.scala 77:35]
  wire  falling = ~rxReg & falling_REG; // @[Uart.scala 77:24]
  reg [7:0] shiftReg; // @[Uart.scala 79:25]
  reg [19:0] cntReg; // @[Uart.scala 80:23]
  reg [3:0] bitsReg; // @[Uart.scala 81:24]
  reg  valReg; // @[Uart.scala 82:23]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 85:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 89:24]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[Uart.scala 91:27 92:14 82:23]
  assign io_channel_valid = valReg; // @[Uart.scala 104:20]
  assign io_channel_bits = shiftReg; // @[Uart.scala 103:19]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 76:30]
      rxReg_REG <= 1'h0; // @[Uart.scala 76:30]
    end else begin
      rxReg_REG <= io_rxd; // @[Uart.scala 76:30]
    end
    if (reset) begin // @[Uart.scala 76:22]
      rxReg <= 1'h0; // @[Uart.scala 76:22]
    end else begin
      rxReg <= rxReg_REG; // @[Uart.scala 76:22]
    end
    falling_REG <= rxReg; // @[Uart.scala 77:35]
    if (reset) begin // @[Uart.scala 79:25]
      shiftReg <= 8'h0; // @[Uart.scala 79:25]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 84:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 86:31]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 88:14]
      end
    end
    if (reset) begin // @[Uart.scala 80:23]
      cntReg <= 20'h1b1; // @[Uart.scala 80:23]
    end else if (cntReg != 20'h0) begin // @[Uart.scala 84:24]
      cntReg <= _cntReg_T_1; // @[Uart.scala 85:12]
    end else if (bitsReg != 4'h0) begin // @[Uart.scala 86:31]
      cntReg <= 20'h1b1; // @[Uart.scala 87:12]
    end else if (falling) begin // @[Uart.scala 94:23]
      cntReg <= 20'h289; // @[Uart.scala 95:12]
    end
    if (reset) begin // @[Uart.scala 81:24]
      bitsReg <= 4'h0; // @[Uart.scala 81:24]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 84:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 86:31]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 89:13]
      end else if (falling) begin // @[Uart.scala 94:23]
        bitsReg <= 4'h8; // @[Uart.scala 96:13]
      end
    end
    if (reset) begin // @[Uart.scala 82:23]
      valReg <= 1'h0; // @[Uart.scala 82:23]
    end else if (valReg & io_channel_ready) begin // @[Uart.scala 99:36]
      valReg <= 1'h0; // @[Uart.scala 100:12]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 84:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 86:31]
        valReg <= _GEN_0;
      end
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
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  falling_REG = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  shiftReg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  cntReg = _RAND_4[19:0];
  _RAND_5 = {1{`RANDOM}};
  bitsReg = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  valReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UART(
  input        clock,
  input        reset,
  input        io_in,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
  wire  rx_clock; // @[UART.scala 11:18]
  wire  rx_reset; // @[UART.scala 11:18]
  wire  rx_io_rxd; // @[UART.scala 11:18]
  wire  rx_io_channel_ready; // @[UART.scala 11:18]
  wire  rx_io_channel_valid; // @[UART.scala 11:18]
  wire [7:0] rx_io_channel_bits; // @[UART.scala 11:18]
  Rx rx ( // @[UART.scala 11:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_channel_ready(rx_io_channel_ready),
    .io_channel_valid(rx_io_channel_valid),
    .io_channel_bits(rx_io_channel_bits)
  );
  assign io_out_valid = rx_io_channel_valid; // @[UART.scala 14:10]
  assign io_out_bits = rx_io_channel_bits; // @[UART.scala 14:10]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = io_in; // @[UART.scala 12:{30,30}]
  assign rx_io_channel_ready = io_out_ready; // @[UART.scala 14:10]
endmodule
module MIDI(
  input        clock,
  input        reset,
  output       io_uartIn_ready,
  input        io_uartIn_valid,
  input  [7:0] io_uartIn_bits,
  output       io_midiOut_valid,
  output [3:0] io_midiOut_bits_hdr_channel,
  output [7:0] io_midiOut_bits_note
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[MIDI.scala 28:25]
  reg [3:0] regOutput_hdr_channel; // @[MIDI.scala 29:26]
  reg [7:0] regOutput_note; // @[MIDI.scala 29:26]
  wire  _T_1 = io_uartIn_ready & io_uartIn_valid; // @[Decoupled.scala 51:35]
  wire [3:0] hdr_msgType = io_uartIn_bits[3:0]; // @[MIDI.scala 38:42]
  wire [3:0] hdr_channel = io_uartIn_bits[7:4]; // @[MIDI.scala 38:42]
  wire [7:0] _GEN_0 = ~hdr_msgType[3] ? io_uartIn_bits : regOutput_note; // @[MIDI.scala 29:26 42:44 45:26]
  wire [1:0] _GEN_1 = ~hdr_msgType[3] ? 2'h2 : regState; // @[MIDI.scala 42:44 46:20 28:25]
  wire [1:0] _GEN_13 = _T_1 ? 2'h3 : regState; // @[MIDI.scala 59:29 61:18 28:25]
  wire [1:0] _GEN_15 = 2'h3 == regState ? 2'h0 : regState; // @[MIDI.scala 34:20 66:16 28:25]
  wire  _GEN_19 = 2'h2 == regState ? 1'h0 : 2'h3 == regState; // @[MIDI.scala 32:20 34:20]
  wire  _GEN_20 = 2'h1 == regState | 2'h2 == regState; // @[MIDI.scala 34:20 51:23]
  wire  _GEN_24 = 2'h1 == regState ? 1'h0 : _GEN_19; // @[MIDI.scala 32:20 34:20]
  assign io_uartIn_ready = 2'h0 == regState | _GEN_20; // @[MIDI.scala 34:20 36:23]
  assign io_midiOut_valid = 2'h0 == regState ? 1'h0 : _GEN_24; // @[MIDI.scala 32:20 34:20]
  assign io_midiOut_bits_hdr_channel = regOutput_hdr_channel; // @[MIDI.scala 31:19]
  assign io_midiOut_bits_note = regOutput_note; // @[MIDI.scala 31:19]
  always @(posedge clock) begin
    if (reset) begin // @[MIDI.scala 28:25]
      regState <= 2'h0; // @[MIDI.scala 28:25]
    end else if (2'h0 == regState) begin // @[MIDI.scala 34:20]
      if (_T_1) begin // @[MIDI.scala 37:28]
        if (hdr_msgType == 4'h9 | hdr_msgType == 4'h8) begin // @[MIDI.scala 39:77]
          regState <= 2'h1; // @[MIDI.scala 41:20]
        end else begin
          regState <= _GEN_1;
        end
      end
    end else if (2'h1 == regState) begin // @[MIDI.scala 34:20]
      if (_T_1) begin // @[MIDI.scala 52:29]
        regState <= 2'h2; // @[MIDI.scala 54:18]
      end
    end else if (2'h2 == regState) begin // @[MIDI.scala 34:20]
      regState <= _GEN_13;
    end else begin
      regState <= _GEN_15;
    end
    if (reset) begin // @[MIDI.scala 29:26]
      regOutput_hdr_channel <= 4'h0; // @[MIDI.scala 29:26]
    end else if (2'h0 == regState) begin // @[MIDI.scala 34:20]
      if (_T_1) begin // @[MIDI.scala 37:28]
        if (hdr_msgType == 4'h9 | hdr_msgType == 4'h8) begin // @[MIDI.scala 39:77]
          regOutput_hdr_channel <= hdr_channel; // @[MIDI.scala 40:25]
        end
      end
    end
    if (reset) begin // @[MIDI.scala 29:26]
      regOutput_note <= 8'h0; // @[MIDI.scala 29:26]
    end else if (2'h0 == regState) begin // @[MIDI.scala 34:20]
      if (_T_1) begin // @[MIDI.scala 37:28]
        if (!(hdr_msgType == 4'h9 | hdr_msgType == 4'h8)) begin // @[MIDI.scala 39:77]
          regOutput_note <= _GEN_0;
        end
      end
    end else if (2'h1 == regState) begin // @[MIDI.scala 34:20]
      if (_T_1) begin // @[MIDI.scala 52:29]
        regOutput_note <= io_uartIn_bits; // @[MIDI.scala 53:24]
      end
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
  regState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  regOutput_hdr_channel = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  regOutput_note = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ChannelController(
  input         io_midiIn_valid,
  input  [7:0]  io_midiIn_bits_note,
  output [31:0] io_period
);
  wire [21:0] _GEN_10 = 7'ha == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : 22'h377c8b; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_11 = 7'hb == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_10; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_12 = 7'hc == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_11; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_13 = 7'hd == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_12; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_14 = 7'he == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_13; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_15 = 7'hf == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_14; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_16 = 7'h10 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_15; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_17 = 7'h11 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_16; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_18 = 7'h12 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_17; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_19 = 7'h13 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_18; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_20 = 7'h14 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_19; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_21 = 7'h15 == io_midiIn_bits_note[6:0] ? 22'h1bbe45 : _GEN_20; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_22 = 7'h16 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_21; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_23 = 7'h17 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_22; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_24 = 7'h18 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_23; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_25 = 7'h19 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_24; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_26 = 7'h1a == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_25; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_27 = 7'h1b == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_26; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_28 = 7'h1c == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_27; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_29 = 7'h1d == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_28; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_30 = 7'h1e == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_29; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_31 = 7'h1f == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_30; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_32 = 7'h20 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_31; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_33 = 7'h21 == io_midiIn_bits_note[6:0] ? 22'hddf22 : _GEN_32; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_34 = 7'h22 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_33; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_35 = 7'h23 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_34; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_36 = 7'h24 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_35; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_37 = 7'h25 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_36; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_38 = 7'h26 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_37; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_39 = 7'h27 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_38; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_40 = 7'h28 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_39; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_41 = 7'h29 == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_40; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_42 = 7'h2a == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_41; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_43 = 7'h2b == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_42; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_44 = 7'h2c == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_43; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_45 = 7'h2d == io_midiIn_bits_note[6:0] ? 22'h6ef91 : _GEN_44; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_46 = 7'h2e == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_45; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_47 = 7'h2f == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_46; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_48 = 7'h30 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_47; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_49 = 7'h31 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_48; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_50 = 7'h32 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_49; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_51 = 7'h33 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_50; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_52 = 7'h34 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_51; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_53 = 7'h35 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_52; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_54 = 7'h36 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_53; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_55 = 7'h37 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_54; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_56 = 7'h38 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_55; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_57 = 7'h39 == io_midiIn_bits_note[6:0] ? 22'h377c8 : _GEN_56; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_58 = 7'h3a == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_57; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_59 = 7'h3b == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_58; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_60 = 7'h3c == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_59; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_61 = 7'h3d == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_60; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_62 = 7'h3e == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_61; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_63 = 7'h3f == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_62; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_64 = 7'h40 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_63; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_65 = 7'h41 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_64; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_66 = 7'h42 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_65; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_67 = 7'h43 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_66; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_68 = 7'h44 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_67; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_69 = 7'h45 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_68; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_70 = 7'h46 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_69; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_71 = 7'h47 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_70; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_72 = 7'h48 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_71; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_73 = 7'h49 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_72; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_74 = 7'h4a == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_73; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_75 = 7'h4b == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_74; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_76 = 7'h4c == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_75; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_77 = 7'h4d == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_76; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_78 = 7'h4e == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_77; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_79 = 7'h4f == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_78; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_80 = 7'h50 == io_midiIn_bits_note[6:0] ? 22'h1bbe4 : _GEN_79; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_81 = 7'h51 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_80; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_82 = 7'h52 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_81; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_83 = 7'h53 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_82; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_84 = 7'h54 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_83; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_85 = 7'h55 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_84; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_86 = 7'h56 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_85; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_87 = 7'h57 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_86; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_88 = 7'h58 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_87; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_89 = 7'h59 == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_88; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_90 = 7'h5a == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_89; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_91 = 7'h5b == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_90; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_92 = 7'h5c == io_midiIn_bits_note[6:0] ? 22'hddf2 : _GEN_91; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_93 = 7'h5d == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_92; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_94 = 7'h5e == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_93; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_95 = 7'h5f == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_94; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_96 = 7'h60 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_95; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_97 = 7'h61 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_96; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_98 = 7'h62 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_97; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_99 = 7'h63 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_98; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_100 = 7'h64 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_99; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_101 = 7'h65 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_100; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_102 = 7'h66 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_101; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_103 = 7'h67 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_102; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_104 = 7'h68 == io_midiIn_bits_note[6:0] ? 22'h6ef9 : _GEN_103; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_105 = 7'h69 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_104; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_106 = 7'h6a == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_105; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_107 = 7'h6b == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_106; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_108 = 7'h6c == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_107; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_109 = 7'h6d == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_108; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_110 = 7'h6e == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_109; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_111 = 7'h6f == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_110; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_112 = 7'h70 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_111; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_113 = 7'h71 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_112; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_114 = 7'h72 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_113; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_115 = 7'h73 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_114; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_116 = 7'h74 == io_midiIn_bits_note[6:0] ? 22'h377c : _GEN_115; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_117 = 7'h75 == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_116; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_118 = 7'h76 == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_117; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_119 = 7'h77 == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_118; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_120 = 7'h78 == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_119; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_121 = 7'h79 == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_120; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_122 = 7'h7a == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_121; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_123 = 7'h7b == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_122; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_124 = 7'h7c == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_123; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_125 = 7'h7d == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_124; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_126 = 7'h7e == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_125; // @[ChannelController.scala 32:{15,15}]
  wire [21:0] _GEN_127 = 7'h7f == io_midiIn_bits_note[6:0] ? 22'h1bbe : _GEN_126; // @[ChannelController.scala 32:{15,15}]
  assign io_period = io_midiIn_valid ? {{10'd0}, _GEN_127} : 32'h0; // @[ChannelController.scala 28:13 31:25 32:15]
endmodule
module SquareWaveOscillator(
  input         clock,
  input         reset,
  output [7:0]  io_wave,
  input  [31:0] io_period
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] cnt; // @[Oscillator.scala 31:20]
  wire [30:0] halfPeriod = io_period[31:1]; // @[Oscillator.scala 32:31]
  wire [31:0] _GEN_1 = {{1'd0}, halfPeriod}; // @[Oscillator.scala 33:18]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[Oscillator.scala 35:14]
  wire [31:0] _T_1 = io_period - 32'h1; // @[Oscillator.scala 36:28]
  assign io_wave = {{7'd0}, cnt < _GEN_1}; // @[Oscillator.scala 33:11]
  always @(posedge clock) begin
    if (reset) begin // @[Oscillator.scala 31:20]
      cnt <= 32'h0; // @[Oscillator.scala 31:20]
    end else if (cnt == _T_1) begin // @[Oscillator.scala 36:36]
      cnt <= 32'h0; // @[Oscillator.scala 37:9]
    end else begin
      cnt <= _cnt_T_1; // @[Oscillator.scala 35:7]
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
  cnt = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Oscillator(
  input         clock,
  input         reset,
  output [7:0]  io_wave,
  input  [31:0] io_period
);
  wire  square_clock; // @[Oscillator.scala 16:19]
  wire  square_reset; // @[Oscillator.scala 16:19]
  wire [7:0] square_io_wave; // @[Oscillator.scala 16:19]
  wire [31:0] square_io_period; // @[Oscillator.scala 16:19]
  SquareWaveOscillator square ( // @[Oscillator.scala 16:19]
    .clock(square_clock),
    .reset(square_reset),
    .io_wave(square_io_wave),
    .io_period(square_io_period)
  );
  assign io_wave = square_io_wave; // @[Oscillator.scala 22:11]
  assign square_clock = clock;
  assign square_reset = reset;
  assign square_io_period = io_period; // @[Oscillator.scala 17:17]
endmodule
module TinySynth(
  input   clock,
  input   reset,
  output  io_pwmOut,
  input   io_uartIn
);
  wire  pwm_clock; // @[TinySynth.scala 11:19]
  wire  pwm_reset; // @[TinySynth.scala 11:19]
  wire  pwm_io_out; // @[TinySynth.scala 11:19]
  wire [7:0] pwm_io_dutyCycle; // @[TinySynth.scala 11:19]
  wire [7:0] merge_io_wavesIn_0; // @[TinySynth.scala 12:21]
  wire [7:0] merge_io_wavesOut; // @[TinySynth.scala 12:21]
  wire  uart_clock; // @[TinySynth.scala 13:20]
  wire  uart_reset; // @[TinySynth.scala 13:20]
  wire  uart_io_in; // @[TinySynth.scala 13:20]
  wire  uart_io_out_ready; // @[TinySynth.scala 13:20]
  wire  uart_io_out_valid; // @[TinySynth.scala 13:20]
  wire [7:0] uart_io_out_bits; // @[TinySynth.scala 13:20]
  wire  midi_clock; // @[TinySynth.scala 14:20]
  wire  midi_reset; // @[TinySynth.scala 14:20]
  wire  midi_io_uartIn_ready; // @[TinySynth.scala 14:20]
  wire  midi_io_uartIn_valid; // @[TinySynth.scala 14:20]
  wire [7:0] midi_io_uartIn_bits; // @[TinySynth.scala 14:20]
  wire  midi_io_midiOut_valid; // @[TinySynth.scala 14:20]
  wire [3:0] midi_io_midiOut_bits_hdr_channel; // @[TinySynth.scala 14:20]
  wire [7:0] midi_io_midiOut_bits_note; // @[TinySynth.scala 14:20]
  wire  ui_io_midiIn_valid; // @[TinySynth.scala 21:20]
  wire [7:0] ui_io_midiIn_bits_note; // @[TinySynth.scala 21:20]
  wire [31:0] ui_io_period; // @[TinySynth.scala 21:20]
  wire  osc_clock; // @[TinySynth.scala 29:21]
  wire  osc_reset; // @[TinySynth.scala 29:21]
  wire [7:0] osc_io_wave; // @[TinySynth.scala 29:21]
  wire [31:0] osc_io_period; // @[TinySynth.scala 29:21]
  PulseWidthModulator pwm ( // @[TinySynth.scala 11:19]
    .clock(pwm_clock),
    .reset(pwm_reset),
    .io_out(pwm_io_out),
    .io_dutyCycle(pwm_io_dutyCycle)
  );
  Merge merge ( // @[TinySynth.scala 12:21]
    .io_wavesIn_0(merge_io_wavesIn_0),
    .io_wavesOut(merge_io_wavesOut)
  );
  UART uart ( // @[TinySynth.scala 13:20]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_in(uart_io_in),
    .io_out_ready(uart_io_out_ready),
    .io_out_valid(uart_io_out_valid),
    .io_out_bits(uart_io_out_bits)
  );
  MIDI midi ( // @[TinySynth.scala 14:20]
    .clock(midi_clock),
    .reset(midi_reset),
    .io_uartIn_ready(midi_io_uartIn_ready),
    .io_uartIn_valid(midi_io_uartIn_valid),
    .io_uartIn_bits(midi_io_uartIn_bits),
    .io_midiOut_valid(midi_io_midiOut_valid),
    .io_midiOut_bits_hdr_channel(midi_io_midiOut_bits_hdr_channel),
    .io_midiOut_bits_note(midi_io_midiOut_bits_note)
  );
  ChannelController ui ( // @[TinySynth.scala 21:20]
    .io_midiIn_valid(ui_io_midiIn_valid),
    .io_midiIn_bits_note(ui_io_midiIn_bits_note),
    .io_period(ui_io_period)
  );
  Oscillator osc ( // @[TinySynth.scala 29:21]
    .clock(osc_clock),
    .reset(osc_reset),
    .io_wave(osc_io_wave),
    .io_period(osc_io_period)
  );
  assign io_pwmOut = pwm_io_out; // @[TinySynth.scala 18:13]
  assign pwm_clock = clock;
  assign pwm_reset = reset;
  assign pwm_io_dutyCycle = merge_io_wavesOut; // @[TinySynth.scala 17:20]
  assign merge_io_wavesIn_0 = osc_io_wave; // @[TinySynth.scala 33:25]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_in = io_uartIn; // @[TinySynth.scala 15:14]
  assign uart_io_out_ready = midi_io_uartIn_ready; // @[TinySynth.scala 16:18]
  assign midi_clock = clock;
  assign midi_reset = reset;
  assign midi_io_uartIn_valid = uart_io_out_valid; // @[TinySynth.scala 16:18]
  assign midi_io_uartIn_bits = uart_io_out_bits; // @[TinySynth.scala 16:18]
  assign ui_io_midiIn_valid = midi_io_midiOut_valid & midi_io_midiOut_bits_hdr_channel == 4'h0 & midi_io_midiOut_valid; // @[TinySynth.scala 23:76 24:20 26:20]
  assign ui_io_midiIn_bits_note = midi_io_midiOut_valid & midi_io_midiOut_bits_hdr_channel == 4'h0 ?
    midi_io_midiOut_bits_note : 8'h0; // @[TinySynth.scala 23:76 24:20 26:20]
  assign osc_clock = clock;
  assign osc_reset = reset;
  assign osc_io_period = ui_io_period; // @[TinySynth.scala 31:19]
endmodule
module ChiselTop(
  input        clock,
  input        reset,
  input  [7:0] io_ui_in,
  output [7:0] io_uo_out,
  input  [7:0] io_uio_in,
  output [7:0] io_uio_out,
  output [7:0] io_uio_oe,
  input        io_ena
);
  wire  tinySynth_clock; // @[ChiselTop.scala 19:25]
  wire  tinySynth_reset; // @[ChiselTop.scala 19:25]
  wire  tinySynth_io_pwmOut; // @[ChiselTop.scala 19:25]
  wire  tinySynth_io_uartIn; // @[ChiselTop.scala 19:25]
  TinySynth tinySynth ( // @[ChiselTop.scala 19:25]
    .clock(tinySynth_clock),
    .reset(tinySynth_reset),
    .io_pwmOut(tinySynth_io_pwmOut),
    .io_uartIn(tinySynth_io_uartIn)
  );
  assign io_uo_out = {{7'd0}, tinySynth_io_pwmOut}; // @[ChiselTop.scala 21:13]
  assign io_uio_out = 8'h0; // @[ChiselTop.scala 27:14]
  assign io_uio_oe = 8'h0; // @[ChiselTop.scala 28:13]
  assign tinySynth_clock = clock;
  assign tinySynth_reset = reset;
  assign tinySynth_io_uartIn = io_ui_in[0]; // @[ChiselTop.scala 24:34]
endmodule
