module mem_rom_freq_saw (
			 rstn,
			 clk,
			 en,
			 addr,
			 data_out
			 );
   
   input rstn;
   input clk;
   input en;
   input [6:0] addr;
   output reg [15:0] data_out;
   
   //localparam nbit_freq_adx_tri_squ_sin = 7;
   localparam nbit_freq_adx_saw = 7;   
   //localparam n_adx_tri_squ_sin = 2**nbit_freq_adx_tri_squ_sin;
   localparam n_adx_saw = 2**nbit_freq_adx_saw;
   //localparam n_val_sin = 32;   

   wire [15:0] 	     rom_freq_saw[0:n_adx_saw-1];

   assign rom_freq_saw[0] = 16'd0;
   assign rom_freq_saw[1] = 16'd0;
   assign rom_freq_saw[2] = 16'd0;
   assign rom_freq_saw[3] = 16'd0;
   assign rom_freq_saw[4] = 16'd0;
   assign rom_freq_saw[5] = 16'd0;
   assign rom_freq_saw[6] = 16'd0;
   assign rom_freq_saw[7] = 16'd0;
   assign rom_freq_saw[8] = 16'd0;
   assign rom_freq_saw[9] = 16'd0;
   assign rom_freq_saw[10] = 16'd0;
   assign rom_freq_saw[11] = 16'd0;
   assign rom_freq_saw[12] = 16'd48537;
   assign rom_freq_saw[13] = 16'd45812;
   assign rom_freq_saw[14] = 16'd43241;
   assign rom_freq_saw[15] = 16'd40814;
   assign rom_freq_saw[16] = 16'd38524;
   assign rom_freq_saw[17] = 16'd36361;
   assign rom_freq_saw[18] = 16'd34321;
   assign rom_freq_saw[19] = 16'd32394;
   assign rom_freq_saw[20] = 16'd30576;
   assign rom_freq_saw[21] = 16'd28860;
   assign rom_freq_saw[22] = 16'd27240;
   assign rom_freq_saw[23] = 16'd25711;
   assign rom_freq_saw[24] = 16'd24268;
   assign rom_freq_saw[25] = 16'd22906;
   assign rom_freq_saw[26] = 16'd21621;
   assign rom_freq_saw[27] = 16'd20407;
   assign rom_freq_saw[28] = 16'd19262;
   assign rom_freq_saw[29] = 16'd18181;
   assign rom_freq_saw[30] = 16'd17160;
   assign rom_freq_saw[31] = 16'd16197;
   assign rom_freq_saw[32] = 16'd15288;
   assign rom_freq_saw[33] = 16'd14430;
   assign rom_freq_saw[34] = 16'd13620;
   assign rom_freq_saw[35] = 16'd12856;
   assign rom_freq_saw[36] = 16'd12134;
   assign rom_freq_saw[37] = 16'd11453;
   assign rom_freq_saw[38] = 16'd10810;
   assign rom_freq_saw[39] = 16'd10204;
   assign rom_freq_saw[40] = 16'd9631;
   assign rom_freq_saw[41] = 16'd9090;
   assign rom_freq_saw[42] = 16'd8580;
   assign rom_freq_saw[43] = 16'd8099;
   assign rom_freq_saw[44] = 16'd7644;
   assign rom_freq_saw[45] = 16'd7215;
   assign rom_freq_saw[46] = 16'd6810;
   assign rom_freq_saw[47] = 16'd6428;
   assign rom_freq_saw[48] = 16'd6067;
   assign rom_freq_saw[49] = 16'd5727;
   assign rom_freq_saw[50] = 16'd5405;
   assign rom_freq_saw[51] = 16'd5102;
   assign rom_freq_saw[52] = 16'd4815;
   assign rom_freq_saw[53] = 16'd4545;
   assign rom_freq_saw[54] = 16'd4290;
   assign rom_freq_saw[55] = 16'd4049;
   assign rom_freq_saw[56] = 16'd3822;
   assign rom_freq_saw[57] = 16'd3608;
   assign rom_freq_saw[58] = 16'd3405;
   assign rom_freq_saw[59] = 16'd3214;
   assign rom_freq_saw[60] = 16'd3034;
   assign rom_freq_saw[61] = 16'd2863;
   assign rom_freq_saw[62] = 16'd2703;
   assign rom_freq_saw[63] = 16'd2551;
   assign rom_freq_saw[64] = 16'd2408;
   assign rom_freq_saw[65] = 16'd2273;
   assign rom_freq_saw[66] = 16'd2145;
   assign rom_freq_saw[67] = 16'd2025;
   assign rom_freq_saw[68] = 16'd1911;
   assign rom_freq_saw[69] = 16'd1804;
   assign rom_freq_saw[70] = 16'd1703;
   assign rom_freq_saw[71] = 16'd1607;
   assign rom_freq_saw[72] = 16'd1517;
   assign rom_freq_saw[73] = 16'd1432;
   assign rom_freq_saw[74] = 16'd1351;
   assign rom_freq_saw[75] = 16'd1275;
   assign rom_freq_saw[76] = 16'd1204;
   assign rom_freq_saw[77] = 16'd1136;
   assign rom_freq_saw[78] = 16'd1073;
   assign rom_freq_saw[79] = 16'd1012;
   assign rom_freq_saw[80] = 16'd956;
   assign rom_freq_saw[81] = 16'd902;
   assign rom_freq_saw[82] = 16'd851;
   assign rom_freq_saw[83] = 16'd803;
   assign rom_freq_saw[84] = 16'd758;
   assign rom_freq_saw[85] = 16'd716;
   assign rom_freq_saw[86] = 16'd676;
   assign rom_freq_saw[87] = 16'd638;
   assign rom_freq_saw[88] = 16'd602;
   assign rom_freq_saw[89] = 16'd568;
   assign rom_freq_saw[90] = 16'd536;
   assign rom_freq_saw[91] = 16'd506;
   assign rom_freq_saw[92] = 16'd478;
   assign rom_freq_saw[93] = 16'd451;
   assign rom_freq_saw[94] = 16'd426;
   assign rom_freq_saw[95] = 16'd402;
   assign rom_freq_saw[96] = 16'd379;
   assign rom_freq_saw[97] = 16'd358;
   assign rom_freq_saw[98] = 16'd338;
   assign rom_freq_saw[99] = 16'd319;
   assign rom_freq_saw[100] = 16'd301;
   assign rom_freq_saw[101] = 16'd284;
   assign rom_freq_saw[102] = 16'd268;
   assign rom_freq_saw[103] = 16'd253;
   assign rom_freq_saw[104] = 16'd239;
   assign rom_freq_saw[105] = 16'd225;
   assign rom_freq_saw[106] = 16'd213;
   assign rom_freq_saw[107] = 16'd201;
   assign rom_freq_saw[108] = 16'd190;
   assign rom_freq_saw[109] = 16'd179;
   assign rom_freq_saw[110] = 16'd169;
   assign rom_freq_saw[111] = 16'd159;
   assign rom_freq_saw[112] = 16'd150;
   assign rom_freq_saw[113] = 16'd142;
   assign rom_freq_saw[114] = 16'd134;
   assign rom_freq_saw[115] = 16'd127;
   assign rom_freq_saw[116] = 16'd119;
   assign rom_freq_saw[117] = 16'd113;
   assign rom_freq_saw[118] = 16'd106;
   assign rom_freq_saw[119] = 16'd100;
   assign rom_freq_saw[120] = 16'd0;
   assign rom_freq_saw[121] = 16'd0;
   assign rom_freq_saw[122] = 16'd0;
   assign rom_freq_saw[123] = 16'd0;
   assign rom_freq_saw[124] = 16'd0;
   assign rom_freq_saw[125] = 16'd0;
   assign rom_freq_saw[126] = 16'd0;
   assign rom_freq_saw[127] = 16'd0;
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             data_out <= 1804;			     
          end
        else
          begin 
             if ( en == 1'b1 ) 
               begin
                  data_out <= rom_freq_saw[addr];				  
               end
          end
     end
   
endmodule 
