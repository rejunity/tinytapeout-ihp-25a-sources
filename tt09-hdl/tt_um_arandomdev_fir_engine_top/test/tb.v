`default_nettype none `timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // symbolic wires for cocotb, can't attach monitors to bits of arrays
  wire mclk;
  wire lrck;
  wire sclk;
  wire dac;

  reg adc;
  reg cs;
  reg mosi;
  reg spiClk;

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;

  wire [7:0] ui_in;
  wire [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Wire up symbolic wires
  assign mclk = uio_out[0];
  assign lrck = uio_out[1];
  assign sclk = uio_out[2];
  assign dac = uio_out[3];

  assign uio_in[7] = adc;
  assign ui_in[0] = cs;
  assign ui_in[1] = mosi;
  assign ui_in[3] = spiClk;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Replace tt_um_example with your module name:
  tt_um_arandomdev_fir_engine_top top (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
