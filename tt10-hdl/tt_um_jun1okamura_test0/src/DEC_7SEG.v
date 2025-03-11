/*
 * Copyright (c) 2024 Jun-ichi OKAMURA
 * SPDX-License-Identifier: Apache-2.0

      -- 1 --
     |       |
     6       2
     |       |
      -- 7 --
     |       |
     5       3
     |       |
      -- 4 --
*/

module DEC_7SEG(hex, segment);
	input wire [4:0] hex;
	output reg [6:0] segment;

		always @(*) begin
			/* Case statement implements a logic truth table using gates + OPENSUSI signage */
			case(hex)
				//                             7654321
				5'b 00000: segment = 7'b 1000000; // 0
				5'b 00001: segment = 7'b 1111001; // 1
				5'b 00010: segment = 7'b 0100100; // 2
				5'b 00011: segment = 7'b 0110000; // 3
				5'b 00100: segment = 7'b 0011001; // 4
				5'b 00101: segment = 7'b 0010010; // 5
				5'b 00110: segment = 7'b 0000010; // 6
				5'b 00111: segment = 7'b 1111000; // 7
				5'b 01000: segment = 7'b 0000000; // 8
				5'b 01001: segment = 7'b 0011000; // 9
				5'b 01010: segment = 7'b 0001000; // A
				5'b 01011: segment = 7'b 0000011; // b
				5'b 01100: segment = 7'b 0100111; // c
				5'b 01101: segment = 7'b 0100001; // d
				5'b 01110: segment = 7'b 0000110; // E
				5'b 01111: segment = 7'b 0001110; // F
				//
				5'b 10000: segment = 7'b 0111110; // -
				5'b 10001: segment = 7'b 1000000; // O
				5'b 10010: segment = 7'b 0001100; // P
				5'b 10011: segment = 7'b 0000110; // E
				5'b 10100: segment = 7'b 0001000; // N
				5'b 10101: segment = 7'b 0010010; // S
				5'b 10110: segment = 7'b 0000001; // U
				5'b 10111: segment = 7'b 0010010; // S
				5'b 11000: segment = 7'b 1111001; // I
				5'b 11001: segment = 7'b 0111111; // -
				5'b 11010: segment = 7'b 0001000; // A
				5'b 11011: segment = 7'b 1111001; // I
				5'b 11100: segment = 7'b 0010010; // S
				5'b 11101: segment = 7'b 0100011; // o
				5'b 11110: segment = 7'b 1001111; // l
				5'b 11111: segment = 7'b 0111111; // -
			endcase
		end

 endmodule
