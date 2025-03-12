// Heavily based on the "Checkers" VGA playground example by Renaldas Zioma & Uri Shaked (Apache-2.0)

`default_nettype none

module tt_um_htfab_checkers (
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,   // Dedicated outputs
  input  wire [7:0] uio_in,   // IOs: Input path
  output wire [7:0] uio_out,  // IOs: Output path
  output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // always 1 when the design is powered, so you can ignore it
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);

wire hsync, vsync, video_active;
wire [1:0] R, G, B;
wire [9:0] pix_x, pix_y;

reg [9:0] counter;
always @(posedge clk) begin
  if (~rst_n) begin
    counter <= 0;
  end else if (pix_x == 0 && pix_y == 0) begin
    counter <= counter + 1;
  end
end  

wire [2:0] color_main = 3'b100 ^ {ui_in[0], ui_in[1], ui_in[2]};     // default to red
wire [2:0] color_sub = color_main ^ {ui_in[3], ui_in[4], ui_in[5]};  // default to same as main
wire foreground = ~ui_in[6];                                         // default to white
wire background = ui_in[7];                                          // default to black
wire [7:0] switches = {background, foreground, color_sub, color_main};
wire [5:0] layers [6:0];
assign layers[0] = {6{background}};

layer_e inst_e (.pix_x, .pix_y, .counter, .switches, .below(layers[0]), .above(layers[1]));
layer_d inst_d (.pix_x, .pix_y, .counter, .switches, .below(layers[1]), .above(layers[2]));
layer_c inst_c (.pix_x, .pix_y, .counter, .switches, .below(layers[2]), .above(layers[3]));
layer_b inst_b (.pix_x, .pix_y, .counter, .switches, .below(layers[3]), .above(layers[4]));
layer_a inst_a (.pix_x, .pix_y, .counter, .switches, .below(layers[4]), .above(layers[5]));

assign {R, G, B} = video_active ? layers[5] : 6'b00_00_00;

assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};
assign uio_out = 0;
assign uio_oe  = 0;
wire _unused_ok = &{ena, uio_in, 1'b0};

hvsync_generator hvsync_gen(
  .clk(clk),
  .reset(~rst_n),
  .hsync(hsync),
  .vsync(vsync),
  .display_on(video_active),
  .hpos(pix_x),
  .vpos(pix_y)
);

endmodule

