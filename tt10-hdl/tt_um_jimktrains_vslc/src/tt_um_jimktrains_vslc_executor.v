/*
* Copyright (c) 2025 James Keener
* SPDX-License-Identifier: Apache-2.0
*/

`default_nettype none

module tt_um_jimktrains_vslc_executor (
  input clk,
  input [15:0]counter,
  input instr_ready,
  input rst_n,
  input [7:0] instr,
  input [7:0] ui_in,
  input [7:0] ui_in_prev,
  output [7:0] uo_out,
  output timer_enabled,
  output timer_output,
  output servo_output
);
  reg [4:0] timer_clk_div;
  reg [4:0] servo_clk_div;
  // These are used as clock strobes, and not as part of an always
  // block's sensitivities.
  wire timer_clk;
  assign timer_clk = timer_clk_div == 0 ? clk : counter[timer_clk_div-1];
  wire servo_clk;
  assign servo_clk = servo_clk_div == 0 ? clk : counter[servo_clk_div-1];

  // reg [7:0] timer_period_a;
  // reg [7:0] timer_period_b;

  reg [4:0] servo_set_val;
  wire servo_enabled;
  wire servo_val;

  localparam SFR_TIMER_ENABLE = 0;
  localparam SFR_TIMER_OUTPUT = 1;
  localparam SFR_SERVO_ENABLE = 2;
  localparam SFR_SERVO_VAL    = 3;
  localparam SFR_SERVO_OUTPUT = 4;

  reg [15:0] sfr;
  assign timer_enabled = sfr[SFR_TIMER_ENABLE];
  assign servo_enabled = sfr[SFR_SERVO_ENABLE];
  assign servo_val = sfr[SFR_SERVO_VAL];

  tt_um_jimktrains_vslc_timer tim0(
    clk,
    timer_clk,
    rst_n,
    timer_period_a,
    timer_period_a,
    timer_enabled,
    timer_output
  );

  tt_um_jimktrains_vslc_servo srv0(
    clk,
    servo_clk,
    rst_n,
    servo_set_val,
    servo_reset_val,
    servo_freq_val,
    servo_enabled,
    servo_val,
    servo_output
  );


  localparam STACK_DEPTH = 15;
  reg [(STACK_DEPTH-1):0]stack;
  reg [7:0]uo_out_reg;
  assign uo_out = uo_out_reg;
  wire tos = stack[0];
  wire nos = stack[1];
  wire hos = stack[2];

  wire instr_reg = instr[7] == 0;
  wire instr_reg_b = instr[7:6] == 1;
  // wire instr_reg_a = instr[7:6] == 0;
  wire instr_logic = instr[7:6] == 2;
  wire instr_other = instr[7:6] == 3;

  wire [2:0]regid = exec_state == EXEC_STATE_INSTR ? instr[2:0] : prev_instr[2:0];
  wire instr_push = instr[5:4] == 0;
  wire ioreg = instr_push && instr[3];
  wire sfrreg = instr_reg_b;
  wire instr_pop = instr[5:4] == 1;
  wire instr_set = instr[5:4] == 2;
  wire instr_reset = instr[5:4] == 3;
  wire instr_push_type = instr_reg && instr_push;
  wire instr_pop_type = instr_reg && (instr_pop || instr_set || instr_reset);
  wire [3:0]sfrid = instr[3:0];
  wire push_result = sfrreg ? sfr[sfrid] :(
                     ioreg ? uo_out[regid] : ui_in[regid]);

  wire instr_sparam = instr_other && instr[5:4] == 2'b10;
  wire instr_sparam_expected = instr[3];
  // Every logic operation conceptually pops once or twice, or we pop none
  // for pushing constant data only.
  // However, since we then push  two results only if we've popped twice or
  // otherwise once, we only need to shift the stack right zero
  // or one times. For pushing constant data we need to be able to shift
  // left once.
  // wire shift_none    = instr_logic && instr[5:4] == 0;
  wire shift_right_1 = (instr_logic && instr[5:4] == 1) || instr_pop_type;
  wire shift_left_1  = (instr_logic && instr[5:4] == 3) || instr_push_type;

  wire [3:0]logic_table = instr[3:0];
  wire logic_result = logic_table[2'b11 - {nos, tos}];
  // I'm curious if this uses fewer gates than the above.
  //wire logic_result = (instr[0] &  nos &  tos) |
  //                    (instr[1] &  nos & ~tos) |
  //                    (instr[2] & ~nos &  tos) |
  //                    (instr[3] & ~nos & ~tos);

  wire instr_stack = (instr_other && instr[5:4] == 2'b11);
  wire instr_temporal = (instr_other && instr[5] == 1'b0);
  wire instr_swap = instr_stack && (logic_table == 4'b0010);
  wire instr_rot = instr_stack && (logic_table == 4'b0011);
  wire instr_clr = instr_stack && (logic_table == 4'b0000);
  wire instr_setall = instr_stack && (logic_table == 4'b0001);

  wire has_1_result = instr_logic || instr_push_type || instr_temporal || has_2_result;
  wire has_2_result = instr_swap || has_3_result;
  wire has_3_result = instr_rot;

  wire expected_prev_state = instr[4];
  wire temporal_result = (ui_in[regid] == ~expected_prev_state) &&
                         (ui_in_prev[regid] == expected_prev_state);

  wire res2 = (instr_rot && tos);
  wire res1 = (instr_swap && tos) ||
              (instr_rot && hos);
  wire res0 = (instr_logic && logic_result) ||
              (instr_push_type && push_result) ||
              (instr_swap && nos) ||
              (instr_rot && nos) ||
              (instr_temporal && temporal_result);
  wire val;
  wire keepval;
  assign {val, keepval} = !instr_pop_type ? {1'b0, 1'b1}: (
              instr_pop ? {stack[0], 1'b0} : (
              !stack[0] ? {1'b0, 1'b1} : (
              instr_set ? {1'b1, 1'b0} : (
              instr_reset ? {1'b0, 1'b0} : {1'b0, 1'b1}))));

  reg [7:0]prev_instr;
  reg exec_state;
  localparam EXEC_STATE_INSTR = 0;
  localparam EXEC_STATE_EXTRA_BYTE_1 = 1;
  reg instr_ready_prev;
  wire instr_ready_negedge = instr_ready_prev && !instr_ready;


  wire [7:0]servo_freq_val = 234;
  wire [4:0]servo_reset_val = 11;
  wire [7:0]timer_period_a = 183;

  always @(negedge clk) begin
    instr_ready_prev <= instr_ready;
    if (!rst_n) begin
      stack <= 15'b0;
      uo_out_reg <= 8'b0;
      //timer_period_a <= 183;
      // timer_period_b <= 183;
      //servo_freq_val <= 234;
      //servo_reset_val <= 11;
      servo_set_val <= 23;
      sfr <= 0;
      exec_state <= EXEC_STATE_INSTR;
      timer_clk_div <= 14;
      servo_clk_div <= 10;
    end else begin

      //servo_freq_val <= servo_freq_val;
      //servo_reset_val <= servo_reset_val;
      servo_set_val <= servo_set_val;
      sfr[SFR_TIMER_OUTPUT] <= timer_output;
      sfr[SFR_SERVO_OUTPUT] <= servo_output;
      if (instr_ready_negedge) begin
        prev_instr <= exec_state == EXEC_STATE_INSTR ? instr : prev_instr;
        exec_state <= exec_state == EXEC_STATE_EXTRA_BYTE_1 ? EXEC_STATE_INSTR : (
                      instr_sparam && (tos == instr_sparam_expected) ? EXEC_STATE_EXTRA_BYTE_1 : EXEC_STATE_INSTR);
        if (exec_state == EXEC_STATE_EXTRA_BYTE_1) begin
          case (regid)
            //0: begin end // Not Implemented
            1: timer_clk_div <= instr[4:0];
            //2: timer_period_a[7:0] <= instr;
            //3: begin end //timer_period_b[7:0] <= instr;
            //4: servo_clk_div <= instr[4:0];
            //5: servo_freq_val[7:0] <= instr;
            //6: servo_reset_val[3:0] <= instr[3:0];
            7: servo_set_val[3:0] <= instr[3:0];
          endcase
        end else begin
          stack[STACK_DEPTH-1] <= instr_clr ? 0 : (
            instr_setall ? 1 : (
            shift_left_1 ? stack[STACK_DEPTH-2] : (
            shift_right_1 ? 0 : stack[STACK_DEPTH-1])));
          stack[STACK_DEPTH-2:3] <= instr_clr ? 11'b0 : (
            instr_setall ? 11'hFF : (
            shift_left_1 ? stack[STACK_DEPTH-3:2] : (
            shift_right_1 ? stack[STACK_DEPTH-1:4] : stack[STACK_DEPTH-2:3])));
          stack[2] <= instr_clr ? 0 : (
            instr_setall ? 1 : (
            has_3_result ? res2 : (
            shift_left_1 ? stack[1] : (
            shift_right_1 ? stack[3] : stack[2]))));
          stack[1] <= instr_clr ? 0 : (
            instr_setall ? 1 : (
            has_2_result ? res1 : (
            shift_left_1 ? stack[0] : (
            shift_right_1 ? stack[2] : stack[1]))));
          stack[0] <= instr_clr ? 0 : (
            instr_setall ? 1 : (
            has_1_result ? res0 : (
            shift_left_1 ? 0 : (
            shift_right_1 ? stack[1] : stack[0]))));
          if (!keepval) begin
            if (sfrreg) sfr[sfrid] <= val;
            else uo_out_reg[regid] <= val;
          end
        end
      end
    end
  end
endmodule
