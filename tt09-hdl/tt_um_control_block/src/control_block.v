/*
 * Copyright (c) 2024 Siddharth Nema & Gerry Chen
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_control_block (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    /* Assign the inputs to wires */
    wire [3:0] opcode = ui_in[3:0];
    assign uio_oe = 8'hFF; // Configure all bidirectional pins as outputs

    /* Supported Instructions' Opcodes */
    localparam OP_HLT = 4'h0;
    // localparam OP_NOP = 4'h1;
    localparam OP_ADD = 4'h2;
    localparam OP_SUB = 4'h3;
    localparam OP_LDA = 4'h4;
    localparam OP_OUT = 4'h5;
    localparam OP_STA = 4'h6;
    localparam OP_JMP = 4'h7;

    /* Output Control Signals */
    localparam SIG_PC_INC = 14;             // C_P
    localparam SIG_PC_EN = 13;              // E_P
    localparam SIG_PC_LOAD = 12;            // L_P
    localparam SIG_MAR_ADDR_LOAD_N = 11;    // \L_MA
    localparam SIG_MAR_MEM_LOAD_N = 10;     // \L_MD
    localparam SIG_RAM_EN_N = 9;            // \CE
    localparam SIG_RAM_LOAD_N = 8;          // \L_R
    localparam SIG_IR_LOAD_N = 7;           // \L_I
    localparam SIG_IR_EN_N = 6;             // \E_I
    localparam SIG_REGA_LOAD_N = 5;         // \L_A
    localparam SIG_REGA_EN = 4;             // E_A
    localparam SIG_ADDER_SUB = 3;           // S_U
    localparam SIG_REGB_EN = 2;             // E_U
    localparam SIG_REGB_LOAD_N = 1;         // \L_B
    localparam SIG_OUT_LOAD_N = 0;          // \L_O

    /* Internal Regs */
    reg [2:0] stage;
    reg [14:0] control_signals;
    reg halted;

    /* Micro-Operation Stages */
    parameter T0 = 0, T1 = 1, T2 = 2, T3 = 3, T4 = 4, T5 = 5;

    /* Stage Transition Logic */
    always @(posedge clk) begin
        if (!rst_n) begin           // If reset is asserted, transition to a reset holding stage
        stage <= 6;
        end
        else begin                   // If reset is not asserted, do the stages sequentially
            if (stage == 6) begin
                stage <= T0;
            end
            else if ((stage == T0 || stage == T1 || stage == T2 ||
                    stage == T3 || stage == T4 || stage == T5) && !halted) begin
                /* Only increment stage when in a valid stage */
                stage <= stage + 1;
            end
            else if (!halted) begin
                /* When in an invalid stage, transition to reset holding stage */
                stage <= 6;
            end
        end

        /* When halted, transition to halt stage */
        if (halted) begin
            stage <= 7;
        end
    end

    /* Micro-Operation Logic */
    always @(negedge clk) begin
        control_signals <= 15'b000111111100011; // All signals are deasserted
        
        /* If reset is asserted, initialize halt flag */
        if (!rst_n) begin
            halted <= 0;
        end

        case(stage)
            T0: begin
                control_signals[SIG_PC_EN] <= 1;
                control_signals[SIG_MAR_ADDR_LOAD_N] <= 0;
            end
            T1: begin
                control_signals[SIG_PC_INC] <= 1;

            end
            T2: begin
                control_signals[SIG_RAM_EN_N] <= 0;
                control_signals[SIG_IR_LOAD_N] <= 0;
            end
            T3: begin
                case (opcode)
                    OP_HLT: begin
                        halted <= 1;
                    end
                    OP_ADD, OP_SUB, OP_LDA, OP_STA: begin
                        control_signals[SIG_IR_EN_N] <= 0;
                        control_signals[SIG_MAR_ADDR_LOAD_N] <= 0;
                    end
                    OP_OUT: begin
                        control_signals[SIG_REGA_EN] <= 1;
                        control_signals[SIG_OUT_LOAD_N] <= 0;
                    end
                    OP_JMP: begin
                        control_signals[SIG_IR_EN_N] <= 0;
                        control_signals[SIG_PC_LOAD] <= 1;
                    end
                    default: begin
                    // Do nothing (leave control_signals unchanged)
                    end
                endcase
            end
            T4: begin
                case (opcode)
                    OP_ADD, OP_SUB: begin
                        control_signals[SIG_RAM_EN_N] <= 0;
                        control_signals[SIG_REGB_LOAD_N] <= 0;
                    end
                    OP_LDA: begin
                        control_signals[SIG_RAM_EN_N] <= 0;
                        control_signals[SIG_REGA_LOAD_N] <= 0;
                    end
                    OP_STA: begin
                        control_signals[SIG_REGA_EN] <= 1;
                        control_signals[SIG_MAR_MEM_LOAD_N] <= 0;
                    end
                    default: begin
                    // Do nothing (leave control_signals unchanged)
                    end
                endcase
            end
            T5: begin
                case (opcode)
                    OP_ADD: begin
                        control_signals[SIG_REGB_EN] <= 1;
                        control_signals[SIG_REGA_LOAD_N] <= 0;
                    end
                    OP_SUB: begin
                        control_signals[SIG_ADDER_SUB] <= 1;
                        control_signals[SIG_REGB_EN] <= 1;
                        control_signals[SIG_REGA_LOAD_N] <= 0;
                    end
                    OP_STA: begin
                        control_signals[SIG_RAM_LOAD_N] <= 0;
                    end
                    default: begin
                    // Do nothing (leave control_signals unchanged)
                    end
                endcase
            end
            default: begin
            // Do nothing (leave control_signals unchanged)
            end
        endcase
    end

    assign uo_out[7] = halted;
    assign uo_out[6:0] = control_signals[14:8];
    assign uio_out[7:0] = control_signals[7:0];

    wire _unused = &{ui_in[7:4], uio_in, ena, 3'b0};

endmodule
