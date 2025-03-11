module ttuart_top #(
    parameter integer CLK_FREQ      = 100000000, // Hz
    parameter integer BAUDRATE      = 115200,    // Hz
    parameter integer NO_RX_SAMPLES = 3,
    parameter integer UART_IDX      = 0
) (
    input  wire            clk,
    input  wire            rst_n,
    // Rx
    input  wire            rx_data_in,
    output wire [ 7 : 0 ]  rx_data,
    output wire            rx_data_ready,
    output reg             rx_sample_clk,
    // Tx
    input  wire            tx_do,
    output wire            tx_data_out,
    input  wire [ 7 : 0 ]  tx_data,
    output wire            tx_data_done
);
    reg rx_data_in_buf;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            rx_data_in_buf <= 1'b1;
        end else begin
            rx_data_in_buf <= rx_data_in;
        end
    end

    ttuart_rx #(.CLK_FREQ(CLK_FREQ),
                .BAUDRATE(BAUDRATE),
                .NO_RX_SAMPLES(NO_RX_SAMPLES),
                .RX_IDX(UART_IDX)) rx(.clk(clk),
                                      .rst_n(rst_n),
                                      .rx_data_in(rx_data_in_buf),
                                      .rx_data(rx_data),
                                      .rx_data_ready(rx_data_ready),
                                      .rx_sample_clk(rx_sample_clk));

    ttuart_tx #(.CLK_FREQ(CLK_FREQ),
                .BAUDRATE(BAUDRATE),
                .TX_IDX(UART_IDX)) tx(.clk(clk),
                                      .rst_n(rst_n),
                                      .tx_do(tx_do),
                                      .tx_data_out(tx_data_out),
                                      .tx_data(tx_data),
                                      .tx_data_done(tx_data_done));
endmodule
