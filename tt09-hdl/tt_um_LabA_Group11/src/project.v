/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_LabA_Group11 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire [3:0] m;
wire [3:0] q;
wire [7:0] p;

assign m = ui_in[7:4];
assign q = ui_in[3:0];

assign uio_out = 0;
assign uio_oe  = 0;

// List all unused inputs to prevent warnings
wire _unused = &{ena, clk, rst_n, 1'b0};

wire int_sig1,int_sig2,int_sig3,int_sig4,int_sig5,int_sig6,int_sig7,int_sig8,int_sig9,int_sig10,int_sig11,int_sig12,int_sig13,int_sig14,int_sig15,carry_out1,carry_out2,carry_out3,carry_out4,carry_out5,carry_out6,carry_out7,carry_out8,carry_out9,carry_out10,carry_out11,carry_out12,sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,sum11,sum12;

assign int_sig1 = m[1] & q[0];
assign int_sig2 = m[0] & q[1];
assign int_sig3 = m[2] & q[0];
assign int_sig4 = m[1] & q[1];
assign int_sig5 = m[0] & q[2];
assign int_sig6 = m[3] & q[0];
assign int_sig7 = m[2] & q[1];
assign int_sig8 = m[1] & q[2];
assign int_sig9 = m[0] & q[3];
assign int_sig10 = m[3] & q[1];
assign int_sig11 = m[2] & q[2];
assign int_sig12 = m[1] & q[3];
assign int_sig13 = m[3] & q[2];
assign int_sig14 = m[2] & q[3];
assign int_sig15 = m[3] & q[3];

full_adder inst1_1 (int_sig1,int_sig2,0, carry_out1, sum1);
full_adder inst1_2 (int_sig3,int_sig4,carry_out1, carry_out2, sum2);
full_adder inst2_1 (int_sig5,sum2, 0, carry_out3, sum3);
full_adder inst1_3 (int_sig6,int_sig7,carry_out2, carry_out4, sum4);
full_adder inst2_2 (sum4,int_sig8,carry_out3, carry_out5, sum5);
full_adder inst3_1 (sum5,int_sig9,0,carry_out6, sum6);
full_adder inst1_4 (int_sig10,0,carry_out4,carry_out7,sum7);
full_adder inst2_3 (sum7,int_sig11,carry_out5,carry_out8,sum8);
full_adder inst3_2 (sum8,int_sig12,carry_out6,carry_out9,sum9);
full_adder inst2_4 (carry_out7,int_sig13,carry_out8,carry_out10,sum10);
full_adder inst3_3 (sum10,int_sig14,carry_out9,carry_out11,sum11);
full_adder inst3_4 (carry_out10,int_sig15,carry_out11,carry_out12,sum12);

assign p[0] = m[0] & q[0];
assign p[1] = sum1;
assign p[2] = sum3;
assign p[3] = sum6;
assign p[4] = sum9;
assign p[5] = sum11;
assign p[6] = sum12;
assign p[7] = carry_out12;
    
assign uo_out = p;

endmodule



module full_adder(
    input m,
    input q,
    input c,
    output carry_out,
    output sum
    );
    
wire and1, and2, and3;

assign and1 = c&q;
assign and2 = c&m;
assign and3 = q&m;
assign carry_out = and1 | and2 | and3;
assign sum = m ^ q ^ c;

    
endmodule





