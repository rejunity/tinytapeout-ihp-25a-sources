/*
 * Copyright (c) 2024 Jun-ichi OKAMURA (jun1okamura@gmail.com)
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

/* verilator lint_off UNUSEDSIGNAL */

module tt_um_jun1okamura_test0 #( parameter MAX_COUNT = 16'd10_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire reset = !rst_n;
    wire [6:0] segment_out;
    wire sel0  = ui_in[0];
    wire sel1  = ui_in[1];

    // use output as 7 segments LED
    assign uo_out = {1'b0, segment_out};

    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

    // put bottom 8 bits of second counter out on the bidirectional gpio
    // assign uio_out = counter[23:16];
    assign uio_out = lfsr[7:0];

    // external clock is 10KHz then 1Hz, so need 16 bit counter
    reg  [15:0] counter;		// 16bit main counter
    reg  [3:0]  digit;			// digit counter
    reg   	    clk2; 		    // divided clock
    reg   	    clk2d;		    // divided clock
    wire [4:0]  data;			// data
    wire [7:0]  lfsr;			// LFSR 8
	wire [15:0] compare; 		// 
    wire        strb;           //

	assign compare = sel0 == 0 ? MAX_COUNT : {3'b001,lfsr[7:0],5'b00000}; 
    assign data    = sel1 == 0 ? {1'b0, digit} : {1'b1, digit};

    always @(posedge clk or posedge reset) begin
        if (reset) begin        // if reset, set counter to 0
            clk2d   <= 1'b0;
		end else begin			// LOOP
            // Generate clk2
            clk2d   <= clk2;
		end
    end


    assign strb = clk2 ^ clk2d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin        // if reset, set counter to 0
            counter <= 16'h0000;
            digit   <= 4'b0000;
            clk2    <= 1'b0;
		end else begin			// LOOP
            // if up to 10M or LFSR value
            if (counter >= compare) begin
	            clk2    <= !clk2;
                // reset counter
                counter <= 16'h0000;
                // digit <= digit + 1;
                digit   <= digit + 1'b1;
                // only count from 0 to F
				if (digit == 4'd9)
					digit <= 0;
			end else begin
                // increment counter
                counter <= counter + 1'b1;
	        end
	    end
	end

	// lfsr module circuit
	LFSR lfsr_mod(.lfsr_out(lfsr), .clk(clk), .enb(strb), .rst(reset));

	// Seven segment circuit
    DEC_7SEG seven_seg(.hex(data), .segment(segment_out));

endmodule

