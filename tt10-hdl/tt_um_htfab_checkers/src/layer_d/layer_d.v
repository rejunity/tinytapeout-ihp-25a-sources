// Generated automatically via PyRTL
// As one initial test of synthesis, map to FPGA with:
//   yosys -p "synth_xilinx -top layer_d" thisfile.v

module layer_d(clk, below, counter, pix_x, pix_y, switches, above);
    input clk;
    input[5:0] below;
    input[9:0] counter;
    input[9:0] pix_x;
    input[9:0] pix_y;
    input[7:0] switches;
    output[5:0] above;

    wire[1:0] const_0_2;
    wire const_1_0;
    wire const_2_0;
    wire const_3_0;
    wire const_4_0;
    wire[5:0] layer_color;
    wire layer_sel;
    wire[9:0] layer_x;
    wire[9:0] layer_y;
    wire[7:0] tmp0;
    wire[9:0] tmp1;
    wire[19:0] tmp2;
    wire[9:0] tmp3;
    wire[19:0] tmp4;
    wire[20:0] tmp5;
    wire[9:0] tmp6;
    wire[7:0] tmp7;
    wire tmp8;
    wire[1:0] tmp9;
    wire[9:0] tmp10;
    wire[10:0] tmp11;
    wire[9:0] tmp12;
    wire tmp13;
    wire tmp14;
    wire tmp15;
    wire tmp16;
    wire tmp17;
    wire tmp18;
    wire tmp19;
    wire tmp20;
    wire tmp21;
    wire[5:0] tmp22;
    wire tmp23;
    wire[4:0] tmp24;
    wire[5:0] tmp25;
    wire[5:0] tmp26;
    wire[5:0] tmp27;

    // Combinational
    assign const_0_2 = 2;
    assign const_1_0 = 0;
    assign const_2_0 = 0;
    assign const_3_0 = 0;
    assign const_4_0 = 0;
    assign above = tmp27;
    assign layer_color = tmp22;
    assign layer_sel = tmp15;
    assign layer_x = tmp6;
    assign layer_y = tmp12;
    assign tmp0 = {const_1_0, const_1_0, const_1_0, const_1_0, const_1_0, const_1_0, const_1_0, const_1_0};
    assign tmp1 = {tmp0, const_0_2};
    assign tmp2 = counter * tmp1;
    assign tmp3 = {const_2_0, const_2_0, const_2_0, const_2_0, const_2_0, const_2_0, const_2_0, const_2_0, const_2_0, const_2_0};
    assign tmp4 = {tmp3, pix_x};
    assign tmp5 = tmp4 + tmp2;
    assign tmp6 = {tmp5[9], tmp5[8], tmp5[7], tmp5[6], tmp5[5], tmp5[4], tmp5[3], tmp5[2], tmp5[1], tmp5[0]};
    assign tmp7 = {counter[9], counter[8], counter[7], counter[6], counter[5], counter[4], counter[3], counter[2]};
    assign tmp8 = {tmp7[7]};
    assign tmp9 = {tmp8, tmp8};
    assign tmp10 = {tmp9, tmp7};
    assign tmp11 = pix_y + tmp10;
    assign tmp12 = {tmp11[9], tmp11[8], tmp11[7], tmp11[6], tmp11[5], tmp11[4], tmp11[3], tmp11[2], tmp11[1], tmp11[0]};
    assign tmp13 = {layer_x[5]};
    assign tmp14 = {layer_y[5]};
    assign tmp15 = tmp13 ^ tmp14;
    assign tmp16 = {switches[7]};
    assign tmp17 = {switches[2]};
    assign tmp18 = {switches[7]};
    assign tmp19 = {switches[1]};
    assign tmp20 = {switches[7]};
    assign tmp21 = {switches[0]};
    assign tmp22 = {tmp16, tmp17, tmp18, tmp19, tmp20, tmp21};
    assign tmp23 = ~layer_sel;
    assign tmp24 = {const_4_0, const_4_0, const_4_0, const_4_0, const_4_0};
    assign tmp25 = {tmp24, const_3_0};
    assign tmp26 = layer_sel ? layer_color : tmp25;
    assign tmp27 = tmp23 ? below : tmp26;

endmodule

