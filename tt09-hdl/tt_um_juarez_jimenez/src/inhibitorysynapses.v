`default_nettype none

module inhibatorysynapses( 
    input [0:0] clk,
    input [0:0] reset_i,
    
    //the output of the edgedetector that were inhibitory will be the inputs
    input [0:0] edgedetectoroutput,
    
    //output will return a inhibitory signal that we will use in the downstream circuitry
    output [0:0] inhibitorysignal
    
);

reg [0:0] inhibitorysignal_r;

// only shows inhibitory signals if the 
always @(posedge clk)
    if(reset_i) begin
        inhibitorysignal_r <= 1'b0;
    end else if (edgedetectoroutput) begin
        inhibitorysignal_r <= 1'b1;
    end else begin
        inhibitorysignal_r <= 1'b0;
    end

assign inhibitorysignal = inhibitorysignal_r;
endmodule