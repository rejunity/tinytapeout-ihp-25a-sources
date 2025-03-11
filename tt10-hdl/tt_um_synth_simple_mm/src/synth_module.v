module synth_module_v(
		      clk,
		      rstn,
		      sw,
		      note_enn,
		      pwm_out
		      );
   parameter [31:0]nnotes  = 5;
   parameter [31:0]nswitches  = 8;
   
   input clk;
   input rstn;
   input [( nswitches - 1 ):0] sw;
   input [( nnotes - 1 ):0]    note_enn;
   output 		       pwm_out;
   
   //localparam debug_mode  = 0;

   localparam nbit_wav_in  = 6;
   //localparam nbit_bar  = 4;
   //localparam nbit_adsr_idx  = 4;
   //localparam max_adsr_idx  = 14;
   localparam nbit_sample  = 8;
   localparam nbit_notes = 7;   
   
   localparam [7:0] cpwm_period  = ( 2 ** 8 ) - 1;

   localparam signed [7:0] cpwm_offset  = 8'd127;   
   localparam [nbit_notes-1:0] cC0  = 57;   
   localparam [nbit_notes-1:0] cD0  = 59;   
   localparam [nbit_notes-1:0] cEb0 = 60;
   localparam [nbit_notes-1:0] cE0  = 61;   
   localparam [nbit_notes-1:0] cF0  = 62;
   localparam [nbit_notes-1:0] cGb0  = 63;
   localparam [nbit_notes-1:0] cG0  = 64;
   localparam [nbit_notes-1:0] cAb0  = 65;
   localparam [nbit_notes-1:0] cA0  = 66;
   localparam [nbit_notes-1:0] cBb0  = 67;
   localparam [nbit_notes-1:0] cB0  = 68;
   localparam [nbit_notes-1:0] cC1  = 69;

   wire [nbit_notes-1:0]       cCFG_Strangelove0[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Strangelove1[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Smoke_on_the_water[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_PMAJ[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Oxygene0[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Oxygene1[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Oxygene2[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Wake_me_up_Fix_you[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_The_final_countdown0[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_The_final_countdown1[0:nnotes-1];         
   wire [nbit_notes-1:0]       cCFG_Dont_go1[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_FC[0:nnotes-1];    
   wire [nbit_notes-1:0]       cCFG_Knocking_at_your_back_door0[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_Knocking_at_your_back_door1[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_MAJ[0:nnotes-1];
   wire [nbit_notes-1:0]       cCFG_CG[0:nnotes-1];                 

   wire [3:0] 		       snotes_sel;
   localparam min_adsr_lev_idx  = 0;
   localparam max_adsr_lev_idx  = 10;

   wire [nbit_wav_in-1:0]      cadsr_sus_levels[min_adsr_lev_idx:max_adsr_lev_idx];   
   
   wire [( nnotes - 1 ):0]     snote_en;
   wire [( nnotes - 1 ):0]     snote_en_one_hot;   
   wire [1:0] 		       swave_sel;
   //localparam cadsr_a_t_idx0  = 0;
   //localparam cadsr_d_t_idx0  = 0;
   //localparam cadsr_r_t_idx0  = 0;
   //localparam cadsr_a_t_idx1  = 0;
   //localparam cadsr_d_t_idx1  = 10;
   //localparam cadsr_r_t_idx1  = 0;
   //localparam cadsr_a_t_idx2  = 10;
   //localparam cadsr_d_t_idx2  = 0;
   //localparam cadsr_r_t_idx2  = 0;
   //localparam cadsr_a_t_idx3  = 10;
   //localparam cadsr_d_t_idx3  = 10;
   //localparam cadsr_r_t_idx3  = 0;
   wire [1:0] 		       sadsr_sel;
   wire [5:0] 		       sadsr_value;
   wire 		       sadsr_vout;
   wire 		       sclick_enable;
   wire [7:0] 		       ssynth_out;
   wire 		       spwm_clear;
   reg [( nswitches - 1 ):0]   ssw_reg[2:0];
   reg [( nnotes - 1 ):0]      snote_synch[2:0];
   
   reg [nbit_notes-1:0]        snotes[0:nnotes-1];
   wire [6:0] 		       sper_adx;   

   wire 		       sper_adx_valid;   
   reg [2:0] 		       snote_idx;   
   reg [3:0] 		       sadsr_a_t_idx;
   reg [3:0] 		       sadsr_d_t_idx;
   reg [5:0] 		       sadsr_s_level;
   reg [3:0] 		       sadsr_r_t_idx;
   reg signed [7:0] 	       ssynth_out_adsr;
   reg [7:0] 		       scnt_pwm;
   reg 			       scnt_pwm_tc;
   reg [7:0] 		       scnt_pwm_on;
   reg 			       scnt_pwm_on_en;

   reg 			       pwm_out;

   assign cadsr_sus_levels[0] = 0;
   assign cadsr_sus_levels[1] = 6;
   assign cadsr_sus_levels[2] = 13;
   assign cadsr_sus_levels[3] = 19;
   assign cadsr_sus_levels[4] = 25;
   assign cadsr_sus_levels[5] = 32;
   assign cadsr_sus_levels[6] = 38;
   assign cadsr_sus_levels[7] = 44;
   assign cadsr_sus_levels[8] = 50;
   assign cadsr_sus_levels[9] = 57;
   assign cadsr_sus_levels[10] = 63;

   assign cCFG_Strangelove0[0]=cC0;
   assign cCFG_Strangelove0[1]=cEb0;
   assign cCFG_Strangelove0[2]=cF0;
   assign cCFG_Strangelove0[3]=cG0;
   assign cCFG_Strangelove0[4]=cBb0;

   assign cCFG_Strangelove1[0]=cC0;
   assign cCFG_Strangelove1[1]=cD0;
   assign cCFG_Strangelove1[2]=cEb0;
   assign cCFG_Strangelove1[3]=cF0;
   assign cCFG_Strangelove1[4]=cAb0;

   assign cCFG_Smoke_on_the_water[0]=cD0;
   assign cCFG_Smoke_on_the_water[1]=cE0;
   assign cCFG_Smoke_on_the_water[2]=cF0;
   assign cCFG_Smoke_on_the_water[3]=cG0;
   assign cCFG_Smoke_on_the_water[4]=cAb0;

   assign cCFG_PMAJ[0]=cC0;
   assign cCFG_PMAJ[1]=cD0;
   assign cCFG_PMAJ[2]=cE0;
   assign cCFG_PMAJ[3]=cG0;
   assign cCFG_PMAJ[4]=cA0;

   assign cCFG_Oxygene0[0]=cC0;
   assign cCFG_Oxygene0[1]=cEb0;
   assign cCFG_Oxygene0[2]= cG0;
   assign cCFG_Oxygene0[3]=cBb0;
   assign cCFG_Oxygene0[4]= cC1;

   assign cCFG_Oxygene1[0]=cC0;
   assign cCFG_Oxygene1[1]=cD0;
   assign cCFG_Oxygene1[2]=cG0;
   assign cCFG_Oxygene1[3]=cA0;
   assign cCFG_Oxygene1[4]=cBb0;

   assign cCFG_Oxygene2[0]=cC0;
   assign cCFG_Oxygene2[1]=cEb0;
   assign cCFG_Oxygene2[2]= cF0;
   assign cCFG_Oxygene2[3]=cG0;
   assign cCFG_Oxygene2[4]=cA0;

   assign cCFG_Wake_me_up_Fix_you[0]=cD0;
   assign cCFG_Wake_me_up_Fix_you[1]=cEb0;
   assign cCFG_Wake_me_up_Fix_you[2]= cG0;
   assign cCFG_Wake_me_up_Fix_you[3]=cAb0;
   assign cCFG_Wake_me_up_Fix_you[4]= cBb0;

   assign cCFG_The_final_countdown0[0]=cC0;
   assign cCFG_The_final_countdown0[1]=cEb0;
   assign cCFG_The_final_countdown0[2]= cF0;
   assign cCFG_The_final_countdown0[3]=cG0;
   assign cCFG_The_final_countdown0[4]=cAb0;

   assign cCFG_The_final_countdown1[0]=cC0;
   assign cCFG_The_final_countdown1[1]=cD0;
   assign cCFG_The_final_countdown1[2]=cEb0;
   assign cCFG_The_final_countdown1[3]= cF0;
   assign cCFG_The_final_countdown1[4]=cG0;

   assign cCFG_Dont_go1[0]=cEb0;
   assign cCFG_Dont_go1[1]= cF0;
   assign cCFG_Dont_go1[2]=cG0;
   assign cCFG_Dont_go1[3]=cAb0;
   assign cCFG_Dont_go1[4]= cC1;

   assign cCFG_FC[0]=cF0;
   assign cCFG_FC[1]=cG0;
   assign cCFG_FC[2]=cA0;
   assign cCFG_FC[3]=cB0;
   assign cCFG_FC[4]=cC1;

   assign cCFG_Knocking_at_your_back_door0[0]=cD0;
   assign cCFG_Knocking_at_your_back_door0[1]=cE0;
   assign cCFG_Knocking_at_your_back_door0[2]=cGb0;
   assign cCFG_Knocking_at_your_back_door0[3]= cG0;
   assign cCFG_Knocking_at_your_back_door0[4]=cA0;

   assign cCFG_Knocking_at_your_back_door1[0]=cC0;
   assign cCFG_Knocking_at_your_back_door1[1]=cD0;
   assign cCFG_Knocking_at_your_back_door1[2]=cE0;
   assign cCFG_Knocking_at_your_back_door1[3]=cGb0;
   assign cCFG_Knocking_at_your_back_door1[4]= cG0;

   assign cCFG_MAJ[0]=cC0;
   assign cCFG_MAJ[1]=cE0;
   assign cCFG_MAJ[2]=cG0;
   assign cCFG_MAJ[3]=cB0;
   assign cCFG_MAJ[4]=cC1;

   assign cCFG_CG[0]=cC0;
   assign cCFG_CG[1]=cD0;
   assign cCFG_CG[2]=cE0;
   assign cCFG_CG[3]=cF0;
   assign cCFG_CG[4]=cG0;
   
   assign sclick_enable = 1'b0;
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             ssw_reg[0] <= 0;
	     ssw_reg[1] <= 0;
	     ssw_reg[2] <= 0;	     
             snote_synch[0] <= 5'b1;
             snote_synch[1] <= 5'b1;
             snote_synch[2] <= 5'b1;	     	     
          end
        else
          begin 
             ssw_reg[0] <= sw;
	     ssw_reg[1] <= ssw_reg[0];
	     ssw_reg[2] <= ssw_reg[1];	     
             snote_synch[0] <= note_enn;
             snote_synch[1] <= snote_synch[0];
	     snote_synch[2] <= snote_synch[1];	     
          end
     end // always @ (  posedge clk or negedge rstn)
   
   assign swave_sel = ssw_reg[2][1:0];
   assign sadsr_sel = ssw_reg[2][3:2];
   assign snotes_sel = ssw_reg[2][7:4];
   assign snote_en =  ~( snote_synch[2]);   
   
   always @ (  snotes_sel)
     begin
        case (snotes_sel)
	  0 :
	    begin
	       snotes[0]<=cCFG_Strangelove0[0];
	       snotes[1]<=cCFG_Strangelove0[1];
	       snotes[2]<=cCFG_Strangelove0[2];
	       snotes[3]<=cCFG_Strangelove0[3];
	       snotes[4]<=cCFG_Strangelove0[4];
	    end
	  4 :
	    begin
	       snotes[0]<=cCFG_Strangelove1[0];
	       snotes[1]<=cCFG_Strangelove1[1];
	       snotes[2]<=cCFG_Strangelove1[2];
	       snotes[3]<=cCFG_Strangelove1[3];
	       snotes[4]<=cCFG_Strangelove1[4];
	    end
	  8 :
	    begin
	       snotes[0]<=cCFG_Smoke_on_the_water[0];
	       snotes[1]<=cCFG_Smoke_on_the_water[1];
	       snotes[2]<=cCFG_Smoke_on_the_water[2];
	       snotes[3]<=cCFG_Smoke_on_the_water[3];
	       snotes[4]<=cCFG_Smoke_on_the_water[4];
	    end
	  12 :
	    begin
	       snotes[0]<=cCFG_PMAJ[0];
	       snotes[1]<=cCFG_PMAJ[1];
	       snotes[2]<=cCFG_PMAJ[2];
	       snotes[3]<=cCFG_PMAJ[3];
	       snotes[4]<=cCFG_PMAJ[4];
	    end
	  1 :
	    begin
	       snotes[0]<=cCFG_Oxygene0[0];
	       snotes[1]<=cCFG_Oxygene0[1];
	       snotes[2]<=cCFG_Oxygene0[2];
	       snotes[3]<=cCFG_Oxygene0[3];
	       snotes[4]<=cCFG_Oxygene0[4];
	    end
	  5 :
	    begin
	       snotes[0]<=cCFG_Oxygene1[0];
	       snotes[1]<=cCFG_Oxygene1[1];
	       snotes[2]<=cCFG_Oxygene1[2];
	       snotes[3]<=cCFG_Oxygene1[3];
	       snotes[4]<=cCFG_Oxygene1[4];
	    end
	  9 :
	    begin
	       snotes[0]<=cCFG_Oxygene2[0];
	       snotes[1]<=cCFG_Oxygene2[1];
	       snotes[2]<=cCFG_Oxygene2[2];
	       snotes[3]<=cCFG_Oxygene2[3];
	       snotes[4]<=cCFG_Oxygene2[4];
	    end
	  13 :
	    begin
	       snotes[0]<=cCFG_Wake_me_up_Fix_you[0];
	       snotes[1]<=cCFG_Wake_me_up_Fix_you[1];
	       snotes[2]<=cCFG_Wake_me_up_Fix_you[2];
	       snotes[3]<=cCFG_Wake_me_up_Fix_you[3];
	       snotes[4]<=cCFG_Wake_me_up_Fix_you[4];
	    end
	  2 :
	    begin
	       snotes[0]<=cCFG_The_final_countdown0[0];
	       snotes[1]<=cCFG_The_final_countdown0[1];
	       snotes[2]<=cCFG_The_final_countdown0[2];
	       snotes[3]<=cCFG_The_final_countdown0[3];
	       snotes[4]<=cCFG_The_final_countdown0[4];
	    end
	  6 :
	    begin
	       snotes[0]<=cCFG_The_final_countdown1[0];
	       snotes[1]<=cCFG_The_final_countdown1[1];
	       snotes[2]<=cCFG_The_final_countdown1[2];
	       snotes[3]<=cCFG_The_final_countdown1[3];
	       snotes[4]<=cCFG_The_final_countdown1[4];
	    end
	  10 :
	    begin
	       snotes[0]<=cCFG_Dont_go1[0];
	       snotes[1]<=cCFG_Dont_go1[1];
	       snotes[2]<=cCFG_Dont_go1[2];
	       snotes[3]<=cCFG_Dont_go1[3];
	       snotes[4]<=cCFG_Dont_go1[4];
	    end
	  14 :
	    begin
	       snotes[0]<=cCFG_FC[0];
	       snotes[1]<=cCFG_FC[1];
	       snotes[2]<=cCFG_FC[2];
	       snotes[3]<=cCFG_FC[3];
	       snotes[4]<=cCFG_FC[4];
	    end
	  3 :
	    begin
	       snotes[0]<=cCFG_Knocking_at_your_back_door0[0];
	       snotes[1]<=cCFG_Knocking_at_your_back_door0[1];
	       snotes[2]<=cCFG_Knocking_at_your_back_door0[2];
	       snotes[3]<=cCFG_Knocking_at_your_back_door0[3];
	       snotes[4]<=cCFG_Knocking_at_your_back_door0[4];
	    end
	  7 :
	    begin
	       snotes[0]<=cCFG_Knocking_at_your_back_door1[0];
	       snotes[1]<=cCFG_Knocking_at_your_back_door1[1];
	       snotes[2]<=cCFG_Knocking_at_your_back_door1[2];
	       snotes[3]<=cCFG_Knocking_at_your_back_door1[3];
	       snotes[4]<=cCFG_Knocking_at_your_back_door1[4];
	    end
	  11 :
	    begin
	       snotes[0]<=cCFG_MAJ[0];
	       snotes[1]<=cCFG_MAJ[1];
	       snotes[2]<=cCFG_MAJ[2];
	       snotes[3]<=cCFG_MAJ[3];
	       snotes[4]<=cCFG_MAJ[4];
	    end
	  15 :
	    begin
	       snotes[0]<=cCFG_CG[0];
	       snotes[1]<=cCFG_CG[1];
	       snotes[2]<=cCFG_CG[2];
	       snotes[3]<=cCFG_CG[3];
	       snotes[4]<=cCFG_CG[4];
	    end	  
        endcase
     end // always @ (  snotes_sel)

   assign sper_adx_valid = snote_en[0] | snote_en[1] | snote_en[2] | snote_en[3] | snote_en[4];
   
   assign snote_en_one_hot[0] = snote_en[0];
   assign snote_en_one_hot[1] = snote_en[1] & ~snote_en_one_hot[0];
   assign snote_en_one_hot[2] = snote_en[2] & ~snote_en_one_hot[1];
   assign snote_en_one_hot[3] = snote_en[3] & ~snote_en_one_hot[2];
   assign snote_en_one_hot[4] = snote_en[4] & ~snote_en_one_hot[3];   
   
   always @ ( snote_en_one_hot )
     begin
	case (snote_en_one_hot)
	  5'b10000:
	    snote_idx <= 3'd4;
	  5'b01000:
	    snote_idx <= 3'd3;
	  5'b00100:
	    snote_idx <= 3'd2;
	  5'b00010:
	    snote_idx <= 3'd1;
	  default :
	    snote_idx <= 3'd0;
	endcase // case (snote_en_one_hot)
     end
   
   assign sper_adx = snotes[snote_idx];   
   
   always @ (  sadsr_sel)
     begin
        case ( sadsr_sel ) 
          2'b00:
            begin
               sadsr_a_t_idx <= 0;	   
               sadsr_d_t_idx <= 0;	   
               sadsr_s_level <= cadsr_sus_levels[10];
               sadsr_r_t_idx <= 0;	   
            end
          2'b01:
            begin
               sadsr_a_t_idx <= 0;	   
               sadsr_d_t_idx <= 10;
               sadsr_s_level <= cadsr_sus_levels[0];
               sadsr_r_t_idx <= 0;	   
            end
          2'b10:
            begin
               sadsr_a_t_idx <= 10;
               sadsr_d_t_idx <= 0;	   
               sadsr_s_level <= cadsr_sus_levels[10];
               sadsr_r_t_idx <= 0;
            end
          2'b11:
            begin
               sadsr_a_t_idx <= 10;
               sadsr_d_t_idx <= 10;
               sadsr_s_level <= cadsr_sus_levels[0];
               sadsr_r_t_idx <= 0;	   
            end
        endcase
     end // always @ (  sadsr_sel)

	 
   adsr_v #(
            .nbit_data(6),
            .nbit_idx(4),
            .max_idx(14)
	    //.max_idx(10)
            ) adsr_i (
		      .a_t_idx(sadsr_a_t_idx),
		      .clk(clk),
		      .d_t_idx(sadsr_d_t_idx),
		      .r_t_idx(sadsr_r_t_idx),
		      .rstn(rstn),
		      .s_level(sadsr_s_level),
		      .vin(sper_adx_valid),
		      .dout(sadsr_value),
		      .vout(sadsr_vout)
		      );
	
   wav_gen_simple_v #(
		      //.debug_mode(0),
		      .nbit_freq_adx(7),
		      .nbit_wav_in(6),
		      .nbit_wav_out(8)
		      //.nbit_bar(4)
		      ) wav_gen_1 (
				   .click_en_in(sclick_enable),
				   .clk(clk),
				   .per_adx_in(sper_adx),
				   .per_adx_valid_in(sadsr_vout),
	   			   //.per_adx_valid_in(sper_adx_valid),
				   .rstn(rstn),
				   .wsel(swave_sel),
				   .wout(ssynth_out)
				   );
   
   always @ (  ssynth_out or  sadsr_value)
     begin : synth_with_adsr
        reg signed [nbit_sample+nbit_wav_in:0]tmp;
        tmp = ( $signed(ssynth_out) * $signed({1'b0, sadsr_value}) );	
        ssynth_out_adsr <= $signed(tmp[nbit_sample+nbit_wav_in-1:nbit_wav_in]);	
     end
   
   //assign ssynth_out_adsr = ssynth_out;
	
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             scnt_pwm <= 0;
          end
        else
          begin 
             if ( scnt_pwm_tc == 1'b1 ) 
               begin
                  scnt_pwm <= 0;		   
               end
             else
               begin 
                  scnt_pwm <= ( scnt_pwm + 1'b1 );
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always @ (  scnt_pwm)
     begin
        //if ( $unsigned(scnt_pwm) == $unsigned(( 2 ** 8 ) - 1 ) ) 
	if ( $unsigned(scnt_pwm) == $unsigned(cpwm_period) )
          begin
             scnt_pwm_tc <= 1'b1;
          end
        else
          begin 
             scnt_pwm_tc <= 1'b0;
          end
     end // always @ (  scnt_pwm)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             scnt_pwm_on <= 0;	   
          end
        else
          begin 
             if ( scnt_pwm_tc == 1'b1 ) 
               begin
                  scnt_pwm_on <= $unsigned( ssynth_out_adsr + cpwm_offset );
               end
             else
               begin 
                  if ( scnt_pwm_on_en == 1'b1 ) 
                    begin
                       scnt_pwm_on <= ( scnt_pwm_on - 1'b1 );
                    end
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
   always  @ (scnt_pwm_on)
     begin
        if ( scnt_pwm_on != 0 ) 
          begin
             scnt_pwm_on_en <= 1'b1;
          end
        else
          begin 
             scnt_pwm_on_en <= 1'b0;
          end
     end // always  @ (scnt_pwm_on)
   
   assign spwm_clear =  ~( scnt_pwm_on_en);
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             pwm_out <= 1'b0;
          end
        else
          begin 
             if ( spwm_clear == 1'b1 ) 
               begin
                  pwm_out <= 1'b0;
               end
             else
               begin 
                  pwm_out <= 1'b1;
               end
          end
     end // always @ (  posedge clk or negedge rstn)
   
endmodule 
