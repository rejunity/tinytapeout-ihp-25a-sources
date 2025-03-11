module ttuart_rx #(
    parameter integer CLK_FREQ      = 100000000, // Hz
    parameter integer BAUDRATE      = 115200,    // Hz
    parameter integer NO_RX_SAMPLES = 3,
    parameter integer RX_IDX        = 0
) (
    input  wire           clk,
    input  wire           rst_n,
    input  wire           rx_data_in,
    output wire [ 7 : 0 ] rx_data,
    output wire           rx_data_ready,
    output reg            rx_sample_clk
);
    localparam integer                                  RX_SAMPLE_DIVIDER   = (CLK_FREQ) / (NO_RX_SAMPLES * BAUDRATE);
    localparam integer                                  RX_SAMPLE_CNT_WIDTH = $clog2(RX_SAMPLE_DIVIDER) + 2;
    localparam unsigned [ RX_SAMPLE_CNT_WIDTH - 1 : 0 ] RX_SAMPLE_WRAP      = RX_SAMPLE_DIVIDER[ RX_SAMPLE_CNT_WIDTH - 1 : 0 ] - 1;

    localparam integer NO_RX_BITS         = 10;
    localparam integer REG_SAMPLES_LENGTH = NO_RX_BITS * NO_RX_SAMPLES;
    localparam integer REG_SAMPLES_WIDTH  = $clog2(REG_SAMPLES_LENGTH);

    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] NO_SAMPLES      = NO_RX_SAMPLES[ REG_SAMPLES_WIDTH - 1 : 0 ] / 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] NO_SAMPLES_HALF = NO_RX_SAMPLES[ REG_SAMPLES_WIDTH - 1 : 0 ] / 2;

    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_START_X = REG_SAMPLES_LENGTH[ REG_SAMPLES_WIDTH - 1 : 0 ];
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_START_E = BIT_START_X - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_START_B = BIT_START_E - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_0_E     = BIT_START_B - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_0_B     = BIT_0_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_1_E     = BIT_0_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_1_B     = BIT_1_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_2_E     = BIT_1_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_2_B     = BIT_2_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_3_E     = BIT_2_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_3_B     = BIT_3_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_4_E     = BIT_3_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_4_B     = BIT_4_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_5_E     = BIT_4_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_5_B     = BIT_5_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_6_E     = BIT_5_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_6_B     = BIT_6_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_7_E     = BIT_6_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_7_B     = BIT_7_E     - NO_SAMPLES + 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_STOP_E  = BIT_7_B     - 1;
    localparam unsigned [ REG_SAMPLES_WIDTH - 1 : 0 ] BIT_STOP_B  = BIT_STOP_E  - NO_SAMPLES + 1;

    localparam real                                     CLK_TIME      = (1000000000.0 / CLK_FREQ);
    localparam real                                     REAL_BIT_TIME = (1000000000.0 / BAUDRATE);
    localparam real                                     RX_BIT_TIME   = (RX_SAMPLE_DIVIDER * NO_RX_SAMPLES) * CLK_TIME;
    localparam real                                     ERR_BIT_TIME  = (REAL_BIT_TIME - RX_BIT_TIME);
    localparam unsigned [ RX_SAMPLE_CNT_WIDTH - 1 : 0 ] ERR_BIT_ADJ   = $rtoi(ERR_BIT_TIME / CLK_TIME);

    reg [ RX_SAMPLE_CNT_WIDTH - 1 : 0 ] rx_sample_wrap;
    reg [   REG_SAMPLES_WIDTH - 1 : 0 ] rx_sample_cnt;
    reg [ RX_SAMPLE_CNT_WIDTH - 1 : 0 ] rx_sample_clk_cnt;
    reg [  REG_SAMPLES_LENGTH - 1 : 0 ] rx_samples;
    reg [   REG_SAMPLES_WIDTH - 1 : 0 ] rx_marker;
    reg [   REG_SAMPLES_WIDTH - 1 : 0 ] rx_stop_zeros;

    wire rx_bit_start;
    wire rx_bit_0;
    wire rx_bit_1;
    wire rx_bit_2;
    wire rx_bit_3;
    wire rx_bit_4;
    wire rx_bit_5;
    wire rx_bit_6;
    wire rx_bit_7;
    wire rx_bit_stop;

    function get_bit;
        input [ REG_SAMPLES_LENGTH - 1 : 0 ] samples;
        input [  REG_SAMPLES_WIDTH - 1 : 0 ] a;
        input [  REG_SAMPLES_WIDTH - 1 : 0 ] b;

        logic [ REG_SAMPLES_WIDTH - 1 : 0 ] no_ones;
        logic [ REG_SAMPLES_WIDTH - 1 : 0 ] i;
    begin
        no_ones = 0;
        for (i = a; i <= b; i = i + 1) begin
            no_ones = no_ones + { { REG_SAMPLES_WIDTH - 1{ 1'b0 } }, samples[ i ] };
        end

        get_bit = (no_ones > NO_SAMPLES_HALF);
    end
    endfunction

    assign rx_bit_start = get_bit(rx_samples, BIT_START_B, BIT_START_E);
    assign rx_bit_0     = get_bit(rx_samples, BIT_0_B,     BIT_0_E);
    assign rx_bit_1     = get_bit(rx_samples, BIT_1_B,     BIT_1_E);
    assign rx_bit_2     = get_bit(rx_samples, BIT_2_B,     BIT_2_E);
    assign rx_bit_3     = get_bit(rx_samples, BIT_3_B,     BIT_3_E);
    assign rx_bit_4     = get_bit(rx_samples, BIT_4_B,     BIT_4_E);
    assign rx_bit_5     = get_bit(rx_samples, BIT_5_B,     BIT_5_E);
    assign rx_bit_6     = get_bit(rx_samples, BIT_6_B,     BIT_6_E);
    assign rx_bit_7     = get_bit(rx_samples, BIT_7_B,     BIT_7_E);
    assign rx_bit_stop  = get_bit(rx_samples, BIT_STOP_B,  BIT_STOP_E);
    assign rx_data_ready = ((rx_bit_start == 1'b0) && (rx_bit_stop == 1'b1) && (rx_marker == BIT_START_E));
    assign rx_data       = (rx_data_ready == 1'b1) ? ({ rx_bit_7, rx_bit_6, rx_bit_5, rx_bit_4, rx_bit_3, rx_bit_2, rx_bit_1, rx_bit_0 }) : (8'b0000_0000);

`ifdef EN_SIMULATION
    real    this_time;
    real    total_err;
    integer no_rx_bytes;
    initial begin
        this_time   = $time;
        total_err   = 0.0;
        no_rx_bytes = 0;
        $display("          CLK_FREQ = %12d :: %12.5f", CLK_FREQ, CLK_TIME);
        $display("          BAUDRATE = %12d", BAUDRATE);
        $display("     NO_RX_SAMPLES = %12d", NO_RX_SAMPLES);
        $display("REG_SAMPLES_LENGTH = %12d", REG_SAMPLES_LENGTH);
        $display(" REG_SAMPLES_WIDTH = %12d", REG_SAMPLES_WIDTH);
        $display("      ERR_BIT_TIME = %12.5f :: %12.5f", ERR_BIT_TIME, ERR_BIT_ADJ);
    end
`endif

    logic [ REG_SAMPLES_WIDTH - 1 : 0 ] i;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            rx_sample_clk     <= 1'b0;
            rx_sample_wrap    <= RX_SAMPLE_WRAP;
            rx_sample_cnt     <= 0;
            rx_sample_clk_cnt <= 0;

            rx_samples    <= { REG_SAMPLES_LENGTH{ 1'b1 } };
            rx_marker     <= BIT_START_X;
            rx_stop_zeros <= 0;
        end else begin
            if ((rx_marker >= BIT_START_X) && (rx_data_in == 1'b1)) begin
                rx_sample_clk     <= 1'b0;
                rx_sample_wrap    <= RX_SAMPLE_WRAP;
                rx_sample_cnt     <= 0;
                rx_sample_clk_cnt <= 0;

                rx_samples    <= { REG_SAMPLES_LENGTH{ 1'b1 } };
                rx_marker     <= BIT_START_X;
                rx_stop_zeros <= 0;
            end else if ((rx_marker >= BIT_START_X) && (rx_data_in == 1'b0)) begin
                rx_sample_clk     <= 1'b1;
                rx_sample_wrap    <= RX_SAMPLE_WRAP;
                rx_sample_cnt     <= 0;
                rx_sample_clk_cnt <= 0;

                for (i = BIT_STOP_B; i <= BIT_START_E; i = i + 1) begin
                    rx_samples[ i ] <= (i >= rx_stop_zeros + 1);
                end
                rx_marker     <= rx_stop_zeros;
                rx_stop_zeros <= 0;
            end else begin
                if (rx_sample_clk_cnt == rx_sample_wrap) begin
                    rx_sample_clk <= ~rx_sample_clk;
                    if (rx_sample_cnt <= NO_SAMPLES - 3) begin
                        rx_sample_wrap <= RX_SAMPLE_WRAP;
                        rx_sample_cnt  <= rx_sample_cnt + 1;
                    end else if (rx_sample_cnt == NO_SAMPLES - 2) begin
                        rx_sample_wrap <= RX_SAMPLE_WRAP + ERR_BIT_ADJ;
                        rx_sample_cnt  <= rx_sample_cnt + 1;
                    end else if (rx_sample_cnt == NO_SAMPLES - 1) begin
                        rx_sample_wrap <= RX_SAMPLE_WRAP;
                        rx_sample_cnt  <= 0;
                    end
                    rx_sample_clk_cnt <= 0;

                    rx_samples <= (rx_marker <= BIT_START_E - 1) ? ({ rx_samples[ BIT_START_E - 1 : BIT_STOP_B ], rx_data_in }) : (rx_samples);
                    rx_marker  <= (rx_marker <= BIT_START_E - 1) ? (rx_marker + 1)                                              : (BIT_START_X);
                    if (rx_marker <= BIT_START_B + 2) begin
                        rx_stop_zeros <= 0;
                    end else if (rx_marker == BIT_START_B + 3) begin
                        if (rx_data_in == 1'b0) begin
                            rx_stop_zeros <= 1;
                        end else begin
                            rx_stop_zeros <= 0;
                        end
                    end else if (rx_marker <= BIT_START_E - 1) begin
                        if ((rx_samples[ 0 ] == 1'b1) && (rx_data_in == 1'b0)) begin
                            rx_stop_zeros <= 1;
                        end else if ((rx_samples[ 0 ] == 1'b0) && (rx_data_in == 1'b0)) begin
                            rx_stop_zeros <= rx_stop_zeros + 1;
                        end else begin
                            rx_stop_zeros <= 0;
                        end
                    end else begin
                        rx_stop_zeros <= rx_stop_zeros;
                    end
                end else begin
                    rx_sample_clk     <= rx_sample_clk;
                    rx_sample_wrap    <= rx_sample_wrap;
                    rx_sample_cnt     <= rx_sample_cnt;
                    rx_sample_clk_cnt <= rx_sample_clk_cnt + 1;

                    rx_samples    <= rx_samples;
                    rx_marker     <= rx_marker;
                    rx_stop_zeros <= rx_stop_zeros;
                end
            end
        end
    end
`ifdef EN_SIMULATION
    always @(negedge rx_data_ready) begin
        if (no_rx_bytes >= 1) begin
            if (no_rx_bytes >= 2) begin
                total_err  += ($time - this_time) - REAL_BIT_TIME * NO_RX_BITS;
            end
            $display("%2d :: rx_err = %12.2f :: %h :: %12d",
                        RX_IDX,
                        total_err / (no_rx_bytes - 1),
                        rx_data,
                        no_rx_bytes);
            this_time   = $time;

            if ((rx_data != 8'h55) &&
                (rx_data != 8'h5A) &&
                (rx_data != 8'h97) &&
                (rx_data != 8'hAA) &&
                (rx_data != 8'hFF) &&
                (rx_data != 8'h01)) begin
                $display("%2d :: %16.5f %02d rx_data = %h", RX_IDX, $time, RX_IDX, rx_data);
                //$finish;
            end
        end
        no_rx_bytes = no_rx_bytes + 1;
    end
`endif
endmodule
