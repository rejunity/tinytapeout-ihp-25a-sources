`default_nettype none

module exictatorysynapses( 
    input [0:0] clk,
    input [0:0] reset_i,

    //the output of the edgedetector that were excitatory will be the inputs
    input [0:0] edgedetectoroutput,
    
    //output will return a excited pulse that we will use in the downstream circuitry
    output [0:0] excitedpulse

);


reg [0:0] excitedpulse_r; 

// only shows excited pulses if the edge detector output was high 
always @(posedge clk)
    if(reset_i) begin
        excitedpulse_r <= 1'b0;
    end else if (edgedetectoroutput) begin
        excitedpulse_r <= 1'b1;
    end else begin
        excitedpulse_r <= 1'b0;
    end

assign excitedpulse = excitedpulse_r;

endmodule