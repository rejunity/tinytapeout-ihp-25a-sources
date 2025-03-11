`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2024 11:05:11 AM
// Design Name: 
// Module Name: array_mult_structural
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module array_mult_structural(m,q,p);
    input [3:0] m,q;
    output [7:0] p;
    wire[3:0] w1, w2, w3, w4, partial1, partial2, partial3;
    wire[2:0] C;
    
    assign w1 = {m[3]&q[0], m[2]&q[0], m[1]&q[0], m[0]&q[0]};
    assign w2 = {m[3]&q[1], m[2]&q[1], m[1]&q[1], m[0]&q[1]};
    assign w3 = {m[3]&q[2], m[2]&q[2], m[1]&q[2], m[0]&q[2]};
    assign w4 = {m[3]&q[3], m[2]&q[3], m[1]&q[3], m[0]&q[3]};
    
    add_4bit stage0 (w2,{1'b0, w1[3:1]},partial1,C[0]);
    add_4bit stage1 (w3,{C[0], partial1[3:1]},partial2,C[1]);
    add_4bit stage2 (w4,{C[1], partial2[3:1]},partial3,C[2]);
    
    assign p = {C[2], partial3, partial2[0], partial1[0],w1[0]};

    
endmodule

module add_4bit(x,y,z,carry_out);
    input [3:0] x,y;
    output [3:0] z;
    output carry_out;
    wire [3:1] C;
    
    fulladd stage0 (x[0],y[0],1'b0,z[0],C[1]);
    fulladd stage1 (x[1],y[1],C[1],z[1],C[2]);
    fulladd stage2 (x[2],y[2],C[2],z[2],C[3]);
    fulladd stage3 (x[3],y[3],C[3],z[3],carry_out);
endmodule

module fulladd(a,b,Cin,sum,Cout);
    input a, b, Cin;
    output sum, Cout;
    wire z1,z2,z3;
 
    assign sum = a ^ b ^ Cin;
    assign z1 = a & b;
    assign z2 = a & Cin;
    assign z3 = b & Cin;
    assign Cout = z1 | z2 | z3;
endmodule