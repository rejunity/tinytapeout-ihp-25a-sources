`default_nettype none

// we'll go 100ps here so VCD is saner with ring oscillator
`timescale 1ns / 100ps

module tt_um_drum_goekce (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg  [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  localparam unsigned k = 6;
  localparam unsigned n = 8;
  localparam unsigned m = 8;
  localparam unsigned RAM_BYTES = 10;
  localparam unsigned addr_bits = $clog2(RAM_BYTES);
  localparam unsigned last_result_addr = 2 ** (addr_bits - 2) - 1;
  localparam unsigned result_addr_bits = (addr_bits - 2);
  localparam unsigned a_addr = 2 ** (addr_bits - 1);
  localparam unsigned b_addr = a_addr + 1;


  wire [addr_bits-1:0] addr = ui_in[addr_bits-1:0];
  wire wr_en = ui_in[7];

  reg [7:0] ram[RAM_BYTES - 1:0];
  reg [result_addr_bits-1:0] result_addr;

  always @(posedge clk) begin
    if (!rst_n) begin
      uo_out <= 8'b0;
      result_addr <= 0;
      for (int i = 0; i < RAM_BYTES; i++) begin
        ram[i] <= 8'b0;
      end
    end else begin
      result_addr <= result_addr + 1;
      if (wr_en && (addr[addr_bits-1] == 1)) begin
        ram[addr] <= uio_in;
      end
      uo_out <= ram[addr];

      if (ui_in[5]) {ram[{1'b0, result_addr, 1'b1}], ram[{1'b0, result_addr, 1'b0}]} <= r;
    end
  end

  wire [  (n-1):0] a;
  wire [  (m-1):0] b;
  wire [(n+m)-1:0] r;

  drum #(
      .k(k),
      .n(n),
      .m(m)
  ) drum_i (
      .a(a),
      .b(b),
      .r(r)
  );

  assign a = ram[a_addr];
  assign b = ram[b_addr];

  wire _unused_pins = &{ena};

  assign uio_out = r[7:0];
  assign uio_oe  = {8{ui_in[6]}};
endmodule

module drum (
    a,
    b,
    r
);

  parameter k = 4;
  parameter n = 4;
  parameter m = 4;

  input [(n-1):0] a;
  input [(m-1):0] b;
  output [(n+m)-1:0] r;

  wire [(n-1):0] a_temp;
  wire [(m-1):0] b_temp;
  wire out_sign;
  wire [(n+m)-1:0] r_temp;

  assign a_temp   = (a[n-1] == 1'b1) ? ~a : a;
  assign b_temp   = (b[m-1] == 1'b1) ? ~b : b;

  assign out_sign = a[n-1] ^ b[m-1];

  dsmk_mn #(k, n, m) U1 (
      .a(a_temp),
      .b(b_temp),
      .r(r_temp)
  );

  assign r = (out_sign) ? ~r_temp : r_temp;

endmodule

module dsmk_mn (
    a,
    b,
    r
);

  parameter k_in = 6;
  parameter n_in = 16;
  parameter m_in = 16;

  input [n_in-1:0] a;
  input [m_in-1:0] b;
  output [(n_in+m_in)-1:0] r;

  wire [$clog2(n_in)-1:0] k1;
  wire [$clog2(m_in)-1:0] k2;
  wire [k_in-3:0] m, n;
  wire [n_in-1:0] l1;
  wire [m_in-1:0] l2;
  wire [(k_in*2)-1:0] tmp;
  wire [$clog2(m_in)-1:0] p;
  wire [$clog2(m_in)-1:0] q;
  wire [$clog2(m_in):0] sum;
  wire [k_in-1:0] mm, nn;
  LOD_k #(k_in, n_in) u1 (
      .in_a (a),
      .out_a(l1)
  );
  LOD_k #(k_in, m_in) u2 (
      .in_a (b),
      .out_a(l2)
  );
  P_Encoder_k #(k_in, n_in) u3 (
      .in_a (l1),
      .out_a(k1)
  );
  P_Encoder_k #(k_in, m_in) u4 (
      .in_a (l2),
      .out_a(k2)
  );
  Mux_16_3_k #(k_in, n_in) u5 (
      .in_a(a),
      .select(k1),
      .out(m)
  );
  Mux_16_3_k #(k_in, m_in) u6 (
      .in_a(b),
      .select(k2),
      .out(n)
  );
  assign p   = (k1 > (k_in - 1)) ? k1 - (k_in - 1) : 0;
  assign q   = (k2 > (k_in - 1)) ? k2 - (k_in - 1) : 0;
  assign mm  = (k1 > k_in - 1) ? ({1'b1, m, 1'b1}) : a[k_in-1:0];
  assign nn  = (k2 > k_in - 1) ? ({1'b1, n, 1'b1}) : b[k_in-1:0];

  assign tmp = mm * nn;
  assign sum = p + q;

  Barrel_Shifter_k_mn #(k_in, n_in, m_in) u7 (
      .in_a (tmp),
      .count(sum),
      .out_a(r)
  );

endmodule

//------------------------------------------------------------
module LOD_k (
    in_a,
    out_a
);
  input [n_in-1:0] in_a;
  output reg [n_in-1:0] out_a;

  parameter k_in = 6;
  parameter n_in = 16;

  integer k, j;
  reg [n_in-1:0] w;

  always @(*) begin
    out_a[n_in-1] = in_a[n_in-1];
    w[n_in-1] = in_a[n_in-1] ? 0 : 1;
    for (k = n_in - 2; k >= 0; k = k - 1) begin
      w[k] = in_a[k] ? 0 : w[k+1];
      out_a[k] = w[k+1] & in_a[k];
    end
  end

endmodule

//--------------------------------
module P_Encoder_k (
    in_a,
    out_a
);
  input [n_in-1:0] in_a;
  output reg [$clog2(n_in)-1:0] out_a;

  parameter k_in = 6;
  parameter n_in = 16;

  integer i;
  always @* begin
    out_a = 0;
    for (i = n_in - 1; i >= 0; i = i - 1) if (in_a[i]) out_a = i[$clog2(n_in)-1:0];
  end
endmodule

//--------------------------------
module Barrel_Shifter_k_mn (
    in_a,
    count,
    out_a
);
  input [$clog2(m_in):0] count;
  input [(k_in*2)-1:0] in_a;
  output [(n_in+m_in)-1:0] out_a;

  parameter k_in = 6;
  parameter n_in = 16;
  parameter m_in = 16;

  wire [(n_in + m_in)-1:0] tmp;
  assign tmp   = {{((n_in + m_in) - (k_in * 2)) {1'b0}}, in_a};
  assign out_a = (tmp << count);

endmodule

//--------------------------------
module Mux_16_3_k (
    in_a,
    select,
    out
);
  input [$clog2(n_in)-1:0] select;
  input [n_in-1:0] in_a;
  output reg [k_in-3:0] out;

  parameter k_in = 6;
  parameter n_in = 16;

  integer i;
  always @(*) begin
    out = 0;
    for (i = k_in; i < (n_in); i = i + 1) begin : mux_gen_block
      if (select == i[$clog2(n_in)-1:0]) out = in_a[i-1-:k_in-2];
    end
  end

endmodule
