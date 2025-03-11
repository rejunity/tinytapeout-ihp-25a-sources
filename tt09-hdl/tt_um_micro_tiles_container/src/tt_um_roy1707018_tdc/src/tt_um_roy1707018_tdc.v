/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_roy1707018_tdc (

	      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(vpwr),
      .VGND(vgnd),
`endif
    input wire 		clk,     // clock
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs (8-bit output of time count)
   // input wire [7:0] 	uio_in,  // IOs: Input path
   // output wire [7:0] uio_out, // IOs: Output path
   //	 output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       rst_n     // Active-low reset
   // input wire 		ena     // always 1 when the design is powered, so you can ignore it
);


    localparam N_DELAY = 16;

    // Internal signals
    wire [15:0] time_count;  // 32-bit time count from the TDC delay module
    reg [7:0] selected_count; // 8-bit selected portion of the time_count
    //reg [31:0] time_count_reg;   // Register to store time_count


    // Instantiate the tdc_delay module
    tdc_delay #(.N_DELAY(N_DELAY)) u_tdc_delay (
        .rst_n(rst_n),            // Active-low reset
        .delay_clk(clk),                // System clock
        .start(ui_in[0]),         // Start signal (ui_in[0] as start)
        .time_count(time_count)   // 32-bit output time count
    );


    // 4-to-1 MUX to select which 8-bit section of time_count to output
    // 2-to-1 MUX to select which 8-bit section of time_count to output
    always @(*) begin
      case (ui_in[1])           // Use ui_in[3] to select part of the 16-bit time_count
        1'b0: selected_count = time_count[7:0];    // Lower 8 bits
        1'b1: selected_count = time_count[15:8];   // Upper 8 bits
        default: selected_count = 8'b0;
      endcase
    end


    // Output the selected 8 bits to uo_out
    assign uo_out = selected_count;

endmodule
