`default_nettype none

module layer_e (
  input wire [9:0] pix_x,
  input wire [9:0] pix_y,
  input wire [9:0] counter,
  input wire [7:0] switches,
  input wire [5:0] below,
  output reg [5:0] above
);

wire [9:0] layer_x = pix_x + counter/2;
wire [9:0] layer_y = pix_y + counter/6;
wire layer_sel = (layer_x[4] ^ layer_y[4]) & ( pix_y[1] ^ pix_x[0]);
wire [5:0] layer_color = {switches[7], switches[5], switches[7], switches[4], switches[7], switches[3]};

always @(*) begin
  if (layer_sel) begin
    above <= layer_color;
  end else begin
    above <= below;
  end
end

endmodule
