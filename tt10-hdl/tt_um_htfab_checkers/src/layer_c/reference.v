`default_nettype none

module layer_c (
  input wire [9:0] pix_x,
  input wire [9:0] pix_y,
  input wire [9:0] counter,
  input wire [7:0] switches,
  input wire [5:0] below,
  output reg [5:0] above
);

wire [9:0] layer_x = pix_x + counter*4;
wire [9:0] layer_y = pix_y + counter/2;
wire layer_sel = layer_x[6] ^ layer_y[6];
wire [5:0] layer_color = {switches[2], switches[7], switches[1], switches[7], switches[0], switches[7]};

always @(*) begin
  if (layer_sel) begin
    above <= layer_color;
  end else begin
    above <= below;
  end
end

endmodule
