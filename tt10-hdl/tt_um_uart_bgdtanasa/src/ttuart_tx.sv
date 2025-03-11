module ttuart_tx #(
    parameter integer CLK_FREQ = 50000000, // Hz
    parameter integer BAUDRATE = 115200,   // Hz
    parameter integer TX_IDX   = 0
) (
    input  wire           clk,
    input  wire           rst_n,
    input  wire           tx_do,
    output wire           tx_data_out,
    input  wire [ 7 : 0 ] tx_data,
    output wire           tx_data_done
);
    localparam integer                                TX_BAUD_DIVIDER    = (CLK_FREQ / BAUDRATE);
    localparam integer                                TX_BAUD_CNT_WIDTH  = $clog2(TX_BAUD_DIVIDER);
    localparam unsigned [ TX_BAUD_CNT_WIDTH - 1 : 0 ] TX_BAUD_WRAP       = TX_BAUD_DIVIDER[ TX_BAUD_CNT_WIDTH - 1 : 0 ] - 1;
    localparam integer                                NO_TX_BITS         = 11;
    localparam integer                                BIT_WIDTH          = $clog2(NO_TX_BITS);
    localparam unsigned [ BIT_WIDTH - 1 : 0 ]         BIT_WRAP           = NO_TX_BITS[ BIT_WIDTH - 1 : 0 ];
`ifdef EN_SIMULATION
    localparam real                                   REAL_BIT_TIME = (1000000000.0 / BAUDRATE);
`endif

    reg [ TX_BAUD_CNT_WIDTH - 1 : 0 ] tx_baudrate_cnt;
    reg [         BIT_WIDTH - 1 : 0 ] tx_bit_cnt;
    reg [        NO_TX_BITS - 1 : 0 ] tx_data_tmp;

`ifdef EN_SIMULATION
    real    this_time;
    integer no_tx_bytes;
    initial begin
        this_time   = $time;
        no_tx_bytes = 0;
    end
`endif

    assign tx_data_out  = tx_data_tmp[ tx_bit_cnt ];
    assign tx_data_done = (tx_bit_cnt == 0);

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            tx_baudrate_cnt <= 0;
            tx_bit_cnt      <= 0;
            tx_data_tmp     <= { 1'b1, 8'b0000_0000, 2'b01 };
        end else begin
            if (tx_data_done == 1'b0) begin
                if (tx_baudrate_cnt == TX_BAUD_WRAP) begin
`ifdef EN_SIMULATION
                    if (tx_bit_cnt == NO_TX_BITS - 1) begin
                        $display("%2d :: tx_err = %12.2f :: %h :: %12d",
                                    TX_IDX,
                                    ($time - this_time) - REAL_BIT_TIME * (NO_TX_BITS - 1),
                                    tx_data_tmp[ 9 : 2],
                                    no_tx_bytes);
                        this_time   = $time;
                        no_tx_bytes = no_tx_bytes + 1;
                    end
`endif

                    tx_baudrate_cnt <= 0;
                    tx_bit_cnt      <= (tx_bit_cnt == BIT_WRAP - 1) ? (0) : (tx_bit_cnt + 1);
                end else begin
                    tx_baudrate_cnt <= tx_baudrate_cnt + 1;
                    tx_bit_cnt      <= tx_bit_cnt;
                end
                tx_data_tmp         <= tx_data_tmp;
            end else begin
                if (tx_do == 1'b1) begin
`ifdef EN_SIMULATION
                    if ((tx_data != 8'h55) &&
                        (tx_data != 8'h5A) &&
                        (tx_data != 8'h97) &&
                        (tx_data != 8'hAA) &&
                        (tx_data != 8'hFF) &&
                        (tx_data != 8'h01)) begin
                        $display("%2d :: %16.5f %02d tx_data = %h", TX_IDX, $time, TX_IDX, tx_data);
                        $finish;
                    end
`endif
                    tx_baudrate_cnt <= 0;
                    tx_bit_cnt      <= 1;
                    tx_data_tmp     <= { 1'b1, tx_data, 2'b01 };
                end else begin
                    tx_baudrate_cnt <= 0;
                    tx_bit_cnt      <= 0;
                    tx_data_tmp     <= { 1'b1, 8'b0000_0000, 2'b01 };
                end
            end
        end
    end
endmodule
