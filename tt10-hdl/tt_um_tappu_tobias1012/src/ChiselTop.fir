circuit ChiselTop :
  module TapeVecMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip dataShift : UInt<9>, flip wrMode : UInt<2>, flip wrData : UInt<8>, outData : UInt<8>, flip instrStep : UInt<9>, instr : UInt<16>, counter : UInt<16>}

    wire program : UInt<8>[42] @[TapeVecMemory.scala 15:24]
    program[0] <= UInt<6>("h20") @[TapeVecMemory.scala 15:24]
    program[1] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[2] <= UInt<7>("h70") @[TapeVecMemory.scala 15:24]
    program[3] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[4] <= UInt<1>("h0") @[TapeVecMemory.scala 15:24]
    program[5] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[6] <= UInt<6>("h20") @[TapeVecMemory.scala 15:24]
    program[7] <= UInt<8>("hff") @[TapeVecMemory.scala 15:24]
    program[8] <= UInt<7>("h50") @[TapeVecMemory.scala 15:24]
    program[9] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[10] <= UInt<1>("h0") @[TapeVecMemory.scala 15:24]
    program[11] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[12] <= UInt<6>("h20") @[TapeVecMemory.scala 15:24]
    program[13] <= UInt<5>("h10") @[TapeVecMemory.scala 15:24]
    program[14] <= UInt<7>("h70") @[TapeVecMemory.scala 15:24]
    program[15] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[16] <= UInt<6>("h30") @[TapeVecMemory.scala 15:24]
    program[17] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[18] <= UInt<8>("h80") @[TapeVecMemory.scala 15:24]
    program[19] <= UInt<2>("h2") @[TapeVecMemory.scala 15:24]
    program[20] <= UInt<5>("h10") @[TapeVecMemory.scala 15:24]
    program[21] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[22] <= UInt<6>("h30") @[TapeVecMemory.scala 15:24]
    program[23] <= UInt<8>("hff") @[TapeVecMemory.scala 15:24]
    program[24] <= UInt<7>("h50") @[TapeVecMemory.scala 15:24]
    program[25] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[26] <= UInt<1>("h0") @[TapeVecMemory.scala 15:24]
    program[27] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[28] <= UInt<6>("h20") @[TapeVecMemory.scala 15:24]
    program[29] <= UInt<5>("h10") @[TapeVecMemory.scala 15:24]
    program[30] <= UInt<7>("h70") @[TapeVecMemory.scala 15:24]
    program[31] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[32] <= UInt<6>("h30") @[TapeVecMemory.scala 15:24]
    program[33] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[34] <= UInt<8>("h80") @[TapeVecMemory.scala 15:24]
    program[35] <= UInt<2>("h2") @[TapeVecMemory.scala 15:24]
    program[36] <= UInt<5>("h10") @[TapeVecMemory.scala 15:24]
    program[37] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[38] <= UInt<5>("h10") @[TapeVecMemory.scala 15:24]
    program[39] <= UInt<1>("h1") @[TapeVecMemory.scala 15:24]
    program[40] <= UInt<8>("h80") @[TapeVecMemory.scala 15:24]
    program[41] <= UInt<5>("h13") @[TapeVecMemory.scala 15:24]
    smem tape : UInt<8> [3] @[TapeVecMemory.scala 16:25]
    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[TapeVecMemory.scala 19:22]
    reg tapeCounterReg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[TapeVecMemory.scala 20:31]
    reg pc : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[TapeVecMemory.scala 21:19]
    io.counter <= tapeCounterReg @[TapeVecMemory.scala 23:14]
    io.instr <= UInt<1>("h0") @[TapeVecMemory.scala 24:12]
    io.outData <= UInt<1>("h0") @[TapeVecMemory.scala 25:14]
    node _T = eq(UInt<1>("h0"), state) @[TapeVecMemory.scala 27:17]
    when _T : @[TapeVecMemory.scala 27:17]
      node _T_1 = neq(tapeCounterReg, UInt<2>("h3")) @[TapeVecMemory.scala 29:27]
      when _T_1 : @[TapeVecMemory.scala 29:39]
        node _T_2 = bits(tapeCounterReg, 1, 0)
        write mport MPORT = tape[_T_2], clock
        MPORT <= UInt<1>("h0")
        node _tapeCounterReg_T = add(tapeCounterReg, UInt<1>("h1")) @[TapeVecMemory.scala 32:42]
        node _tapeCounterReg_T_1 = tail(_tapeCounterReg_T, 1) @[TapeVecMemory.scala 32:42]
        tapeCounterReg <= _tapeCounterReg_T_1 @[TapeVecMemory.scala 32:24]
      else :
        tapeCounterReg <= UInt<1>("h0") @[TapeVecMemory.scala 34:24]
        state <= UInt<1>("h1") @[TapeVecMemory.scala 35:15]
    else :
      node _T_3 = eq(UInt<1>("h1"), state) @[TapeVecMemory.scala 27:17]
      when _T_3 : @[TapeVecMemory.scala 27:17]
        node _T_4 = neq(io.dataShift, UInt<1>("h0")) @[TapeVecMemory.scala 40:25]
        when _T_4 : @[TapeVecMemory.scala 40:34]
          node _T_5 = bits(io.dataShift, 8, 8) @[TapeVecMemory.scala 41:26]
          node _T_6 = eq(_T_5, UInt<1>("h0")) @[TapeVecMemory.scala 41:30]
          when _T_6 : @[TapeVecMemory.scala 41:39]
            node _tapeCounterReg_T_2 = bits(io.dataShift, 7, 0) @[TapeVecMemory.scala 42:62]
            node _tapeCounterReg_T_3 = add(tapeCounterReg, _tapeCounterReg_T_2) @[TapeVecMemory.scala 42:48]
            node _tapeCounterReg_T_4 = tail(_tapeCounterReg_T_3, 1) @[TapeVecMemory.scala 42:48]
            node _tapeCounterReg_T_5 = geq(_tapeCounterReg_T_4, UInt<2>("h3")) @[TapeVecMemory.scala 42:69]
            node _tapeCounterReg_T_6 = bits(io.dataShift, 7, 0) @[TapeVecMemory.scala 42:122]
            node _tapeCounterReg_T_7 = add(tapeCounterReg, _tapeCounterReg_T_6) @[TapeVecMemory.scala 42:108]
            node _tapeCounterReg_T_8 = tail(_tapeCounterReg_T_7, 1) @[TapeVecMemory.scala 42:108]
            node _tapeCounterReg_T_9 = mux(_tapeCounterReg_T_5, UInt<2>("h2"), _tapeCounterReg_T_8) @[TapeVecMemory.scala 42:32]
            tapeCounterReg <= _tapeCounterReg_T_9 @[TapeVecMemory.scala 42:26]
          else :
            node _tapeCounterReg_T_10 = bits(io.dataShift, 7, 0) @[TapeVecMemory.scala 45:45]
            node _tapeCounterReg_T_11 = geq(_tapeCounterReg_T_10, tapeCounterReg) @[TapeVecMemory.scala 45:52]
            node _tapeCounterReg_T_12 = bits(io.dataShift, 7, 0) @[TapeVecMemory.scala 45:103]
            node _tapeCounterReg_T_13 = sub(tapeCounterReg, _tapeCounterReg_T_12) @[TapeVecMemory.scala 45:89]
            node _tapeCounterReg_T_14 = tail(_tapeCounterReg_T_13, 1) @[TapeVecMemory.scala 45:89]
            node _tapeCounterReg_T_15 = mux(_tapeCounterReg_T_11, UInt<1>("h0"), _tapeCounterReg_T_14) @[TapeVecMemory.scala 45:32]
            tapeCounterReg <= _tapeCounterReg_T_15 @[TapeVecMemory.scala 45:26]
        wire _readData_WIRE : UInt @[TapeVecMemory.scala 48:31]
        _readData_WIRE is invalid @[TapeVecMemory.scala 48:31]
        when UInt<1>("h1") : @[TapeVecMemory.scala 48:31]
          _readData_WIRE <= tapeCounterReg @[TapeVecMemory.scala 48:31]
          node _readData_T = or(_readData_WIRE, UInt<2>("h0")) @[TapeVecMemory.scala 48:31]
          node _readData_T_1 = bits(_readData_T, 1, 0) @[TapeVecMemory.scala 48:31]
          read mport readData = tape[_readData_T_1], clock @[TapeVecMemory.scala 48:31]
        node _T_7 = neq(io.wrMode, UInt<1>("h0")) @[TapeVecMemory.scala 49:22]
        when _T_7 : @[TapeVecMemory.scala 49:39]
          node _T_8 = eq(io.wrMode, UInt<1>("h1")) @[TapeVecMemory.scala 50:24]
          when _T_8 : @[TapeVecMemory.scala 50:41]
            node _T_9 = add(readData, io.wrData) @[TapeVecMemory.scala 51:50]
            node _T_10 = tail(_T_9, 1) @[TapeVecMemory.scala 51:50]
            node _T_11 = gt(_T_10, UInt<8>("hff")) @[TapeVecMemory.scala 51:62]
            node _T_12 = add(readData, io.wrData) @[TapeVecMemory.scala 51:87]
            node _T_13 = tail(_T_12, 1) @[TapeVecMemory.scala 51:87]
            node _T_14 = mux(_T_11, UInt<8>("hff"), _T_13) @[TapeVecMemory.scala 51:40]
            node _T_15 = bits(tapeCounterReg, 1, 0)
            write mport MPORT_1 = tape[_T_15], clock
            MPORT_1 <= _T_14
          else :
            node _T_16 = eq(io.wrMode, UInt<2>("h2")) @[TapeVecMemory.scala 52:30]
            when _T_16 : @[TapeVecMemory.scala 52:48]
              node _T_17 = lt(readData, io.wrData) @[TapeVecMemory.scala 53:51]
              node _T_18 = sub(readData, io.wrData) @[TapeVecMemory.scala 53:78]
              node _T_19 = tail(_T_18, 1) @[TapeVecMemory.scala 53:78]
              node _T_20 = mux(_T_17, UInt<1>("h0"), _T_19) @[TapeVecMemory.scala 53:41]
              node _T_21 = bits(tapeCounterReg, 1, 0)
              write mport MPORT_2 = tape[_T_21], clock
              MPORT_2 <= _T_20
            else :
              node _T_22 = eq(io.wrMode, UInt<2>("h3")) @[TapeVecMemory.scala 54:30]
              when _T_22 : @[TapeVecMemory.scala 54:46]
                node _T_23 = bits(tapeCounterReg, 1, 0)
                write mport MPORT_3 = tape[_T_23], clock
                MPORT_3 <= io.wrData
        node _instrHigh_T = add(pc, UInt<1>("h1")) @[TapeVecMemory.scala 60:34]
        node _instrHigh_T_1 = tail(_instrHigh_T, 1) @[TapeVecMemory.scala 60:34]
        node _io_instr_T = cat(program[_instrHigh_T_1], program[pc]) @[Cat.scala 33:92]
        io.instr <= _io_instr_T @[TapeVecMemory.scala 61:16]
        io.outData <= readData @[TapeVecMemory.scala 62:18]
        node _T_24 = bits(io.instrStep, 8, 8) @[TapeVecMemory.scala 64:24]
        node _T_25 = eq(_T_24, UInt<1>("h1")) @[TapeVecMemory.scala 64:28]
        when _T_25 : @[TapeVecMemory.scala 64:42]
          node _T_26 = bits(io.instrStep, 7, 0) @[TapeVecMemory.scala 65:26]
          node _T_27 = eq(_T_26, UInt<1>("h0")) @[TapeVecMemory.scala 65:33]
          when _T_27 : @[TapeVecMemory.scala 65:42]
            node _pc_T = add(pc, UInt<2>("h2")) @[TapeVecMemory.scala 66:20]
            node _pc_T_1 = tail(_pc_T, 1) @[TapeVecMemory.scala 66:20]
            pc <= _pc_T_1 @[TapeVecMemory.scala 66:14]
          else :
            node _pc_T_2 = bits(io.instrStep, 7, 0) @[TapeVecMemory.scala 68:35]
            node _pc_T_3 = shl(_pc_T_2, 1) @[TapeVecMemory.scala 68:42]
            node _pc_T_4 = sub(pc, _pc_T_3) @[TapeVecMemory.scala 68:20]
            node _pc_T_5 = tail(_pc_T_4, 1) @[TapeVecMemory.scala 68:20]
            pc <= _pc_T_5 @[TapeVecMemory.scala 68:14]


  module Tappu :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<8>, out : UInt<8>}

    reg inReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Tappu.scala 35:22]
    inReg <= io.in @[Tappu.scala 36:9]
    reg outReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Tappu.scala 38:23]
    io.out <= outReg @[Tappu.scala 39:10]
    inst mem of TapeVecMemory @[Tappu.scala 42:11]
    mem.clock <= clock
    mem.reset <= reset
    wire instrStep : UInt<9> @[Tappu.scala 47:30]
    instrStep <= UInt<9>("h0") @[Tappu.scala 47:30]
    wire instr : UInt<16> @[Tappu.scala 48:19]
    wire wrMode : UInt<2> @[Tappu.scala 49:27]
    wrMode <= UInt<1>("h0") @[Tappu.scala 49:27]
    wire wrData : UInt<9> @[Tappu.scala 50:20]
    wire dataShift : UInt<9> @[Tappu.scala 51:23]
    reg instrStepReg : UInt<9>, clock with :
      reset => (reset, UInt<9>("h100")) @[Tappu.scala 53:29]
    mem.io.instrStep <= instrStep @[Tappu.scala 56:20]
    instr <= mem.io.instr @[Tappu.scala 57:9]
    mem.io.wrMode <= wrMode @[Tappu.scala 59:17]
    mem.io.wrData <= wrData @[Tappu.scala 60:17]
    mem.io.dataShift <= dataShift @[Tappu.scala 61:20]
    wrMode <= UInt<1>("h0") @[Tappu.scala 72:10]
    wrData <= UInt<1>("h0") @[Tappu.scala 73:10]
    dataShift <= UInt<1>("h0") @[Tappu.scala 74:13]
    instrStepReg <= UInt<9>("h100") @[Tappu.scala 75:16]
    reg cpuState : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Tappu.scala 78:25]
    node _T = eq(UInt<3>("h0"), cpuState) @[Tappu.scala 80:20]
    when _T : @[Tappu.scala 80:20]
      instrStep <= instrStepReg @[Tappu.scala 82:17]
      cpuState <= UInt<3>("h1") @[Tappu.scala 83:16]
    else :
      node _T_1 = eq(UInt<3>("h1"), cpuState) @[Tappu.scala 80:20]
      when _T_1 : @[Tappu.scala 80:20]
        cpuState <= UInt<3>("h2") @[Tappu.scala 86:16]
      else :
        node _T_2 = eq(UInt<3>("h2"), cpuState) @[Tappu.scala 80:20]
        when _T_2 : @[Tappu.scala 80:20]
          cpuState <= UInt<3>("h3") @[Tappu.scala 89:16]
          node _T_3 = bits(instr, 7, 0) @[Tappu.scala 90:19]
          node _T_4 = eq(UInt<7>("h60"), _T_3) @[Tappu.scala 90:26]
          when _T_4 : @[Tappu.scala 90:26]
            wrMode <= UInt<2>("h3") @[Tappu.scala 93:18]
            wrData <= inReg @[Tappu.scala 94:18]
          else :
            node _T_5 = eq(UInt<7>("h50"), _T_3) @[Tappu.scala 90:26]
            when _T_5 : @[Tappu.scala 90:26]
              outReg <= mem.io.outData @[Tappu.scala 97:18]
            else :
              node _T_6 = eq(UInt<5>("h10"), _T_3) @[Tappu.scala 90:26]
              when _T_6 : @[Tappu.scala 90:26]
                node _dataShift_T = bits(instr, 15, 8) @[Tappu.scala 100:43]
                node _dataShift_T_1 = cat(UInt<1>("h1"), _dataShift_T) @[Cat.scala 33:92]
                dataShift <= _dataShift_T_1 @[Tappu.scala 100:21]
              else :
                node _T_7 = eq(UInt<1>("h0"), _T_3) @[Tappu.scala 90:26]
                when _T_7 : @[Tappu.scala 90:26]
                  node _dataShift_T_2 = bits(instr, 15, 8) @[Tappu.scala 103:43]
                  node _dataShift_T_3 = cat(UInt<1>("h0"), _dataShift_T_2) @[Cat.scala 33:92]
                  dataShift <= _dataShift_T_3 @[Tappu.scala 103:21]
                else :
                  node _T_8 = eq(UInt<6>("h20"), _T_3) @[Tappu.scala 90:26]
                  when _T_8 : @[Tappu.scala 90:26]
                    wrMode <= UInt<1>("h1") @[Tappu.scala 106:18]
                    node _wrData_T = bits(instr, 15, 8) @[Tappu.scala 107:26]
                    wrData <= _wrData_T @[Tappu.scala 107:18]
                  else :
                    node _T_9 = eq(UInt<6>("h30"), _T_3) @[Tappu.scala 90:26]
                    when _T_9 : @[Tappu.scala 90:26]
                      wrMode <= UInt<2>("h2") @[Tappu.scala 110:18]
                      node _wrData_T_1 = bits(instr, 15, 8) @[Tappu.scala 111:26]
                      wrData <= _wrData_T_1 @[Tappu.scala 111:18]
                    else :
                      node _T_10 = eq(UInt<7>("h70"), _T_3) @[Tappu.scala 90:26]
                      when _T_10 : @[Tappu.scala 90:26]
                        skip
                      else :
                        node _T_11 = eq(UInt<8>("h80"), _T_3) @[Tappu.scala 90:26]
                        when _T_11 : @[Tappu.scala 90:26]
                          node _T_12 = eq(mem.io.outData, UInt<1>("h0")) @[Tappu.scala 117:34]
                          node _T_13 = eq(_T_12, UInt<1>("h0")) @[Tappu.scala 117:17]
                          when _T_13 : @[Tappu.scala 117:44]
                            node _instrStepReg_T = bits(instr, 15, 8) @[Tappu.scala 118:48]
                            node _instrStepReg_T_1 = cat(UInt<1>("h1"), _instrStepReg_T) @[Cat.scala 33:92]
                            instrStepReg <= _instrStepReg_T_1 @[Tappu.scala 118:26]
                            cpuState <= UInt<3>("h0") @[Tappu.scala 119:22]
                        else :
                          node _T_14 = eq(UInt<8>("hff"), _T_3) @[Tappu.scala 90:26]
                          when _T_14 : @[Tappu.scala 90:26]
                            cpuState <= UInt<3>("h5") @[Tappu.scala 126:20]
        else :
          node _T_15 = eq(UInt<3>("h3"), cpuState) @[Tappu.scala 80:20]
          when _T_15 : @[Tappu.scala 80:20]
            cpuState <= UInt<3>("h4") @[Tappu.scala 133:16]
          else :
            node _T_16 = eq(UInt<3>("h4"), cpuState) @[Tappu.scala 80:20]
            when _T_16 : @[Tappu.scala 80:20]
              cpuState <= UInt<3>("h0") @[Tappu.scala 137:16]
            else :
              node _T_17 = eq(UInt<3>("h5"), cpuState) @[Tappu.scala 80:20]
              when _T_17 : @[Tappu.scala 80:20]
                skip
    io.out <= outReg @[Tappu.scala 144:10]

  module ChiselTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip ui_in : UInt<8>, uo_out : UInt<8>, flip uio_in : UInt<8>, uio_out : UInt<8>, uio_oe : UInt<8>}

    io.uio_out <= UInt<1>("h0") @[ChiselTop.scala 18:14]
    io.uio_oe <= UInt<1>("h0") @[ChiselTop.scala 20:13]
    wire add : UInt<7> @[ChiselTop.scala 22:24]
    add <= UInt<7>("h0") @[ChiselTop.scala 22:24]
    node _add_T = add(io.ui_in, io.uio_in) @[ChiselTop.scala 23:19]
    node _add_T_1 = tail(_add_T, 1) @[ChiselTop.scala 23:19]
    add <= _add_T_1 @[ChiselTop.scala 23:7]
    inst tappu of Tappu @[ChiselTop.scala 28:21]
    tappu.clock <= clock
    tappu.reset <= reset
    tappu.io.in <= io.ui_in @[ChiselTop.scala 29:15]
    io.uo_out <= tappu.io.out @[ChiselTop.scala 30:13]

