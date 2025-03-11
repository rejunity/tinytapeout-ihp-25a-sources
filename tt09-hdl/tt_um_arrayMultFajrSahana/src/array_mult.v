module array_mult_structural(
    input [3:0] m,
    input [3:0] q,
    output [7:0] p
    );

wire w1, w2, w3, w4, w5, w6;
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11;
assign p[0] = m[0] & q[0];

fulladd a1 (m[0] & q[1], m[1] & q[0], 1'b0, p[1], c1);
fulladd a2 (m[2] & q[0], m[1] & q[1], c1, s1, c2);
fulladd a3 (m[3] & q[0], m[2] & q[1], c2, s2, c3);
fulladd a4 (m[3] & q[1], 1'b0, c3, s3, c4);

fulladd a5 (m[0] & q[2], s1,1'b0, p[2], c5);
fulladd a6 (m[1] & q[2], s2, c5, s4, c6);
fulladd a7 (m[2] & q[2], s3, c6, s5, c7);
fulladd a8 (m[3] & q[2], c4, c7, s6, c8);

fulladd a9 (m[0] & q[3], s4, 1'b0, p[3],c9);
fulladd a10 (m[1] & q[3], s5, c9, p[4], c10);
fulladd a11 (m[2] & q[3], s6, c10, p[5], c11);
fulladd a12 (m[3] & q[3], c8, c11, p[6], p[7]);

endmodule

module fulladd(
    input m,
    input q,
    input carryin,
    output sum,
    output carryout
    );
   
    assign sum = m ^ q ^ carryin;
    assign carryout = (carryin & (m^q)) | (m&q);

endmodule
