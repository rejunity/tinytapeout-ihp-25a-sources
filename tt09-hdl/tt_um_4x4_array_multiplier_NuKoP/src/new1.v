`timescale 1ns / 1ps
module adder(
    input a,
    input b,
    input c,
    output y,
    output z
    );
    
// Internal Signals
    wire int_sig1;
    wire int_sig2;
    wire int_sig3;
    
        
    xor(y,a,b,c);
    and(int_sig1,a,b);
    and(int_sig2,a,c);
    and(int_sig3,b,c);
    or(z,int_sig1,int_sig2,int_sig3);
     
endmodule

module part(
    input [3:0] m,
    input [2:0] y,
    input q4,
    input c,
    output [2:0] o,
    output co,
    output p);
    wire [2:0] w;
    
    adder stage0 (m[0]&c,y[0],0,p,w[0]);
    adder stage1 (m[1]&c,y[1],w[0],o[0],w[1]);
    adder stage2 (m[2]&c,y[2],w[1],o[1],w[2]);
    adder stage3 (m[3]&c,q4,w[2],o[2],co);
  
endmodule 

module array_mult_structural(
	input [3:0] m,
	input [3:0] q,
	output [7:0] p
);
    wire [2:0] o1;
    wire [2:0] o2;
    wire [2:0] o3;
     wire [2:0] o4;

	wire [3:0] c;
	
    assign p[4]=o4[0];
    assign p[5]=o4[1];
    assign p[6]=o4[2];
    assign p[7]=c[3];
	part pa (m,3'b000,0,q[0],o1,c[0],p[0]);
	part pb (m,o1,c[0],q[1],o2,c[1],p[1]);
	part pc (m,o2,c[1],q[2],o3,c[2],p[2]);
	part pd (m,o3,c[2],q[3],o4,c[3],p[3]);
endmodule



