module clock_mode_converter (
    i_12h_mode,

    i_hours,
    i_minutes,
    i_seconds,

    o_hours,
    o_minutes,
    o_seconds,
    o_am_pm
);

  input wire i_12h_mode;
  input wire [4:0] i_hours;
  input wire [5:0] i_minutes;
  input wire [5:0] i_seconds;

  output reg [4:0] o_hours;
  output reg [5:0] o_minutes;
  output reg [5:0] o_seconds;
  output reg o_am_pm;

  always @(*) begin 
    if (!i_12h_mode) begin
      o_hours   = i_hours;
      o_minutes = i_minutes;
      o_seconds = i_seconds;
      o_am_pm   = 1'b0;
    end
    else begin
      case (i_hours)
        5'd00:   o_hours = 12;
        5'd12:   o_hours = 12;
        default: o_hours = (i_hours % 12);
      endcase
      o_minutes = i_minutes;
      o_seconds = i_seconds;
      o_am_pm   = i_hours >= 12;
    end
  end

endmodule
