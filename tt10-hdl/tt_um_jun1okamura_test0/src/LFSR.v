/*
 * Copyright (c) 2024 Jun-ichi OKAMURA
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module LFSR (			
	output wire [7:0] lfsr_out, 
    input  wire clk,
    input  wire enb,
    input  wire rst
);
    //
	wire [7:0]  mux8;
	wire [15:0] mux16;
    // Instances
    lfsr8     sel8(.lfsr_out(mux8),  .clk(clk), .enb(enb), .rst(rst));
    lfsr16    data(.lfsr_out(mux16), .clk(clk), .enb(enb), .rst(rst));
    mux_16to8 mux1(.inputs(mux16), .sel8(mux8), .outputs(lfsr_out));

endmodule

// ======================== lfsr8 module =============================
module lfsr8 (			
	output reg  [7:0] lfsr_out, 
    input  wire clk,
    input  wire enb,
    input  wire rst
);
	//LFSR feedback
	wire   feedback;
	assign feedback = ~(lfsr_out[7] ^ lfsr_out[5] ^ lfsr_out[4] ^ lfsr_out[3]);
    //
	always @(posedge clk or posedge rst) begin
		if (rst)
			lfsr_out <= 8'h00;
		else begin
			if (enb) 
				lfsr_out <= {lfsr_out[6:0],feedback};
		end
	end
	
endmodule

// ======================== lfsr16 module =============================
module lfsr16(
	output reg  [15:0] lfsr_out, 
	input  wire clk, 
    input  wire enb,
	input  wire rst 
);
	//LFSR register block 
	wire   feedback;
	assign feedback = ~(lfsr_out[15] ^ lfsr_out[14] ^ lfsr_out[12] ^ lfsr_out[10]);
    //
	always @(posedge clk or posedge rst) begin
		if (rst)
			lfsr_out <= 16'h0000;
		else begin
			if (enb) 
				lfsr_out <= {lfsr_out[14:0],feedback};
		end
	end
  
endmodule

// ======================== mux 16 > 8 module =============================
module mux_16to8 (
    input  wire [15:0] inputs, // 16 inputs
    input  wire [7:0]  sel8,   // 8 control inputs
    output wire [7:0]  outputs // 8 outputs
);
    // 
	genvar j;
	generate
		for (j = 0; j < 8; j = j + 1) begin : mux_inst8
		    assign outputs[j] = sel8[j] ? inputs[j * 2 + 1] : inputs[j * 2];
		end
	endgenerate
    //

endmodule
