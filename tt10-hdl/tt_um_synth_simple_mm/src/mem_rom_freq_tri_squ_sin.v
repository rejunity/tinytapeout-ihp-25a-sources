module mem_rom_freq_tri_squ_sin (
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
   
   localparam nbit_freq_adx_tri_squ_sin = 7;
   //localparam nbit_freq_adx_saw = 7;   
   localparam n_adx_tri_squ_sin = 2**nbit_freq_adx_tri_squ_sin;
   //localparam n_adx_saw = 2**nbit_freq_adx_saw;
   //localparam n_val_sin = 32;   

   wire [15:0] 	     rom_freq_tri_squ_sin[0:n_adx_tri_squ_sin-1];

   assign rom_freq_tri_squ_sin[0] = 16'd0;
   assign rom_freq_tri_squ_sin[1] = 16'd0;
   assign rom_freq_tri_squ_sin[2] = 16'd0;
   assign rom_freq_tri_squ_sin[3] = 16'd0;
   assign rom_freq_tri_squ_sin[4] = 16'd0;
   assign rom_freq_tri_squ_sin[5] = 16'd0;
   assign rom_freq_tri_squ_sin[6] = 16'd0;
   assign rom_freq_tri_squ_sin[7] = 16'd0;
   assign rom_freq_tri_squ_sin[8] = 16'd0;
   assign rom_freq_tri_squ_sin[9] = 16'd0;
   assign rom_freq_tri_squ_sin[10] = 16'd0;
   assign rom_freq_tri_squ_sin[11] = 16'd0;
   assign rom_freq_tri_squ_sin[12] = 16'd24660;
   assign rom_freq_tri_squ_sin[13] = 16'd23276;
   assign rom_freq_tri_squ_sin[14] = 16'd21969;
   assign rom_freq_tri_squ_sin[15] = 16'd20736;
   assign rom_freq_tri_squ_sin[16] = 16'd19572;
   assign rom_freq_tri_squ_sin[17] = 16'd18474;
   assign rom_freq_tri_squ_sin[18] = 16'd17437;
   assign rom_freq_tri_squ_sin[19] = 16'd16458;
   assign rom_freq_tri_squ_sin[20] = 16'd15535;
   assign rom_freq_tri_squ_sin[21] = 16'd14663;
   assign rom_freq_tri_squ_sin[22] = 16'd13840;
   assign rom_freq_tri_squ_sin[23] = 16'd13063;
   assign rom_freq_tri_squ_sin[24] = 16'd12330;
   assign rom_freq_tri_squ_sin[25] = 16'd11638;
   assign rom_freq_tri_squ_sin[26] = 16'd10985;
   assign rom_freq_tri_squ_sin[27] = 16'd10368;
   assign rom_freq_tri_squ_sin[28] = 16'd9786;
   assign rom_freq_tri_squ_sin[29] = 16'd9237;
   assign rom_freq_tri_squ_sin[30] = 16'd8719;
   assign rom_freq_tri_squ_sin[31] = 16'd8229;
   assign rom_freq_tri_squ_sin[32] = 16'd7767;
   assign rom_freq_tri_squ_sin[33] = 16'd7331;
   assign rom_freq_tri_squ_sin[34] = 16'd6920;
   assign rom_freq_tri_squ_sin[35] = 16'd6532;
   assign rom_freq_tri_squ_sin[36] = 16'd6165;
   assign rom_freq_tri_squ_sin[37] = 16'd5819;
   assign rom_freq_tri_squ_sin[38] = 16'd5492;
   assign rom_freq_tri_squ_sin[39] = 16'd5184;
   assign rom_freq_tri_squ_sin[40] = 16'd4893;
   assign rom_freq_tri_squ_sin[41] = 16'd4618;
   assign rom_freq_tri_squ_sin[42] = 16'd4359;
   assign rom_freq_tri_squ_sin[43] = 16'd4115;
   assign rom_freq_tri_squ_sin[44] = 16'd3884;
   assign rom_freq_tri_squ_sin[45] = 16'd3666;
   assign rom_freq_tri_squ_sin[46] = 16'd3460;
   assign rom_freq_tri_squ_sin[47] = 16'd3266;
   assign rom_freq_tri_squ_sin[48] = 16'd3082;
   assign rom_freq_tri_squ_sin[49] = 16'd2909;
   assign rom_freq_tri_squ_sin[50] = 16'd2746;
   assign rom_freq_tri_squ_sin[51] = 16'd2592;
   assign rom_freq_tri_squ_sin[52] = 16'd2447;
   assign rom_freq_tri_squ_sin[53] = 16'd2309;
   assign rom_freq_tri_squ_sin[54] = 16'd2180;
   assign rom_freq_tri_squ_sin[55] = 16'd2057;
   assign rom_freq_tri_squ_sin[56] = 16'd1942;
   assign rom_freq_tri_squ_sin[57] = 16'd1833;
   assign rom_freq_tri_squ_sin[58] = 16'd1730;
   assign rom_freq_tri_squ_sin[59] = 16'd1633;
   assign rom_freq_tri_squ_sin[60] = 16'd1541;
   assign rom_freq_tri_squ_sin[61] = 16'd1455;
   assign rom_freq_tri_squ_sin[62] = 16'd1373;
   assign rom_freq_tri_squ_sin[63] = 16'd1296;
   assign rom_freq_tri_squ_sin[64] = 16'd1223;
   assign rom_freq_tri_squ_sin[65] = 16'd1155;
   assign rom_freq_tri_squ_sin[66] = 16'd1090;
   assign rom_freq_tri_squ_sin[67] = 16'd1029;
   assign rom_freq_tri_squ_sin[68] = 16'd971;
   assign rom_freq_tri_squ_sin[69] = 16'd916;
   assign rom_freq_tri_squ_sin[70] = 16'd865;
   assign rom_freq_tri_squ_sin[71] = 16'd816;
   assign rom_freq_tri_squ_sin[72] = 16'd771;
   assign rom_freq_tri_squ_sin[73] = 16'd727;
   assign rom_freq_tri_squ_sin[74] = 16'd687;
   assign rom_freq_tri_squ_sin[75] = 16'd648;
   assign rom_freq_tri_squ_sin[76] = 16'd612;
   assign rom_freq_tri_squ_sin[77] = 16'd577;
   assign rom_freq_tri_squ_sin[78] = 16'd545;
   assign rom_freq_tri_squ_sin[79] = 16'd514;
   assign rom_freq_tri_squ_sin[80] = 16'd485;
   assign rom_freq_tri_squ_sin[81] = 16'd458;
   assign rom_freq_tri_squ_sin[82] = 16'd432;
   assign rom_freq_tri_squ_sin[83] = 16'd408;
   assign rom_freq_tri_squ_sin[84] = 16'd385;
   assign rom_freq_tri_squ_sin[85] = 16'd364;
   assign rom_freq_tri_squ_sin[86] = 16'd343;
   assign rom_freq_tri_squ_sin[87] = 16'd324;
   assign rom_freq_tri_squ_sin[88] = 16'd306;
   assign rom_freq_tri_squ_sin[89] = 16'd289;
   assign rom_freq_tri_squ_sin[90] = 16'd272;
   assign rom_freq_tri_squ_sin[91] = 16'd257;
   assign rom_freq_tri_squ_sin[92] = 16'd243;
   assign rom_freq_tri_squ_sin[93] = 16'd229;
   assign rom_freq_tri_squ_sin[94] = 16'd216;
   assign rom_freq_tri_squ_sin[95] = 16'd204;
   assign rom_freq_tri_squ_sin[96] = 16'd193;
   assign rom_freq_tri_squ_sin[97] = 16'd182;
   assign rom_freq_tri_squ_sin[98] = 16'd172;
   assign rom_freq_tri_squ_sin[99] = 16'd162;
   assign rom_freq_tri_squ_sin[100] = 16'd153;
   assign rom_freq_tri_squ_sin[101] = 16'd144;
   assign rom_freq_tri_squ_sin[102] = 16'd136;
   assign rom_freq_tri_squ_sin[103] = 16'd129;
   assign rom_freq_tri_squ_sin[104] = 16'd121;
   assign rom_freq_tri_squ_sin[105] = 16'd115;
   assign rom_freq_tri_squ_sin[106] = 16'd108;
   assign rom_freq_tri_squ_sin[107] = 16'd102;
   assign rom_freq_tri_squ_sin[108] = 16'd96;
   assign rom_freq_tri_squ_sin[109] = 16'd91;
   assign rom_freq_tri_squ_sin[110] = 16'd86;
   assign rom_freq_tri_squ_sin[111] = 16'd81;
   assign rom_freq_tri_squ_sin[112] = 16'd76;
   assign rom_freq_tri_squ_sin[113] = 16'd72;
   assign rom_freq_tri_squ_sin[114] = 16'd68;
   assign rom_freq_tri_squ_sin[115] = 16'd64;
   assign rom_freq_tri_squ_sin[116] = 16'd61;
   assign rom_freq_tri_squ_sin[117] = 16'd57;
   assign rom_freq_tri_squ_sin[118] = 16'd54;
   assign rom_freq_tri_squ_sin[119] = 16'd51;
   assign rom_freq_tri_squ_sin[120] = 16'd0;
   assign rom_freq_tri_squ_sin[121] = 16'd0;
   assign rom_freq_tri_squ_sin[122] = 16'd0;
   assign rom_freq_tri_squ_sin[123] = 16'd0;
   assign rom_freq_tri_squ_sin[124] = 16'd0;
   assign rom_freq_tri_squ_sin[125] = 16'd0;
   assign rom_freq_tri_squ_sin[126] = 16'd0;
   assign rom_freq_tri_squ_sin[127] = 16'd0;
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             data_out <= 16'd916;			     
          end
        else
          begin 
             if ( en == 1'b1 ) 
               begin
                  data_out <= rom_freq_tri_squ_sin[addr];				  
               end
          end
     end
   
endmodule 
