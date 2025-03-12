`default_nettype none

module tdc  (
    input wire clk,
    input wire rst_n,
    input wire sampling_clk,
    input wire start_signal,
    input wire stop_signal,
    output wire busy,
    output reg [31:0] coarse_result,
    output reg [8:0] fine_result
  );


  // Internal registers.
  wire [143:0] delay_signal_wire;
  wire [142:0] delay_signal_wire_n;
  reg [142:0] tdc_start_signal_result;
  reg [142:0] tdc_stop_signal_result;
  reg [142:0] tdc_xor_result;
  reg [142:0] start_count_debug;
  reg [142:0] stop_count_debug;

  reg start_signal_activated;
  reg start_signal_sampling_clock_level;
  reg stop_signal_activated;
  reg stop_signal_sampling_clock_level;
  reg [31:0] coarse_count;
  reg [8:0] fine_procedure_counter;
  reg [8:0] fine_another_counter;
  reg [8:0] fine_start_counter;
  reg [8:0] fine_stop_counter;
  reg [8:0] positions_sum;
  reg reset_internal_logic;

  genvar i;
  generate
    for (i=0; i<=(142); i=i+1)
    begin : generated_delay_chain
      assign delay_signal_wire_n[i] = ~delay_signal_wire[i];
      assign delay_signal_wire[i+1] = ~delay_signal_wire_n[i];
    end
  endgenerate

  // Fine step generation start on each sampling clock edge.
  assign delay_signal_wire[0] = sampling_clk;
  assign busy = start_signal_activated || stop_signal_activated;



  always @(posedge start_signal or negedge reset_internal_logic)
  begin
    if(!reset_internal_logic)
    begin
      start_signal_activated <= 0;
    end
    else
    begin
      tdc_start_signal_result <= delay_signal_wire[142:0];
      start_signal_activated <= 1;
      start_signal_sampling_clock_level <= sampling_clk;
    end
  end

  always @(posedge stop_signal or negedge reset_internal_logic)
  begin
    if(!reset_internal_logic)
    begin
      stop_signal_activated <= 0;
    end
    else
    begin
      tdc_stop_signal_result <=  delay_signal_wire[142:0];
      stop_signal_activated <= 1;
      stop_signal_sampling_clock_level <= sampling_clk;
    end
  end

  always @(posedge sampling_clk or negedge reset_internal_logic)
  begin
    if(!reset_internal_logic)
    begin
      coarse_count <= 32'b0;
    end
    else if (start_signal_activated != stop_signal_activated)
    begin
      coarse_count <= coarse_count + 1'b1;
    end
  end

  always @(posedge clk)
  begin
    if(rst_n == 0)
    begin
      reset_internal_logic <= 0;
      fine_procedure_counter <= 9'b0;
      fine_another_counter <= 9'b0;
      fine_start_counter <= 9'b0;
      fine_stop_counter <= 9'b0;
      coarse_result <= 32'b0;
    end
    else if (stop_signal_activated)
    begin
      fine_procedure_counter <= fine_procedure_counter + 1'b1;

      if(fine_procedure_counter == 0)
      begin
        tdc_xor_result <= tdc_start_signal_result ^ tdc_stop_signal_result;
        start_count_debug <= tdc_start_signal_result;
        stop_count_debug <= tdc_stop_signal_result;
        fine_another_counter <= 9'b0;
      end
      else
      begin
        tdc_xor_result <=  tdc_xor_result >> 1;
        fine_another_counter <= fine_another_counter + {8'b0, tdc_xor_result[0]};

        start_count_debug <= start_count_debug >> 1;
        stop_count_debug <= stop_count_debug >> 1;
        fine_start_counter <= fine_start_counter + {8'b0, start_count_debug[0]};
        fine_stop_counter <= fine_stop_counter + {8'b0, stop_count_debug[0]};

        positions_sum <= fine_start_counter + fine_stop_counter;
      end

      if(fine_procedure_counter == 144)
      begin
        if(start_signal_sampling_clock_level != stop_signal_sampling_clock_level && (positions_sum > 143))
        begin
          fine_another_counter <= 143 + (143 - fine_another_counter);
        end

      end

      if(fine_procedure_counter >= 145)
      begin
        if((start_signal_sampling_clock_level == 0) && (stop_signal_sampling_clock_level == 1) && (coarse_count == 1))
        begin
          coarse_result <= coarse_count - 1;
        end
        else
        begin
          coarse_result <= coarse_count;
        end

        fine_result <= fine_another_counter;
        reset_internal_logic <= 0;
        fine_procedure_counter <= 9'b0;
      end
    end
    else
    begin
      reset_internal_logic <= 1;
    end
  end

endmodule
