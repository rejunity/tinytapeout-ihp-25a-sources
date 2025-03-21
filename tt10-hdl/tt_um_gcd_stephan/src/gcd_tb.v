`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

// Test bench for GCD.
`timescale 1ns / 1ps

module gcd_tb;
    parameter PERIOD = 10;
    integer i;

    parameter integer N_OPS = 100;
    parameter [16*N_OPS:0] A_OPS = {16'd57407, 16'd51483, 16'd26309, 16'd17095, 16'd55996, 16'd2236, 16'd53559, 16'd47939, 16'd43319, 16'd43350, 16'd38575, 16'd49898, 16'd36291, 16'd14919,   16'd302, 16'd29913, 16'd16728, 16'd44656, 16'd34619, 16'd35771, 16'd61336, 16'd49269,  16'd8033, 16'd61840, 16'd64102, 16'd62239,  16'd5778, 16'd40060, 16'd1686,  16'd5675, 16'd56136, 16'd26657, 16'd21805, 16'd17543, 16'd35029, 16'd54941, 16'd21660, 16'd60696, 16'd13626, 16'd7762, 16'd53903, 16'd32076, 16'd46766, 16'd51636,  16'd4719, 16'd48288, 16'd31634, 16'd59056,  16'd8881, 16'd20200, 16'd21876, 16'd17116, 16'd36699, 16'd40423, 16'd41394, 16'd43073, 16'd52862, 16'd28926, 16'd59475, 16'd64315, 16'd10037, 16'd20063, 16'd60880, 16'd52962, 16'd46993, 16'd24061, 16'd40658,  16'd4093, 16'd53036, 16'd50578, 16'd43898, 16'd39453, 16'd37550, 16'd24044, 16'd24493, 16'd40326, 16'd24995, 16'd60468, 16'd20284, 16'd28575,   16'd275, 16'd50043, 16'd16215, 16'd49271, 16'd13010,  16'd1702, 16'd49334, 16'd26737, 16'd61533, 16'd57623, 16'd21171, 16'd10634, 16'd12411, 16'd58491, 16'd34569,   16'd745, 16'd45073, 16'd35634, 16'd33855, 16'd35682};
    parameter [16*N_OPS:0] B_OPS = {16'd17727, 16'd62518,  16'd6586, 16'd32320, 16'd36594, 16'd1636, 16'd58331, 16'd31754, 16'd49195, 16'd55138, 16'd36922, 16'd45096,  16'd7490, 16'd58364, 16'd40212, 16'd45744, 16'd18369,  16'd3453, 16'd23520, 16'd10245,  16'd8807,  16'd3285, 16'd21398, 16'd27808,  16'd6970, 16'd46167, 16'd26058, 16'd44050, 16'd7344, 16'd48606,  16'd2436, 16'd10113, 16'd51913, 16'd42236, 16'd49210, 16'd41620, 16'd25684,  16'd6192, 16'd37386, 16'd1859, 16'd56596, 16'd57952, 16'd49923, 16'd40769, 16'd33480, 16'd18806, 16'd17864, 16'd10441, 16'd11586, 16'd46004, 16'd63617, 16'd19418,  16'd4616,  16'd6650, 16'd22212, 16'd47406, 16'd55069, 16'd13729, 16'd45541, 16'd58036, 16'd25711, 16'd35132, 16'd45315, 16'd61901, 16'd17069, 16'd38358, 16'd26288, 16'd62657, 16'd40379, 16'd50592,  16'd5057, 16'd45490, 16'd35116, 16'd52739, 16'd55538, 16'd13619, 16'd14695, 16'd42187,  16'd4879, 16'd14561, 16'd32392, 16'd45857, 16'd23167, 16'd33083,  16'd9066, 16'd10994, 16'd47418, 16'd42952,  16'd2078, 16'd13231, 16'd60911, 16'd10593, 16'd10704, 16'd32516,  16'd5956, 16'd14882,  16'd6073, 16'd24191, 16'd18715,  16'd8563};
    parameter [16*N_OPS:0] C_RES = {    16'd1,     16'd1,      16'd1,    16'd5,     16'd2,    16'd4,     16'd1,      16'd1,     16'd1,    16'd2,     16'd1,     16'd2,     16'd1,     16'd1,     16'd2,     16'd3,     16'd3,     16'd1,     16'd1,     16'd1,     16'd1,     16'd3,     16'd1,    16'd16,     16'd2,     16'd1,     16'd6,    16'd10,    16'd6,     16'd1,    16'd12,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd4,    16'd72,    16'd18,    16'd1,     16'd1,     16'd4,     16'd1,     16'd1,     16'd3,     16'd2,     16'd2,     16'd1,     16'd1,     16'd4,     16'd1,     16'd2,     16'd1,     16'd1,     16'd6,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd5,     16'd7,     16'd1,     16'd1,     16'd2,     16'd1,     16'd1,     16'd2,     16'd1,     16'd1,     16'd2,     16'd1,     16'd7,     16'd1,     16'd5,     16'd1,     16'd1,     16'd1,     16'd1,     16'd7,     16'd1,     16'd1,     16'd2,    16'd46,     16'd2,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd3,     16'd1,     16'd1,     16'd1,     16'd1,     16'd1,     16'd5,     16'd1};

    // parameter integer N_OPS = 5;
    // parameter [16*N_OPS:0] A_OPS = {16'd57407, 16'd51483, 16'd26309, 16'd17095, 16'd55996};
    // parameter [16*N_OPS:0] B_OPS = {16'd17727, 16'd62518,  16'd6586, 16'd32320, 16'd36594};
    // parameter [16*N_OPS:0] C_RES = {    16'd1,     16'd1,      16'd1,    16'd5,     16'd2};

    reg  clk, reset, req;
    reg  [15:0] AB;

    reg [15:0] A_dbg, B_dbg, C_dbg;

    wire ack;
    wire [15:0] C;


    // Instantiate the gcd module
    gcd_module gcd_inst (
        .reset(reset),   
        .clk(clk),
        .req(req),
        .AB(AB),
        .ack(ack),
        .C(C)
    );

initial begin
    reset   = 0;
    req     = 0;
    AB      = 16'd0;
    clk     = 0;
end
// Clock generation
always begin
    #PERIOD clk = ~clk; // Toggle each 10 ns 
end

initial begin
    $display("Starting testbench...");
    @(posedge clk);
    $display("Got clock. Resetting...");
    #10
    reset = 1;
    #40 reset = 0;
    #20;

    $display("Starting loop...");
    for (i = 0; i < N_OPS; i = i + 1) begin
        $display("Loop %0d", i);

        A_dbg = A_OPS[16*i +: 16];
        B_dbg = B_OPS[16*i +: 16];
        C_dbg = C_RES[16*i +: 16];

        req = 1;
        //AB = A_OPS[16*i +: 16];
        AB = A_dbg;
        
        @(posedge ack);

        req = 0;

        @(negedge ack);

        req = 1;
        //AB = B_OPS[16*i +: 16];
        AB = B_dbg;

        @(posedge ack);

        #PERIOD;
        
        //`assert(C, C_RES[16*i +: 16]);
        `assert(C, C_dbg);

        req = 0;

        @(negedge ack);
    end

    @(posedge clk);
    $display("All tests passed!");
    $finish;

end
endmodule