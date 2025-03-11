/*

    Module seven_seg displays an 8-bit value on a 7-segment display.
    When `valid` is set, we latch the value `val` and display it iff
    `disp_off` is 0.

*/
module seven_seg #(
    parameter   UPSIDE_DOWN = 0      // Digilent 7-seg PMOD installs 7-seg upside down (use UPSIDE_DOWN=1)
                                     // Otherwise, use UPSIDE_DOWN=0
) (
    input              clk,
    input              rst_n,        // global reset

    input              disp_off,     // 1 to turn off display, 0 to turn on

    input              valid,        // 1 to update dispaly with new `val` value
    input        [7:0] val,          // the 2-digit hex value to display

    // 7-segment display lines
    output wire        cathode,      // cathode=0 is left, 1 is right
    output wire        aa,
    output wire        ab,
    output wire        ac,
    output wire        ad,
    output wire        ae,
    output wire        af,
    output wire        ag
);

    //
    // Bitmaps for 7-segment display digits
    // 
    //    ~~ Digit ~~    // ~~ Segment Names & Bit Indices ~~
    //                   //
    //        d          //
    //       ---         //             d/reg[3]
    //   c |     | e     //  c/reg[4]             e/reg[2]
    //       -f-         //             f/reg[1]
    //   b |     | g     //  b/reg[5]             g/reg[0]
    //       ---         //             a/reg[6]
    //        a          // 

    //                                            abc_defg :    deg_abfc
    localparam bitmap_blank    = UPSIDE_DOWN ? 7'b000_0000 : 7'b000_0000;
    localparam bitmap_0        = UPSIDE_DOWN ? 7'b111_1101 : 7'b111_1101;
    localparam bitmap_1        = UPSIDE_DOWN ? 7'b000_0101 : 7'b011_0000;
    localparam bitmap_2        = UPSIDE_DOWN ? 7'b110_1110 : 7'b110_1110;
    localparam bitmap_3        = UPSIDE_DOWN ? 7'b100_1111 : 7'b111_1010;
    localparam bitmap_4        = UPSIDE_DOWN ? 7'b001_0111 : 7'b011_0011;
    localparam bitmap_5        = UPSIDE_DOWN ? 7'b101_1011 : 7'b101_1011;
    localparam bitmap_6        = UPSIDE_DOWN ? 7'b111_1011 : 7'b101_1111;
    localparam bitmap_7        = UPSIDE_DOWN ? 7'b000_1101 : 7'b111_0000;
    localparam bitmap_8        = UPSIDE_DOWN ? 7'b111_1111 : 7'b111_1111;
    localparam bitmap_9        = UPSIDE_DOWN ? 7'b001_1111 : 7'b111_0011;
    localparam bitmap_a        = UPSIDE_DOWN ? 7'b011_1111 : 7'b111_0111;
    localparam bitmap_b        = UPSIDE_DOWN ? 7'b111_0011 : 7'b001_1111;
    localparam bitmap_c        = UPSIDE_DOWN ? 7'b110_0010 : 7'b000_1110;
    localparam bitmap_d        = UPSIDE_DOWN ? 7'b110_0111 : 7'b011_1110;
    localparam bitmap_e        = UPSIDE_DOWN ? 7'b111_1010 : 7'b100_1111;
    localparam bitmap_f        = UPSIDE_DOWN ? 7'b011_1010 : 7'b100_0111;

    // function to turn 4-bit number into 7-segment bitmap
    function [6:0] get_bitmap(input [3:0] n);
        begin
            case(n)
                4'h0: get_bitmap = bitmap_0;
                4'h1: get_bitmap = bitmap_1;
                4'h2: get_bitmap = bitmap_2;
                4'h3: get_bitmap = bitmap_3;
                4'h4: get_bitmap = bitmap_4;
                4'h5: get_bitmap = bitmap_5;
                4'h6: get_bitmap = bitmap_6;
                4'h7: get_bitmap = bitmap_7;
                4'h8: get_bitmap = bitmap_8;
                4'h9: get_bitmap = bitmap_9;
                4'ha: get_bitmap = bitmap_a;
                4'hb: get_bitmap = bitmap_b;
                4'hc: get_bitmap = bitmap_c;
                4'hd: get_bitmap = bitmap_d;
                4'he: get_bitmap = bitmap_e;
                4'hf: get_bitmap = bitmap_f;
            endcase
        end 
    endfunction

    localparam LEFT                            = 0;
    localparam RIGHT                           = 1;
    reg [3:0] val_digit [1:0];
    reg [6:0] bitmap    [1:0];
    reg       cathode_r;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            val_digit[LEFT]        <= 4'd0000;
            val_digit[RIGHT]       <= 4'd0000;
            bitmap[LEFT]           <= bitmap_blank;
            bitmap[RIGHT]          <= bitmap_blank;
            cathode_r              <= 0;
        end else begin
            if (valid) begin
                val_digit[LEFT]    <= (val[7:4]);
                val_digit[RIGHT]   <= (val[3:0]);
            end

            cathode_r              <= ~cathode_r;

            bitmap[LEFT]           <= (!disp_off) ? get_bitmap(val_digit[UPSIDE_DOWN ? LEFT : RIGHT]) : bitmap_blank;
            bitmap[RIGHT]          <= (!disp_off) ? get_bitmap(val_digit[UPSIDE_DOWN ? RIGHT : LEFT]) : bitmap_blank;
        end
    end
    
    assign cathode = cathode_r;
    assign {aa, ab, ac, ad, ae, af, ag} = cathode_r ? bitmap[RIGHT] : bitmap[LEFT];
endmodule