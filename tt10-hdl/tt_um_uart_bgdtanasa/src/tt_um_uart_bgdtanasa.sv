`default_nettype none

module tt_um_uart_bgdtanasa (
    input  wire [ 7 : 0 ] ui_in,    // Dedicated inputs
    output wire [ 7 : 0 ] uo_out,   // Dedicated outputs
    input  wire [ 7 : 0 ] uio_in,   // IOs: Input path
    output wire [ 7 : 0 ] uio_out,  // IOs: Output path
    output wire [ 7 : 0 ] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire           ena,      // always 1 when the design is powered, so you can ignore it
    input  wire           clk,      // clock
    input  wire           rst_n     // reset_n - low to reset
);
    localparam integer CLK_FREQ      = 50000000; // Hz
    localparam integer BAUDRATE      = 115200;   // Hz
    localparam integer NO_RX_SAMPLES = 9;

    wire rx_data_in;
    wire rx_data_ready;
    reg  rx_sample_clk;
    wire tx_data_out;
    wire tx_data_done;

    assign rx_data_in  = ui_in[ 0 ];
    assign uo_out[ 0 ] = rx_data_ready;
    assign uo_out[ 1 ] = rx_sample_clk;
    assign uo_out[ 2 ] = tx_data_out;
    assign uo_out[ 3 ] = tx_data_done;
    assign uo_out[ 4 ] = 1'b0;
    assign uo_out[ 5 ] = 1'b0;
    assign uo_out[ 6 ] = 1'b0;
    assign uo_out[ 7 ] = 1'b0;
    assign uio_out = 0;
    assign uio_oe  = 0;

    wire _unused_pins = |{ ui_in[ 7 : 1 ], uio_in[ 7 : 0 ], ena };

    wire [ 7 : 0 ] rx_data;
    reg            tx_do;
    reg [ 7 : 0 ]  tx_data;

    reg         clk_out;
    reg [3 : 0] clk_out_cnt;
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            clk_out     <= 1'b0;
            clk_out_cnt <= 4'b0000;
        end else begin
            if (clk_out_cnt == 4'b0000) begin
                clk_out     <= ~clk_out;
                clk_out_cnt <= 4'b0000;
            end else begin
                clk_out     <= clk_out;
                clk_out_cnt <= clk_out_cnt + 4'b0001;
            end
        end
    end

    ttuart_top #(.CLK_FREQ(CLK_FREQ / 2),
                 .BAUDRATE(BAUDRATE),
                 .NO_RX_SAMPLES(NO_RX_SAMPLES),
                 .UART_IDX(0)) uart_0(.clk(clk_out),
                                      .rst_n(rst_n),
                                      .rx_data_in(rx_data_in),
                                      .rx_data(rx_data),
                                      .rx_data_ready(rx_data_ready),
                                      .rx_sample_clk(rx_sample_clk),
                                      .tx_do(tx_do),
                                      .tx_data_out(tx_data_out),
                                      .tx_data(tx_data),
                                      .tx_data_done(tx_data_done));

    localparam integer FIFO_DEPTH     = 16;
    localparam integer FIFO_CNT_WIDTH = $clog2(FIFO_DEPTH);
    integer i;

    reg [                  7 : 0 ] fifo_d[ FIFO_DEPTH - 1 : 0 ];
    reg [ FIFO_CNT_WIDTH - 1 : 0 ] fifo_h;
    reg [ FIFO_CNT_WIDTH - 1 : 0 ] fifo_t;

    always @(posedge rx_sample_clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
                fifo_d[ i ] <= 8'b0000_0000;
            end
            fifo_t      <= { FIFO_CNT_WIDTH{ 1'b0 } };
        end else begin
            if (rx_data_ready == 1'b1) begin
                if (fifo_t + 1'b1 != fifo_h) begin
                    fifo_d[ fifo_t ] <= rx_data;
                    fifo_t           <= fifo_t + 1'b1;
                end else begin
                    fifo_d[ fifo_t ] <= 8'b0000_0000;
                    fifo_t           <= fifo_t;
                end
            end else begin
                fifo_d[ fifo_t ] <= 8'b0000_0000;
                fifo_t           <= fifo_t;
            end
        end
    end
    always @(posedge clk_out or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            tx_do   <= 1'b0;
            tx_data <= 8'b0000_0000;
            fifo_h  <= { FIFO_CNT_WIDTH{ 1'b0 } };
        end else begin
            if (tx_data_done == 1'b1) begin
                if (fifo_h != fifo_t) begin
                    tx_do   <= 1'b1;
                    tx_data <= fifo_d[ fifo_h ];
                    fifo_h  <= fifo_h + 1'b1;
                end else begin
                    tx_do   <= 1'b0;
                    tx_data <= 8'b0000_0000;
                    fifo_h  <= fifo_h;
                end
            end else begin
                tx_do   <= 1'b0;
                tx_data <= 8'b0000_0000;
                fifo_h  <= fifo_h;
            end
        end
    end
endmodule
