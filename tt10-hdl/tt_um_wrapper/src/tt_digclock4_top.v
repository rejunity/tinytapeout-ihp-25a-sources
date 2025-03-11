`default_nettype none
//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FH JOANNEUM
// Engineer: Patrick Lampl
// 
// Create Date: 08.01.2025 17:57:43
// Module Name: tt_digclock3_top
// Target Devices: Basys3 / TT-10
// Tool Versions: Vivado 2019.1
//
// Revision: 
// Revision 0.01 - File Created
// Revision 1.0 - first working version for sim and synthesis
// Revision 1.1 - more FF no bin2BCD convertion
// Revision 1.2 - less comparisions but up to 6 cycle overflow latency
// Revision 1.3	- fixed a few bugs, removed SIM parameter
// Revision 1.4 - separated async reset and functional reset
// 
//////////////////////////////////////////////////////////////////////////////////


module tt_digclock4_top 
    (
    input wire clk_i,
    input wire rstn_i,
    input wire [1:0] pb_i,
    output reg [7:0] seg_o,
    output reg [5:0] sel_o
    );
    
    reg p4digit; //pulse every ~3.25ms
     //input sync, downsample for debouncing and rising edge detection
    reg [3:0] pb_sreg [0:1]; //array of pushbutton vector
    reg [1:0] pb_rise ; //vector for pushbutton rising edge strobes
    genvar i;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            //4bit shift reg 
            always @(posedge clk_i, negedge rstn_i) begin
                if (!rstn_i)
                    pb_sreg[i] <= 0;
                else begin
                    //shift LSBs at every clock cycle
                    pb_sreg[i][1:0] <= {pb_sreg[i][0], pb_i[i]};
                    //shift bit 2 only when enabled by p4digit every ~3.25ms
                    if (p4digit) pb_sreg[i][2] <= pb_sreg[i][1]; 
                    //shift MSB always at clock speed
                    pb_sreg[i][3] <= pb_sreg[i][2];
                end
            end 
            // edge detection
            always @* begin
                pb_rise[i] = ~pb_sreg[i][3] & pb_sreg[i][2]; 
            end
        end  
    endgenerate
    
    //15 bit counter veriable
    reg [14:0] clkcnt; //3:0 for SIM, 14:0 for REAL TIME
    // 15 bit counter for timing seconds
    always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i) begin
        clkcnt <= 0; // Reset count to 0
    end else begin
        clkcnt <= clkcnt + 1; // Increment count
        end
    end
    
    // comparators for strobes
    reg pps;
    // pulse per second strobe gen
    always @* begin if (clkcnt == 2**15-1) pps = 1; else pps = 0; end //2^4-1 for SIM, 2^15 for REAL TIME 
    // pulse per ~3.25ms for muxing segments
    always @* begin if (clkcnt[5:0] == 2**6-1) p4digit = 1; else p4digit = 0; end //0:0 and 2^1-1 for SIM, 5:0 and 2^6-1 for REAL TIME
    
    
  // 4 bit counters for so mo and ho
    reg [3:0] so, st, mo, mt, ho, ht;
    //so counter
    always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i)
		so <= 0; // Reset count to 0
	else if (so == 10)
        so <= 0; // Reset count to 0
    else if (pps)
        so <= so + 1; // Increment count
    end
	//ten so counter
	always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i)
		st <= 0; // Reset count to 0
	else if (st == 6)
        st <= 0; // Reset count to 0
    else if (so == 10)
        st <= st + 1; // Increment count
    end
    //mo counter
    always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i) 
        mo <= 0; // Reset count to 0
	else if (mo == 10)
		mo <= 0; // Reset count to 0
    else if (st == 6 || pb_rise[0])
        mo <= mo + 1; // Increment count
    end
	//ten mo counter
    always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i) 
	    mt <= 0; // Reset count to 0
	else if (mt == 6)
		mt <= 0; // Reset count to 0
    else if (mo == 10)
        mt <= mt + 1; // Increment count
    end
    //ho counter
    always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i)
        ho <= 0; // Reset count to 0
	else if ((ht == 2 && ho == 4) || ho == 10)
		ho <= 0; // Reset count to 0
    else if (mt == 6 || pb_rise[1])
        ho <= ho + 1; // Increment count
    end
	//ten ho counter
	always @(posedge clk_i, negedge rstn_i) begin
    if (!rstn_i)
        ht <= 0; // Reset count to 0
	else if (ht == 2 && ho == 4)
		ht <= 0; // Reset count to 0
    else if (ho == 10)
        ht <= ht + 1; // Increment count
    end
    
    
    //counter to switch between BCD digits
    reg [2:0] sel;
    always @(posedge clk_i, negedge rstn_i) begin
        if (!rstn_i)
		    sel <= 0;
		else if (sel == 5 && p4digit)
			sel <= 0;
        else if (p4digit)
            sel <= sel + 1;
    end
    
    //one hot decoder for sel to drive digits
    always @* begin
    case(sel)
        3'b000: sel_o = 6'b111110; 
        3'b001: sel_o = 6'b111101; 
        3'b010: sel_o = 6'b111011; 
        3'b011: sel_o = 6'b110111; 
        3'b100: sel_o = 6'b101111; 
        3'b101: sel_o = 6'b011111; 
       default: sel_o = 6'b111111; // Default or invalid case
    endcase
    end
    
    //BCD mux 6 to 1
    reg [3:0] bcd;
    always @* begin
    case(sel)
        3'b000: bcd = so; // Select "so"
        3'b001: bcd = st; // Select "st"
        3'b010: bcd = mo; // Select "mo"
        3'b011: bcd = mt; // Select "mt"
        3'b100: bcd = ho; // Select "ho"
        3'b101: bcd = ht; // Select "ht"
       default: bcd = 4'b0000; // Default or invalid case
    endcase
    end
    
    //seven segment decoder
    reg [6:0] seg;
    always @* begin
    case(bcd)  //seg code:abcdefg  active low 
        4'b0000: seg = 7'b0000001; // 0
        4'b0001: seg = 7'b1001111; // 1
        4'b0010: seg = 7'b0010010; // 2
        4'b0011: seg = 7'b0000110; // 3
        4'b0100: seg = 7'b1001100; // 4
        4'b0101: seg = 7'b0100100; // 5
        4'b0110: seg = 7'b0100000; // 6
        4'b0111: seg = 7'b0001111; // 7
        4'b1000: seg = 7'b0000000; // 8
        4'b1001: seg = 7'b0000100; // 9
        default: seg = 7'b1111111; // Off or invalid BCD code
    endcase
end

 //setting dot behaviour for each digit
    reg dot;
    always @* begin
    case(sel)
        3'b000: dot = 1'b1; //so
        3'b001: dot = 1'b1; //st
        3'b010: dot = clkcnt[14]; //mo add MSB of sec counter, 3 for SIM 14 for REAL time
        3'b011: dot = 1'b1; //mt
        3'b100: dot = ~clkcnt[14]; //ho add inv MSB of sec counter, 3 for SIM 14 for REAL time
        3'b101: dot = 1'b1; //ht
       default: dot = 1'b1;// Default or invalid case
    endcase
    end
    
    //assign seg_o output
    always @* seg_o = {dot, seg};
    
endmodule
`default_nettype wire