`default_nettype none
`timescale 1ns / 1ps

module tb_pleasure_regulator ();

  // Dump the signals to a VCD file
  initial begin
    $dumpfile("tb_pleasure_regulator.vcd");
    $dumpvars(0, tb_pleasure_regulator);
    #1;
  end

  // Wire up the inputs and outputs:
  reg state_controller_inc;
  reg state_controller_dec;
  reg [6:0] stimuli;
  wire pleasure_inc;
  wire pleasure_dec;

  // Instantiate stess_regulator classifier module 
  pleasure_regulator dut (
      .state_controller_inc (state_controller_inc),   
      .state_controller_dec (state_controller_dec),
      .stimuli (stimuli),
      .pleasure_inc (pleasure_inc),
      .pleasure_dec (pleasure_dec)
  );

endmodule
