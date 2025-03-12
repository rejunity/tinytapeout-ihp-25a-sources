`default_nettype none

module fpga_top(
    input wire clk,
    input wire btnC,
    input wire btnU,
    input wire btnL,
    input wire btnR,
    input wire btnD,
    input wire [15:0] sw,
    output wire [15:0] led,
    output wire [7:0] JB,
    output wire [7:0] JC,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire hsync,
    output wire vsync
);

reg rst_n;
reg clk_25m;
reg clk_50m;

initial begin
    rst_n <= 0;
end

always @(posedge clk) begin
    {clk_25m, clk_50m} <= {clk_25m, clk_50m} + 1;
end

always @(posedge clk_25m) begin
    rst_n <= ~btnC;
end

wire audio;
wrapper i_wrapper(
    .clk_100m(clk),
    .clk_50m(clk_50m),
    .clk_25m(clk_25m),
    .rst_n(rst_n),
    .switches(sw),
    .red(vgaRed),
    .green(vgaGreen),
    .blue(vgaBlue),
    .hsync(hsync),
    .vsync(vsync),
    .audio(audio)
);

assign JB = {hsync, vgaBlue[2], vgaGreen[2], vgaRed[2], vsync, vgaBlue[3], vgaGreen[3], vgaRed[3]};
assign JC = {(8){audio}};
assign led = sw;

endmodule
