`default_nettype none

module layer_a (
  input wire [9:0] pix_x,
  input wire [9:0] pix_y,
  input wire [9:0] counter,
  input wire [7:0] switches,
  input wire [5:0] below,
  output reg [5:0] above
);

wire [9:0] layer_x = pix_x + counter*16;
wire [9:0] layer_y = pix_y + counter*2;
wire layer_sel = (layer_x[8] ^ layer_y[8]) & ( pix_y[1] ^ pix_x[0]);
wire [5:0] layer_color = {switches[6], switches[2], switches[6], switches[1], switches[6], switches[0]};

always @(*) begin
  if (layer_sel) begin
    above <= layer_color;
  end else begin
    above <= below;
  end
end

endmodule
