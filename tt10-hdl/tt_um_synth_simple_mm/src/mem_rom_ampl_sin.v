module mem_rom_ampl_sin (
			 rstn,
			 clk,
			 en,
			 addr,
			 data_out
			 );
   
   input rstn;
   input clk;
   input en;
   //input [5:0] addr;
   input [4:0] addr;	
   output reg [5:0] data_out;
   
   //localparam nbit_freq_adx_tri_squ_sin = 7;
   //localparam nbit_freq_adx_saw = 7;   
   //localparam n_adx_tri_squ_sin = 2**nbit_freq_adx_tri_squ_sin;
   //localparam n_adx_saw = 2**nbit_freq_adx_saw;
   localparam n_val_sin = 32;   

   wire [5:0] 	    rom_ampl_sin[0:n_val_sin-1];

   assign rom_ampl_sin[0] = 6'd0;
   assign rom_ampl_sin[1] = 6'd2;
   assign rom_ampl_sin[2] = 6'd3;
   assign rom_ampl_sin[3] = 6'd5;
   assign rom_ampl_sin[4] = 6'd6;
   assign rom_ampl_sin[5] = 6'd8;
   assign rom_ampl_sin[6] = 6'd9;
   assign rom_ampl_sin[7] = 6'd11;
   assign rom_ampl_sin[8] = 6'd12;
   assign rom_ampl_sin[9] = 6'd14;
   assign rom_ampl_sin[10] = 6'd15;
   assign rom_ampl_sin[11] = 6'd16;
   assign rom_ampl_sin[12] = 6'd18;
   assign rom_ampl_sin[13] = 6'd19;
   assign rom_ampl_sin[14] = 6'd20;
   assign rom_ampl_sin[15] = 6'd21;
   assign rom_ampl_sin[16] = 6'd22;
   assign rom_ampl_sin[17] = 6'd24;
   assign rom_ampl_sin[18] = 6'd25;
   assign rom_ampl_sin[19] = 6'd25;
   assign rom_ampl_sin[20] = 6'd26;
   assign rom_ampl_sin[21] = 6'd27;
   assign rom_ampl_sin[22] = 6'd28;
   assign rom_ampl_sin[23] = 6'd28;
   assign rom_ampl_sin[24] = 6'd29;
   assign rom_ampl_sin[25] = 6'd30;
   assign rom_ampl_sin[26] = 6'd30;
   assign rom_ampl_sin[27] = 6'd30;
   assign rom_ampl_sin[28] = 6'd31;
   assign rom_ampl_sin[29] = 6'd31;
   assign rom_ampl_sin[30] = 6'd31;
   assign rom_ampl_sin[31] = 6'd31;  
   

   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             data_out <= 0;
          end
        else
          begin 
             if ( en == 1'b1 ) 
               begin
		  //data_out <= rom_ampl_sin[addr[4:0]];			  
		  data_out <= rom_ampl_sin[addr];			  
               end
             else
               begin 
                  data_out <= 0;
               end
          end
     end
   
endmodule 
