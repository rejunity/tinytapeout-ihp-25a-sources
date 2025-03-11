/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */// name of my parent directory; the top level module

`default_nettype none

module tt_um_juarez_jimenez(
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
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  // wire _unused = &{ena, clk, rst_n, 1'b0};

//define all wires here :p 

//lfsrout, ris, fall, pulse, signal, ogfeedback, selected feedback reset 
wire [7:0] lfsroutput;
wire risingedge, fallingedge, signal, pulse, ogfeedback, feedbackselected;
wire reset = ~rst_n; 

assign uo_out = lfsroutput;

assign ogfeedback = lfsroutput[7] ^ lfsroutput[5] ^ lfsroutput[4] ^ lfsroutput[3]; // calculaiting feedback



lfsr lfsr_func(.clk(clk), .reset_i(reset), .en_i(1'b1),  .seed(ui_in), .feedback(feedbackselected), .q_o(lfsroutput)); //feedback from feedback selector

//edge detection on lfsr output bit 0 
edgedetector edge_func(.clk(clk), .reset_i(reset), .lfsroutput(lfsroutput[0]), .risingedge(risingedge), .fallingedge(fallingedge));

//EXCITED SYNAPSES YAYAYAYYAYA
exictatorysynapses ec_fun(.clk(clk), .reset_i(reset), .edgedetectoroutput(risingedge), .excitedpulse(pulse));


//chill synapses #boring
inhibatorysynapses ih_func(.clk(clk), .reset_i(reset), .edgedetectoroutput(fallingedge), .inhibitorysignal(signal));

feedback feedbackfunc(.ogfeedback(ogfeedback), .excitedpulse(pulse), .inhibitorysignal(signal), .feedbackselected(feedbackselected));

endmodule
