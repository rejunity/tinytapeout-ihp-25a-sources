/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_dog_BILBO (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Map Tiny Tapeout inputs and outputs to BILBO signals
    wire b1      = ui_in[0];
    wire b2      = ui_in[1];
    wire [7:0] d = uio_in;    // Assuming `d` input data comes from the IO pins
    wire si      = ui_in[2];
    wire rst     = ~rst_n;    // `rst` active-high, mapped from active-low `rst_n`
    
    wire so;
    wire [7:0] y;
    wire b1_not;

    // Connect BILBO outputs to Tiny Tapeout outputs
    assign uo_out[7] = so;    // Single output `so` connected to `uo_out[7]`
    assign uo_out[6:0] = 0;   // Set other bits of `uo_out` to 0
    assign uio_out = y;       // Output `y` connected to `uio_out`
    assign uio_oe = 8'b11111111; // Enable all IOs as outputs

    // Internal BILBO signals
    wire m1_out, m2_out;
    wire [7:0] a;  // output of the AND gates
    wire [7:0] x;  // output of the XOR gates immediately before DFF
    wire [7:0] f;  // output of the DFF
    wire [7:0] cm; // output of the clocked mux (q)
    wire [2:0] fbm1; // feedback to mux1
    wire [2:0] fbm2; // feedback to mux2
    
    wire _unused = &{ena, ui_in[7:3], 1'b0};

    // Instantiate internal logic
    not2 n1(b1_not, b1);

    mux m1(m1_out, b1, cm[7], fbm1[2]);
    mux m2(m2_out, b1, si, fbm2[2]);

    // 8 stages of the BILBO chain
    and2 a1(a[0], b1_not, d[0]);
    xor2 x1(x[0], a[0], m1_out);
    DFF d1(x[0], clk, rst, f[0]);
    clk_mux cm1(cm[0], clk, b2, m2_out, d[0]);

    and2 a2(a[1], b1_not, d[1]);
    xor2 x2(x[1], a[1], f[0]);
    DFF d2(x[1], clk, rst, f[1]);
    clk_mux cm2(cm[1], clk, b2, cm[0], d[1]);

    and2 a3(a[2], b1_not, d[2]);
    xor2 x3(x[2], a[2], f[1]);
    DFF d3(x[2], clk, rst, f[2]);
    clk_mux cm3(cm[2], clk, b2, cm[1], d[2]);

    and2 a4(a[3], b1_not, d[3]);
    xor2 x4(x[3], a[3], f[2]);
    DFF d4(x[3], clk, rst, f[3]);
    clk_mux cm4(cm[3], clk, b2, cm[2], d[3]);

    and2 a5(a[4], b1_not, d[4]);
    xor2 x5(x[4], a[4], f[3]);
    DFF d5(x[4], clk, rst, f[4]);
    clk_mux cm5(cm[4], clk, b2, cm[3], d[4]);

    and2 a6(a[5], b1_not, d[5]);
    xor2 x6(x[5], a[5], f[4]);
    DFF d6(x[5], clk, rst, f[5]);
    clk_mux cm6(cm[5], clk, b2, cm[4], d[5]);

    and2 a7(a[6], b1_not, d[6]);
    xor2 x7(x[6], a[6], f[5]);
    DFF d7(x[6], clk, rst, f[6]);
    clk_mux cm7(cm[6], clk, b2, cm[5], d[6]);

    and2 a8(a[7], b1_not, d[7]);
    xor2 x8(x[7], a[7], f[6]);
    DFF d8(x[7], clk, rst, f[7]);
    clk_mux cm8(cm[7], clk, b2, cm[6], d[7]);

    // Feedback logic for XOR gates
    xor2 fb1x1(fbm1[0], f[7], f[5]);
    xor2 fb1x2(fbm1[1], fbm1[0], f[4]);
    xor2 fb1x3(fbm1[2], fbm1[1], f[3]);

    xor2 fb2x1(fbm2[0], cm[7], cm[5]);
    xor2 fb2x2(fbm2[1], fbm2[0], cm[4]);
    xor2 fb2x3(fbm2[2], fbm2[1], cm[3]);

    // Assign outputs
    assign so = f[7];
    assign y = cm;

endmodule

module xor2 (output wire out, input wire in1, in2);
assign out = in1 ^ in2;
endmodule 

module and2 (output wire out, input wire in1, in2);
assign out = in1 & in2;
endmodule

module mux (output wire out, input wire sel, in1, in2);
assign out = sel ? in1 : in2;
endmodule

module not2 (output wire out, input wire in);
assign out = ~in;
endmodule

module clk_mux(output reg out, input wire clk, input wire sel, input wire in1, in2);    
always@(posedge clk)
begin
out = sel ? in1 : in2;
end 
endmodule

module DFF (input wire d, input wire clk, input wire rst, output reg q);
always @(posedge clk or posedge rst) begin
if (rst)
    q <= 1'b0;
else
    q <= d;
end
endmodule
