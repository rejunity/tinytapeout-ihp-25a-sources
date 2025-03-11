module lif(
    input clk,
    input [7:0] I, // Input current
    input rst_n,
	input en,
    output spike
    );

    parameter threshold = 8'd239;
    reg [7:0] U; // Neuron potential
    reg [3:0] timer;
    
    assign spike = U >= threshold;
    always_ff @(posedge clk) begin
        if (rst_n) begin
            timer <= 0;
            U <= 0;
		end else if (~en) begin
        end else if (timer == 0
                && U >= threshold) begin
            // Change as needed
            U <= U + I - threshold;
            timer <= 4'd15;
        end else begin
            U <= (U >> 1) + I;
            if (timer != 0)
                timer <= timer - 1;
        end
    end
endmodule
