/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_array_mult_structural(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  
    wire [3:0] m = ui_in[7:4];    
    wire [3:0] q = ui_in[3:0]; 
    wire [7:0] p;

    wire [3:0] s0_out, s1_out, s2_out, s3_out, s4_out;
    wire [3:0] c0_out, c1_out, c2_out, c3_out, c4_out;
    wire [3:0] m0q_in, m1q_in, m2q_in, m3q_in;
    
    // CSA row 0
    assign m0q_in[0] = m[0] * q[0];
    assign m0q_in[1] = m[0] * q[1];
    assign m0q_in[2] = m[0] * q[2];
    assign m0q_in[3] = m[0] * q[3];
    full_adder fa_m0q0 (m0q_in[0], 1'b0, 1'b0, s0_out[0], c0_out[0]);
    full_adder fa_m0q1 (m0q_in[1], 1'b0, 1'b0, s0_out[1], c0_out[1]);
    full_adder fa_m0q2 (m0q_in[2], 1'b0, 1'b0, s0_out[2], c0_out[2]);
    full_adder fa_m0q3 (m0q_in[3], 1'b0, 1'b0, s0_out[3], c0_out[3]);
    
    // CSA row 1
    assign m1q_in[0] = m[1] * q[0];
    assign m1q_in[1] = m[1] * q[1];
    assign m1q_in[2] = m[1] * q[2];
    assign m1q_in[3] = m[1] * q[3];
    full_adder fa_m1q0 (m1q_in[0], s0_out[1], c0_out[0], s1_out[0], c1_out[0]);
    full_adder fa_m1q1 (m1q_in[1], s0_out[2], c0_out[1], s1_out[1], c1_out[1]);
    full_adder fa_m1q2 (m1q_in[2], s0_out[3], c0_out[2], s1_out[2], c1_out[2]);
    full_adder fa_m1q3 (m1q_in[3], 1'b0, c0_out[3], s1_out[3], c1_out[3]);
    
    // CSA row 2
    assign m2q_in[0] = m[2] * q[0];
    assign m2q_in[1] = m[2] * q[1];
    assign m2q_in[2] = m[2] * q[2];
    assign m2q_in[3] = m[2] * q[3];
    full_adder fa_m2q0 (m2q_in[0], s1_out[1], c1_out[0], s2_out[0], c2_out[0]);
    full_adder fa_m2q1 (m2q_in[1], s1_out[2], c1_out[1], s2_out[1], c2_out[1]);
    full_adder fa_m2q2 (m2q_in[2], s1_out[3], c1_out[2], s2_out[2], c2_out[2]);
    full_adder fa_m2q3 (m2q_in[3], 1'b0, c1_out[3], s2_out[3], c2_out[3]);
    
    // CSA row 3
    assign m3q_in[0] = m[3] * q[0];
    assign m3q_in[1] = m[3] * q[1];
    assign m3q_in[2] = m[3] * q[2];
    assign m3q_in[3] = m[3] * q[3];
    full_adder fa_m3q0 (m3q_in[0], s2_out[1], c2_out[0], s3_out[0], c3_out[0]);
    full_adder fa_m3q1 (m3q_in[1], s2_out[2], c2_out[1], s3_out[1], c3_out[1]);
    full_adder fa_m3q2 (m3q_in[2], s2_out[3], c2_out[2], s3_out[2], c3_out[2]);
    full_adder fa_m3q3 (m3q_in[3], 1'b0, c2_out[3], s3_out[3], c3_out[3]);

    // CPA row 4
    full_adder fa_cp4(s3_out[1], c3_out[0], 1'b0, s4_out[0], c4_out[0]); 
    full_adder fa_cp5(s3_out[2], c3_out[1], c4_out[0], s4_out[1], c4_out[1]); 
    full_adder fa_cp6(s3_out[3], c3_out[2], c4_out[1], s4_out[2], c4_out[2]); 
    full_adder fa_cp7(1'b0, c3_out[3], c4_out[2], s4_out[3], c4_out[3]); 
    assign p = {s4_out[3], s4_out[2], s4_out[1], s4_out[0], s3_out[0], s2_out[0], s1_out[0], s0_out[0]};

    assign uo_out = p;

    assign uio_out = 0;
    assign uio_oe  = 0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule


module full_adder(
    input x_in, y_in, c_in,
    output s_out, c_out
    );
    
    wire w1, w2, w3;
    
    xor(w1, x_in, y_in);
    xor(s_out, w1, c_in);
    and(w2, w1, c_in);
    and(w3, x_in, y_in);
    or(c_out, w2, w3);
endmodule

