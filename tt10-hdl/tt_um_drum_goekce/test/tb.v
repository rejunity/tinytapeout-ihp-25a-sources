`default_nettype none `timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  localparam unsigned k = 6;
  localparam unsigned n = 8;
  localparam unsigned m = 8;
  localparam unsigned RAM_BYTES = 10;
  localparam addr_bits = $clog2(RAM_BYTES);

  wire [addr_bits-1:0] addr;
  assign ui_in[addr_bits-1:0] = addr;

  wire wr_en;
  assign ui_in[7] = wr_en;

  wire tri_oe;
  assign ui_in[6] = tri_oe;

  wire r_wr_en;
  assign ui_in[5] = r_wr_en;

  reg [(n-1):0] a;
  reg [(m-1):0] b;
  reg [(n+m)-1:0] r;

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] ram_in;
  wire [7:0] ram_out;
  wire [7:0] r_msbs;
  wire [7:0] uio_oe;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Replace tt_um_example with your module name:
  tt_um_drum_goekce user_project (
      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR   (VPWR),
      .VGND   (VGND),
`endif
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (ram_out),  // Dedicated outputs
      .uio_in (ram_in),   // IOs: Input path
      .uio_out(r_msbs),   // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );
endmodule
