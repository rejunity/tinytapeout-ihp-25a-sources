`default_nettype none
module tdc_delay #(parameter N_DELAY = 16) (
    input wire  rst_n,           // Active-low reset
    input wire delay_clk,         //delayed clk from sensor 
    
    input wire  start,           // Start signal
    output wire [N_DELAY-1:0] time_count // Time difference (number of transitions)
);


(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig;
(* keep = "true" *) wire [N_DELAY:0] w_dly_sig_n;

reg [N_DELAY-1:0] r_dly_store;

assign w_dly_sig[0] = start;

genvar i;
generate
    for (i = 0; i <= N_DELAY; i = i + 1) begin : g_dly_chain_even
        (* keep = "true" *) cinv dly_stg1 (.a(w_dly_sig[i]), .q(w_dly_sig_n[i]));
        (* keep = "true" *) cinv dly_stg2 (.a(w_dly_sig_n[i]), .q(w_dly_sig[i+1]));
    end
endgenerate



always @(negedge delay_clk) begin
    if (start) begin
        r_dly_store <= {N_DELAY{1'b0}};  // On rising edge of 'start', reset r_dly_store to 0
    end else begin
        r_dly_store <= w_dly_sig[N_DELAY:1];  // Otherwise, update with w_dly_sig[N_DELAY:1]
    end
end

   
 assign time_count = r_dly_store;

endmodule // tdc
