`default_nettype none
`timescale 1ns / 1ps

module tb;
    parameter integer CLK_FREQ      = 100000000;
    parameter integer BAUDRATE      = 19200; //9600 19200 38400 57600 115200 460800 921600;
    parameter integer NO_RX_SAMPLES = 5;

    localparam real CLK_DURATION = (1000000000.0 / CLK_FREQ) / 2.0;
    localparam real BIT_DURATION = (1000000000.0 / BAUDRATE) - 0 * CLK_DURATION;
    localparam real DELAY        = (0.0 * BIT_DURATION);

    localparam integer NO_BITS = 10;
    localparam real    FINISH  = 2 * NO_BITS * BIT_DURATION;
     
    reg rx_data_in = 1'b1;
    reg clk        = 1'b0;
    reg rst_n      = 1'b1;
 
    always #CLK_DURATION clk = !clk;

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        #30    rst_n      = 1'b0;
        #35    rst_n      = 1'b1;
        #43242 rx_data_in = 1'b1;
        for (int i = 0; i < 1 * 4096; i++) begin
            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b1; // bit 0   55
            #BIT_DURATION    rx_data_in = 1'b0; // bit 1
            #BIT_DURATION    rx_data_in = 1'b1; // bit 2
            #BIT_DURATION    rx_data_in = 1'b0; // bit 3
            #BIT_DURATION    rx_data_in = 1'b1; // bit 4
            #BIT_DURATION    rx_data_in = 1'b0; // bit 5
            #BIT_DURATION    rx_data_in = 1'b1; // bit 6
            #BIT_DURATION    rx_data_in = 1'b0; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP

            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b0; // bit 0   5A
            #BIT_DURATION    rx_data_in = 1'b1; // bit 1
            #BIT_DURATION    rx_data_in = 1'b0; // bit 2
            #BIT_DURATION    rx_data_in = 1'b1; // bit 3
            #BIT_DURATION    rx_data_in = 1'b1; // bit 4
            #BIT_DURATION    rx_data_in = 1'b0; // bit 5
            #BIT_DURATION    rx_data_in = 1'b1; // bit 6
            #BIT_DURATION    rx_data_in = 1'b0; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP

            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b1; // bit 0   97
            #BIT_DURATION    rx_data_in = 1'b1; // bit 1
            #BIT_DURATION    rx_data_in = 1'b1; // bit 2
            #BIT_DURATION    rx_data_in = 1'b0; // bit 3
            #BIT_DURATION    rx_data_in = 1'b1; // bit 4
            #BIT_DURATION    rx_data_in = 1'b0; // bit 5
            #BIT_DURATION    rx_data_in = 1'b0; // bit 6
            #BIT_DURATION    rx_data_in = 1'b1; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP

            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b0; // bit 0   AA
            #BIT_DURATION    rx_data_in = 1'b1; // bit 1
            #BIT_DURATION    rx_data_in = 1'b0; // bit 2
            #BIT_DURATION    rx_data_in = 1'b1; // bit 3
            #BIT_DURATION    rx_data_in = 1'b0; // bit 4
            #BIT_DURATION    rx_data_in = 1'b1; // bit 5
            #BIT_DURATION    rx_data_in = 1'b0; // bit 6
            #BIT_DURATION    rx_data_in = 1'b1; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP

            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b1; // bit 0   FF
            #BIT_DURATION    rx_data_in = 1'b1; // bit 1
            #BIT_DURATION    rx_data_in = 1'b1; // bit 2
            #BIT_DURATION    rx_data_in = 1'b1; // bit 3
            #BIT_DURATION    rx_data_in = 1'b1; // bit 4
            #BIT_DURATION    rx_data_in = 1'b1; // bit 5
            #BIT_DURATION    rx_data_in = 1'b1; // bit 6
            #BIT_DURATION    rx_data_in = 1'b1; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP

            #BIT_DURATION    rx_data_in = 1'b0; // START
            #BIT_DURATION    rx_data_in = 1'b1; // bit 0   01
            #BIT_DURATION    rx_data_in = 1'b0; // bit 1
            #BIT_DURATION    rx_data_in = 1'b0; // bit 2
            #BIT_DURATION    rx_data_in = 1'b0; // bit 3
            #BIT_DURATION    rx_data_in = 1'b0; // bit 4
            #BIT_DURATION    rx_data_in = 1'b0; // bit 5
            #BIT_DURATION    rx_data_in = 1'b0; // bit 6
            #BIT_DURATION    rx_data_in = 1'b0; // bit 7
            #BIT_DURATION    rx_data_in = 1'b1; // STOP
            #DELAY           rx_data_in = 1'b1; // STOP
        end

        #FINISH $finish;
    end

    wire reg [ 7 : 0 ] ui_in;
    wire reg [ 7 : 0 ] uo_out;
    wire reg [ 7 : 0 ] uio_in;
    wire reg [ 7 : 0 ] uio_out;
    wire reg [ 7 : 0 ] uio_oe;
    wire reg           ena;

    wire reg rx_data_ready;
    wire reg rx_sample_clk;
    wire reg tx_data_out;
    wire reg tx_data_done;

    assign ui_in[ 0 ]    = rx_data_in;
    assign rx_data_ready = uo_out[ 0 ];
    assign rx_sample_clk = uo_out[ 1 ];
    assign tx_data_out   = uo_out[ 2 ];
    assign tx_data_done  = uo_out[ 3 ];
    tt_um_uart_bgdtanasa top(.ui_in(ui_in),     // Dedicated inputs
                             .uo_out(uo_out),   // Dedicated outputs
                             .uio_in(uio_in),   // IOs: Input path
                             .uio_out(uio_out), // IOs: Output path
                             .uio_oe(uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
                             .ena(ena),         // always 1 when the design is powered, so you can ignore it
                             .clk(clk),         // clock
                             .rst_n(rst_n));    // reset
endmodule
