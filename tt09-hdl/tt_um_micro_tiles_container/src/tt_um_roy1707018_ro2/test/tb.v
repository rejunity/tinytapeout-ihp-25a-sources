`default_nettype none
`timescale 1ns / 1ps

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

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  //reg ena;
  reg [7:0] ui_in;
  //reg [7:0] uio_in;
  wire [7:0] uo_out;
  //wire [7:0] uio_out;
  //wire [7:0] uio_oe;

  // Declare power and ground wires outside procedural blocks
  wire vpwr;
  wire vgnd;

  assign vpwr = 1'b1;
  assign vgnd = 1'b0;

  // Instantiate the module
  tt_um_roy1707018_ro2 user_project (

    // Include power ports for the Gate Level test:
    `ifdef GL_TEST
      .VPWR(vpwr),    // Power supply
      .VGND(vgnd),    // Ground
    `endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      //.uio_in (uio_in),   // IOs: Input path
      //.uio_out(uio_out),  // IOs: Output path
      //.uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      //.ena    (ena),      // Enable - goes high when design is selected
      .clk    (clk),      // Clock
      .rst_n  (rst_n)     // Active-low reset
  );

endmodule

