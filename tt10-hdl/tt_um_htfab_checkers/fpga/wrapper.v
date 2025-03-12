`default_nettype none

module wrapper(
    input wire clk_100m,
    input wire clk_50m,
    input wire clk_25m,
    input wire rst_n,
    input wire [15:0] switches,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue,
    output wire hsync,
    output wire vsync,
    output wire audio 
);

wire [7:0] uo_out;
wire [7:0] uio_out;
wire [7:0] uio_oe;

tt_um_htfab_checkers i_project(
    .ui_in(switches[7:0]),
    .uo_out(uo_out),
    .uio_in(switches[15:8]),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(1'b1),
    .clk(clk_25m),
    .rst_n
);

assign red = {uo_out[0], uo_out[4], uo_out[0], uo_out[4]};
assign green = {uo_out[1], uo_out[5], uo_out[1], uo_out[5]};
assign blue = {uo_out[2], uo_out[6], uo_out[2], uo_out[6]};
assign hsync = uo_out[7];
assign vsync = uo_out[3];
assign audio = uio_out[7];

wire _unused = &{uio_out[6:0], uio_oe, 1'b0};

endmodule
