`default_nettype none

module edgedetector( 
    input [0:0] clk,
    input [0:0] reset_i,

    //the output of the lfsr will be the inputs to edge detector
    input [0:0] lfsroutput,
    
    //output will determine whether exictatory or inhibatory synapses w/ 1s and 0s
    output [0:0] risingedge,
    output[0:0] fallingedge
);

reg[0:0] prevedge;
reg[0:0] risingedge_r; 
reg[0:0] fallingedge_r; 

// edge detector from 125 , instead of buttons, its the edges 
always @(posedge clk) begin
    if (reset_i) begin
        // resetting all reg
        prevedge <= 1'b0;
        risingedge_r <= 1'b0;
        fallingedge_r <= 1'b0;
    end else begin
    
        // pulse for one clk cycle on rising edge of lfsr output
        if ((lfsroutput == 1'b1) && (prevedge == 1'b0)) begin
            risingedge_r <= 1'b1;
        end else begin
            risingedge_r <= 1'b0;
        end
            
        // pulse for one clk cycle on falling edge of lfsr output
        if((lfsroutput == 1'b0) && (prevedge == 1'b1)) begin
            fallingedge_r <= 1'b1;
        end else begin
            fallingedge_r <= 1'b0;
        end
        // upd8 the prev edge state
        prevedge <= lfsroutput;
    end
end


assign risingedge = risingedge_r;
assign fallingedge = fallingedge_r;

endmodule