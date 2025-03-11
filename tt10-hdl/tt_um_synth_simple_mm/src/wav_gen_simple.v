module wav_gen_simple_v(
			clk,
			rstn,
			per_adx_in,
			per_adx_valid_in,
			click_en_in,
			wsel,
			wout
			);
   //parameter [31:0]debug_mode  = 0;
   parameter [31:0]nbit_freq_adx  = 7;
   parameter [31:0]nbit_wav_in  = 6;
   parameter [31:0]nbit_wav_out  = 14;
   //parameter [31:0]nbit_bar  = 4;
   input clk;
   input rstn;
   input [( nbit_freq_adx - 1 ):0] per_adx_in;
   input 			   per_adx_valid_in;
   input 			   click_en_in;
   input [1:0] 			   wsel;
   output [( nbit_wav_out - 1 ):0] wout;
   
   //localparam nbit_frac_out  = ( nbit_wav_in + 1 );

   //localparam nbit_freq  = 16;

   localparam [nbit_wav_in-1:0] cwave_mx  = 6'b011111;
   localparam [nbit_wav_in-1:0] cwave_mn  = 6'b100001;
   
   wire [15:0] 			   sstep_cnt_thr_tri_squ_sin;
   wire [15:0] 			   sstep_cnt_thr_saw;
   wire [nbit_wav_in-1:0] 	   swave_squ_thr_up;
   wire [nbit_wav_in-1:0] 	   swave_squ_thr_down;
   wire [( nbit_wav_in - 1 ):0]    smem_rom_ampl_sin_val;
   reg [15:0] 			   sstep_cnt_thr;
   reg 				   snote_enable;
   reg 				   swave_enable;
   reg 				   sclick_enable;
   reg [15:0] 			   sstep_cnt;
   reg 				   sstep_cnt_tc;
   reg [( nbit_wav_in - 1 ):0] 	   swave_cnt_tri;

   reg 				   swave_cnt_tri_is_max;
   reg 				   swave_cnt_tri_is_squ_thr_up;
   reg 				   swave_cnt_tri_is_min;
   reg 				   swave_cnt_tri_is_squ_thr_down;
   reg 				   swave_cnt_neg;
   reg 				   swave_cnt_tri_down_up_n;
   reg 				   swave_squ_sel;
   reg [( nbit_wav_in - 1 ):0] 	   swave_tri;
   reg [( nbit_wav_in - 1 ):0] 	   swave_saw;
   reg [( nbit_wav_in - 1 ):0] 	   swave_squ;
   //reg [( nbit_wav_in - 1 ):0] 	   smem_rom_ampl_sin_adx;
   reg [( nbit_wav_in - 2 ):0] 	   smem_rom_ampl_sin_adx;	
   reg 				   smem_rom_ampl_sin_val_is_neg;
   reg [( nbit_wav_in - 1 ):0] 	   swave_sin;
   reg [( nbit_wav_in - 1 ):0] 	   swave;

   mem_rom_freq_tri_squ_sin rom_freq_tri_squ_sin_i (
						  .addr(per_adx_in),
						  .clk(clk),
						  .en(per_adx_valid_in),
						  .rstn(rstn),
						  .data_out(sstep_cnt_thr_tri_squ_sin)
						  );   

   mem_rom_freq_saw rom_freq_saw_i (
				  .addr(per_adx_in),
				  .clk(clk),
				  .en(per_adx_valid_in),
				  .rstn(rstn),
				  .data_out(sstep_cnt_thr_saw)
				  );   
   
   always @ (  wsel or  sstep_cnt_thr_saw or  sstep_cnt_thr_tri_squ_sin)
     begin
        if ( wsel == 2'b10 ) 
          begin
             sstep_cnt_thr <= sstep_cnt_thr_saw;
          end
        else
          begin 
             sstep_cnt_thr <= sstep_cnt_thr_tri_squ_sin;
          end
     end // always @ (  wsel or  sstep_cnt_thr_saw or  sstep_cnt_thr_tri_squ_sin)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             snote_enable <= 1'b0;
             swave_enable <= 1'b0;
             sclick_enable <= 1'b0;
          end
        else
          begin 
             snote_enable <= per_adx_valid_in;
             swave_enable <= snote_enable;
             sclick_enable <= click_en_in;
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             sstep_cnt <= 0;
          end
        else
          begin 
             if ( ( snote_enable == 1'b0 ) & ( sclick_enable == 1'b0 ) ) 
               begin
                  sstep_cnt <= 0;
               end
             else
               begin 
                  if ( sstep_cnt_tc == 1'b1 ) 
                    begin
                       sstep_cnt <= 0;
                    end
                  else
                    begin 
                       sstep_cnt <= ( sstep_cnt + 1'b1 );
                    end
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ ( sstep_cnt or sstep_cnt_thr )
     begin
        if ( $unsigned(sstep_cnt) >= $unsigned(( sstep_cnt_thr - 1'b1 )) ) 
          begin
             sstep_cnt_tc <= 1'b1;
          end
        else
          begin 
             sstep_cnt_tc <= 1'b0;
          end
     end // always @ ( sstep_cnt or sstep_cnt_thr )
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             swave_cnt_tri <= 0;	   
          end
        else
          begin 
             if ( ( sclick_enable == 1'b0 ) & ( snote_enable == 1'b0 ) ) 
               begin
                  swave_cnt_tri <= 0;
               end
             else
               begin 
                  if ( sstep_cnt_tc == 1'b1 ) 
                    begin
                       if ( swave_cnt_tri_down_up_n == 1'b0 ) 
                         begin
                            if ( swave_cnt_neg == 1'b1 ) 
                              begin
                                 swave_cnt_tri <= (  ~( swave_cnt_tri) + 1'b1 );
                              end
                            else
                              begin 
                                 swave_cnt_tri <= ( swave_cnt_tri + 1'b1 );
                              end
                         end
                       else
                         begin 
                            swave_cnt_tri <= ( swave_cnt_tri - 1'b1 );
                         end
                    end
               end

          end
     end // always @ (  posedge clk or negedge rstn)
   
   assign swave_squ_thr_up = cwave_mx - 1'b1;
   assign swave_squ_thr_down = cwave_mn + 1'b1;
   
   always @ (  swave_cnt_tri)
     begin
        if ( $signed(swave_cnt_tri) == $signed(cwave_mx) )
          begin
             swave_cnt_tri_is_max <= 1'b1;
          end
        else
          begin 
             swave_cnt_tri_is_max <= 1'b0;
          end
     end // always @ (  swave_cnt_tri)
   
   always @ (  swave_cnt_tri or  swave_squ_thr_up)
     begin
        if ( $signed(swave_cnt_tri) == $signed(swave_squ_thr_up) ) 
          begin
             swave_cnt_tri_is_squ_thr_up <= 1'b1;
          end
        else
          begin 
             swave_cnt_tri_is_squ_thr_up <= 1'b0;
          end
     end // always @ (  swave_cnt_tri or  swave_squ_thr_up)
   
   always @ (  swave_cnt_tri)
     begin
        if ( $signed(swave_cnt_tri) == $signed(cwave_mn) )
          begin
             swave_cnt_tri_is_min <= 1'b1;
          end
        else
          begin 
             swave_cnt_tri_is_min <= 1'b0;
          end
     end // always @ (  swave_cnt_tri)
   
   always @ (  swave_cnt_tri or  swave_squ_thr_down)
     begin
        if ( $signed(swave_cnt_tri) == $signed(swave_squ_thr_down) ) 
          begin
             swave_cnt_tri_is_squ_thr_down <= 1'b1;
          end
        else
          begin 
             swave_cnt_tri_is_squ_thr_down <= 1'b0;
          end
     end // always @ (  swave_cnt_tri or  swave_squ_thr_down)
   
   always @ (  wsel or  swave_cnt_tri_is_max)
     begin
        if ( wsel == 2'b10 ) 
          begin
             swave_cnt_neg <= swave_cnt_tri_is_max;
          end
        else
          begin 
             swave_cnt_neg <= 1'b0;
          end
     end // always @ (  wsel or  swave_cnt_tri_is_max)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             swave_cnt_tri_down_up_n <= 1'b0;
          end
        else
          begin 
             if ( ( swave_cnt_tri_is_max == 1'b1 ) & ( swave_cnt_tri_is_min == 1'b0 ) ) 
               begin
                  if ( wsel == 2'b10 ) 
                    begin
                       swave_cnt_tri_down_up_n <= 1'b0;
                    end
                  else
                    begin 
                       swave_cnt_tri_down_up_n <= 1'b1;
                    end
               end
             else
               begin 
                  if ( ( swave_cnt_tri_is_max == 1'b0 ) & ( swave_cnt_tri_is_min == 1'b1 ) ) 
                    begin
                       swave_cnt_tri_down_up_n <= 1'b0;
                    end
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             swave_squ_sel <= 1'b0;
          end
        else
          begin 
             if ( ( ( sstep_cnt_tc == 1'b1 ) & ( swave_cnt_tri_down_up_n == 1'b0 ) ) & ( swave_cnt_tri_is_squ_thr_up == 1'b1 ) ) 
               begin
                  swave_squ_sel <= 1'b1;
               end
             else
               begin 
                  if ( ( ( sstep_cnt_tc == 1'b1 ) & ( swave_cnt_tri_down_up_n == 1'b1 ) ) & ( swave_cnt_tri_is_squ_thr_down == 1'b1 ) ) 
                    begin
                       swave_squ_sel <= 1'b0;
                    end
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             swave_tri <= 0;	   
             swave_saw <= 0;	   
             swave_squ <= 0;	   
          end
        else
          begin 
             if ( swave_enable == 1'b1 ) 
               begin
                  swave_tri <= swave_cnt_tri;
                  swave_saw <= swave_cnt_tri;
                  if ( swave_squ_sel == 1'b1 ) 
                    begin
                       swave_squ <= cwave_mx;		       
                    end
                  else
                    begin 
                       swave_squ <= cwave_mn;		       
                    end
               end
             else
               begin 
                  swave_tri <= 0;		   
                  swave_saw <= 0;		  
                  swave_squ <= 0;		   
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ (  swave_cnt_tri)
     begin
        if ( swave_cnt_tri[( nbit_wav_in - 1 )] == 1'b0 ) 
          begin
	     //smem_rom_ampl_sin_adx <= swave_cnt_tri;  
             smem_rom_ampl_sin_adx <= swave_cnt_tri[( nbit_wav_in - 2 ):0];
          end
        else
          begin 
             //smem_rom_ampl_sin_adx <= (  ~( swave_cnt_tri) + 1'b1 );
   	     smem_rom_ampl_sin_adx <= (  ~( swave_cnt_tri[( nbit_wav_in - 2 ):0]) + 1'b1 );
          end
     end // always @ (  swave_cnt_tri)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             smem_rom_ampl_sin_val_is_neg <= 1'b0;
          end
        else
          begin 
             smem_rom_ampl_sin_val_is_neg <= swave_cnt_tri[( nbit_wav_in - 1 )];
          end
     end // always @ (  posedge clk or negedge rstn)
   
   mem_rom_ampl_sin rom_ampl_sin_i (
				  .addr(smem_rom_ampl_sin_adx),
				  .clk(clk),
				  .en(swave_enable),
				  .rstn(rstn),
				  .data_out(smem_rom_ampl_sin_val)
				  );   
   
   always @ (  smem_rom_ampl_sin_val_is_neg or  smem_rom_ampl_sin_val)
     begin
        if ( smem_rom_ampl_sin_val_is_neg == 1'b0 ) 
          begin
             swave_sin <= smem_rom_ampl_sin_val;
          end
        else
          begin 
             swave_sin <= (  ~( smem_rom_ampl_sin_val) + 1'b1 );
          end
     end // always @ (  smem_rom_ampl_sin_val_is_neg or  smem_rom_ampl_sin_val)
   
   always @ (  wsel or  swave_tri or  swave_squ or  swave_saw or  swave_sin)
     begin
        case ( wsel ) 
          2'b00:
            begin
               swave <= swave_tri;
            end
          2'b01:
            begin
               swave <= swave_squ;
            end
          2'b10:
            begin
               swave <= swave_saw;
            end
          2'b11:
            begin
               swave <= swave_sin;
            end
        endcase
     end // always @ (  wsel or  swave_tri or  swave_squ or  swave_saw or  swave_sin)
   
   assign wout = { swave, 2'b00 };
endmodule 
