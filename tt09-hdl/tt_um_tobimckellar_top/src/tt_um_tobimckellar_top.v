module tt_um_tobimckellar_top(
input  wire [7:0] ui_in,    // Dedicated inputs
output wire [7:0] uo_out,   // Dedicated outputs
input  wire [7:0] uio_in,   // IOs: Input path
output wire [7:0] uio_out,  // IOs: Output path -- connect to ground
output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
input  wire       ena,      // always 1 when the design is powered, so you can ignore it
input  wire       clk,      // clock
input  wire       rst_n     // reset_n - low to reset
);

//    --     input  wire [7:0] ui_in,    // Dedicated inputs
// --     output wire [7:0] uo_out,   // Dedicated outputs
// --     input  wire [7:0] uio_in,   // IOs: Input path
// --     output wire [7:0] uio_out,  // IOs: Output path -- connect to ground
// --     output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
// --     input  wire       ena,      // always 1 when the design is powered, so you can ignore it
// --     input  wire       clk,      // clock
// --     input  wire       rst_n     // reset_n - low to reset
// -- );

  wire [5:0] ref_in;
  wire pwm_out;
  wire [5:0] counter;
  wire enable_pwm;
  wire breathe_state;
  wire [5:0] triangle_value;
  wire count_up;
  wire [9:0] clock_divisor;
  wire [9:0] clock_divisor_ticks;
  wire n3_o;
  wire n4_o;
  wire [5:0] n5_o;
  localparam [7:0] n7_o = 8'b00000000;
  localparam [7:0] n8_o = 8'b00000000;
  wire n11_o;
  wire [31:0] n12_o;
  wire n14_o;
  wire [31:0] n15_o;
  wire [31:0] n17_o;
  wire [5:0] n18_o;
  wire [5:0] n20_o;
  wire [5:0] n22_o;
  wire n27_o;
  wire n28_o;
  wire [30:0] n29_o;
  wire [31:0] n30_o;
  wire [31:0] n31_o;
  wire n32_o;
  wire n34_o;
  wire n36_o;
  wire n38_o;
  wire n40_o;
  wire n41_o;
  wire n43_o;
  wire n45_o;
  wire n46_o;
  wire [31:0] n47_o;
  wire [31:0] n48_o;
  wire n49_o;
  wire n51_o;
  wire n53_o;
  wire n54_o;
  wire n56_o;
  wire n61_o;
  wire [30:0] n62_o;
  wire [31:0] n63_o;
  wire [31:0] n65_o;
  wire [9:0] n66_o;
  wire [31:0] n67_o;
  wire [31:0] n68_o;
  wire n69_o;
  wire [31:0] n70_o;
  wire [31:0] n72_o;
  wire [9:0] n73_o;
  wire [31:0] n75_o;
  wire n77_o;
  wire n78_o;
  wire [31:0] n79_o;
  wire n81_o;
  wire n82_o;
  wire n83_o;
  wire n84_o;
  wire n85_o;
  wire n86_o;
  wire [31:0] n87_o;
  wire [31:0] n89_o;
  wire [5:0] n90_o;
  wire [31:0] n91_o;
  wire [31:0] n93_o;
  wire [5:0] n94_o;
  wire [5:0] n95_o;
  wire [5:0] n96_o;
  wire n97_o;
  wire [9:0] n99_o;
  wire [5:0] n102_o;
  wire n104_o;
  wire [9:0] n106_o;
  wire [9:0] n108_o;
  reg n117_q;
  reg [5:0] n118_q;
  reg [5:0] n119_q;
  reg n120_q;
  reg [9:0] n121_q;
  reg [9:0] n122_q;
  wire [7:0] n124_o;
  assign uo_out = n124_o;
  assign uio_out = n8_o;
  assign uio_oe = n7_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:40:12  */
  assign ref_in = n5_o; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:41:12  */
  assign pwm_out = n117_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:42:12  */
  assign counter = n118_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:43:12  */
  assign enable_pwm = n3_o; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:44:12  */
  assign breathe_state = n4_o; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:47:12  */
  assign triangle_value = n119_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:48:12  */
  assign count_up = n120_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:50:12  */
  assign clock_divisor = n121_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:51:12  */
  assign clock_divisor_ticks = n122_q; // (signal)
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:56:24  */
  assign n3_o = ui_in[7];
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:57:27  */
  assign n4_o = ui_in[6];
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:58:20  */
  assign n5_o = ui_in[5:0];
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:67:23  */
  assign n11_o = ~rst_n;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:70:28  */
  assign n12_o = {26'b0, counter};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:70:28  */
  assign n14_o = n12_o == 32'b00000000000000000000000000111111;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:73:40  */
  assign n15_o = {26'b0, counter};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:73:40  */
  assign n17_o = n15_o + 32'b00000000000000000000000000000001;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:73:32  */
  assign n18_o = n17_o[5:0];  // trunc
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:70:17  */
  assign n20_o = n14_o ? 6'b000000 : n18_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:67:13  */
  assign n22_o = n11_o ? 6'b000000 : n20_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:83:23  */
  assign n27_o = ~rst_n;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:86:34  */
  assign n28_o = ~breathe_state;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:87:25  */
  assign n29_o = {25'b0, ref_in};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:87:54  */
  assign n30_o = {1'b0, n29_o};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:87:54  */
  assign n31_o = {26'b0, counter};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:87:54  */
  assign n32_o = $signed(n30_o) > $signed(n31_o);
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:88:40  */
  assign n34_o = 1'b1 & enable_pwm;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:87:21  */
  assign n36_o = n32_o ? n34_o : 1'b0;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:92:31  */
  assign n38_o = ref_in == 6'b111111;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:93:40  */
  assign n40_o = 1'b1 & enable_pwm;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:92:21  */
  assign n41_o = n38_o ? n40_o : n36_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:95:31  */
  assign n43_o = ref_in == 6'b000000;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:96:40  */
  assign n45_o = 1'b0 & enable_pwm;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:95:21  */
  assign n46_o = n43_o ? n45_o : n41_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:99:40  */
  assign n47_o = {26'b0, triangle_value};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:99:40  */
  assign n48_o = {26'b0, counter};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:99:40  */
  assign n49_o = $signed(n47_o) > $signed(n48_o);
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:100:44  */
  assign n51_o = 1'b1 & enable_pwm;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:99:21  */
  assign n53_o = n49_o ? n51_o : 1'b0;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:86:17  */
  assign n54_o = n28_o ? n46_o : n53_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:83:13  */
  assign n56_o = n27_o ? 1'b0 : n54_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:112:22  */
  assign n61_o = ~rst_n;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:119:37  */
  assign n62_o = {25'b0, ref_in};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:119:36  */
  assign n63_o = {1'b0, n62_o};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:119:36  */
  assign n65_o = 32'b00000000000000000000000000001010 * n63_o; // smul
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:119:34  */
  assign n66_o = n65_o[9:0];  // trunc
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:40  */
  assign n67_o = {22'b0, clock_divisor_ticks};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:40  */
  assign n68_o = {22'b0, clock_divisor};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:40  */
  assign n69_o = $signed(n67_o) < $signed(n68_o);
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:121:64  */
  assign n70_o = {22'b0, clock_divisor_ticks};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:121:64  */
  assign n72_o = n70_o + 32'b00000000000000000000000000000001;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:121:44  */
  assign n73_o = n72_o[9:0];  // trunc
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:41  */
  assign n75_o = {26'b0, triangle_value};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:41  */
  assign n77_o = n75_o == 32'b00000000000000000000000000111110;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:55  */
  assign n78_o = count_up & n77_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:94  */
  assign n79_o = {26'b0, triangle_value};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:94  */
  assign n81_o = n79_o == 32'b00000000000000000000000000000001;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:111  */
  assign n82_o = ~count_up;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:98  */
  assign n83_o = n82_o & n81_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:75  */
  assign n84_o = n78_o | n83_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:126:37  */
  assign n85_o = ~count_up;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:125:21  */
  assign n86_o = n84_o ? n85_o : count_up;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:129:58  */
  assign n87_o = {26'b0, triangle_value};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:129:58  */
  assign n89_o = n87_o + 32'b00000000000000000000000000000001;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:129:43  */
  assign n90_o = n89_o[5:0];  // trunc
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:131:58  */
  assign n91_o = {26'b0, triangle_value};  //  uext
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:131:58  */
  assign n93_o = n91_o - 32'b00000000000000000000000000000001;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:131:43  */
  assign n94_o = n93_o[5:0];  // trunc
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:128:21  */
  assign n95_o = count_up ? n90_o : n94_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:17  */
  assign n96_o = n69_o ? triangle_value : n95_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:17  */
  assign n97_o = n69_o ? count_up : n86_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:120:17  */
  assign n99_o = n69_o ? n73_o : 10'b0000000000;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:112:13  */
  assign n102_o = n61_o ? 6'b000000 : n96_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:112:13  */
  assign n104_o = n61_o ? 1'b1 : n97_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:112:13  */
  assign n106_o = n61_o ? 10'b0000000000 : n66_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:112:13  */
  assign n108_o = n61_o ? 10'b0000000000 : n99_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:82:9  */
  always @(posedge clk)
    n117_q <= n56_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:66:9  */
  always @(posedge clk)
    n118_q <= n22_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:111:9  */
  always @(posedge clk)
    n119_q <= n102_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:111:9  */
  always @(posedge clk)
    n120_q <= n104_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:111:9  */
  always @(posedge clk)
    n121_q <= n106_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:111:9  */
  always @(posedge clk)
    n122_q <= n108_o;
  /* vhdlsrc/tt_um_tobimckellar_top.vhd:111:9  */
  assign n124_o = {pwm_out, 7'b0000000};
endmodule

