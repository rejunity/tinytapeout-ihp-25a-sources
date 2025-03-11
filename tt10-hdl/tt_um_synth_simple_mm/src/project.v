/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_synth_simple_mm (
//module synth_simple (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  //assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  //wire _unused = &{ena, clk, rst_n, 1'b0};
  wire _unused = &{ena, ui_in[7:5], 1'b0};	

  wire [4:0] note_enn_i;
  wire pwm_out_i;
  wire pwm_out_left;
  reg pwm_out_right;  
    
  // set all IOs as inputs
  assign uio_oe = 8'b0;   
  // use 5 out of 8 input
  assign note_enn_i = ui_in[4:0];  
  // synth module  
       synth_module_v #(
           .nnotes(5),
           .nswitches(8)
       ) sm_i (
           .clk(clk),
           .rstn(rst_n),
           .sw(uio_in),
           .note_enn(note_enn_i),
           .pwm_out(pwm_out_i)
		      );

    assign pwm_out_left = pwm_out_i;

    always @ (  posedge clk or negedge rst_n)
     begin
         if ( rst_n == 1'b0 ) 
          begin
             pwm_out_right <= 0;
          end
        else
          begin 
             pwm_out_right <= pwm_out_i;
          end
     end // always @ (  posedge clk or negedge rstn)

    assign uo_out = {6'b0, pwm_out_right, pwm_out_left};

endmodule
