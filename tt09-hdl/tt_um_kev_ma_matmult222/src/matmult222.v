/*
 * Copyright (c) 2024 Kevin Ma
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_kev_ma_matmult222 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // initialize bidirectional io
    assign uio_oe = 0;

    wire [7:0] A;                    // 8-bit 1d matrix
    wire [7:0] B;                    // 8-bit 1d matrix
    reg [1:0] A_2d [0:1][0:1];      // 2-bit 2x2 matrix for multiplication
    reg [1:0] B_2d [0:1][0:1];      // 2-bit 2x2 matrix for multiplication
    reg [1:0] out_2d [0:1][0:1];    // 2-bit 2x2 matrix for output
    integer i,j,k;
  
    // initialize inputs for matrices
    assign A[7:6] = ui_in[7:6];
    assign A[5:4] = ui_in[5:4];
    assign A[3:2] = ui_in[3:2];
    assign A[1:0] = ui_in[1:0];

    assign B[7:6] = uio_in[7:6];
    assign B[5:4] = uio_in[5:4];
    assign B[3:2] = uio_in[3:2];
    assign B[1:0] = uio_in[1:0];

    always @(A or B) begin
        // format 8 bit into matrices
        // top left: (0,0), top right: (0,1)
        // bottom left: (1,0), bottom right: (1,1)
        A_2d[0][0] = A[7:6];
        A_2d[0][1] = A[5:4];
        A_2d[1][0] = A[3:2];
        A_2d[1][1] = A[1:0];

        B_2d[0][0] = B[7:6];
        B_2d[0][1] = B[5:4];
        B_2d[1][0] = B[3:2];
        B_2d[1][1] = B[1:0];

        // initialize iteration variables
        i = 0;
        j = 0;
        k = 0;

        // initialize output
        {out_2d[0][0], out_2d[0][1], out_2d[1][0], out_2d[1][1]} = 0;

        // matrix multiplication
        for(i=0;i < 2;i=i+1)
            for(j=0;j < 2;j=j+1)
                for(k=0;k < 2;k=k+1)
                    out_2d[i][j] = out_2d[i][j] + (A_2d[i][k] * B_2d[k][j]);
    end

    // assign output to output pins
    assign uo_out = {out_2d[0][0], out_2d[0][1], out_2d[1][0], out_2d[1][1]};

    // All output pins must be assigned. If not used, assign to 0.
    assign uio_out = 0;
    assign uio_oe  = 0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
