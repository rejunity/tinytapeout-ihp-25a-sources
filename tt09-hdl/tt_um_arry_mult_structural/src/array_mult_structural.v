`timescale 1ns / 1ps


module array_mult_structural(
    input [3:0] m,
    input [3:0] q,
    output [7:0] p
    );
 
 
    wire pp0_0, pp0_1, pp0_2, pp0_3;
    wire pp1_0, pp1_1, pp1_2, pp1_3;
    wire pp2_0, pp2_1, pp2_2, pp2_3;
    wire pp3_0, pp3_1, pp3_2, pp3_3;
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12;
    wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;
    
    assign pp0_0 = m[0] & q[0];
    assign pp0_1 = m[0] & q[1];
    assign pp0_2 = m[0] & q[2];
    assign pp0_3 = m[0] & q[3];
    
    assign pp1_0 = m[1] & q[0];
    assign pp1_1 = m[1] & q[1];
    assign pp1_2 = m[1] & q[2];
    assign pp1_3 = m[1] & q[3];
    
    assign pp2_0 = m[2] & q[0];
    assign pp2_1 = m[2] & q[1];
    assign pp2_2 = m[2] & q[2];
    assign pp2_3 = m[2] & q[3];
    
    assign pp3_0 = m[3] & q[0];
    assign pp3_1 = m[3] & q[1];
    assign pp3_2 = m[3] & q[2];
    assign pp3_3 = m[3] & q[3];
    
    assign p[0] = pp0_0;
    
    full_adder FA1 (pp0_1, pp1_0, 1'b0, s1, c1);
    assign p[1] = s1;
    
    full_adder FA2 (pp1_1, pp2_0, c1, s2, c2);
    full_adder FA3 (pp2_1, pp3_0, c2, s3, c3);
    full_adder FA4 (pp3_1, 1'b0, c3, s4, c4);
    
    full_adder FA5 (pp0_2, s2, 1'b0, s5, c5);
    assign p[2] = s5;
    full_adder FA6 (pp1_2, s3, c5, s6, c6);
    full_adder FA7 (pp2_2, s4, c6, s7, c7);
    full_adder FA8 (pp3_2, c4, c7, s8, c8);
    
    full_adder FA9 (pp0_3, s6, 1'b0, s9, c9);
    assign p[3] = s9;
    full_adder FA10 (pp1_3, s7, c9, s10, c10);
    assign p[4] = s10;
    full_adder FA11 (pp2_3, s8, c10, s11, c11);
    assign p[5] = s11;
    full_adder FA12 (pp3_3, c8, c11, s12, c12);
    assign p[6] = s12;
    assign p[7] = c12;
endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
   );
    assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (b&cin) | (cin&a);
    
endmodule
