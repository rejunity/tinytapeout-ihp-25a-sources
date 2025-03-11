module adsr_v(
            clk,
            rstn,
            vin,
            a_t_idx,
            d_t_idx,
            s_level,
            r_t_idx,
            dout,
            vout
	    );
   
   parameter [31:0]nbit_data  = 6;
   parameter [31:0]nbit_idx  = 4;
   parameter [31:0]max_idx  = 14;
   
   input clk;
   input rstn;
   input vin;
   input [( nbit_idx - 1 ):0] a_t_idx;
   input [( nbit_idx - 1 ):0] d_t_idx;
   input [( nbit_data - 1 ):0] s_level;
   input [( nbit_idx - 1 ):0]  r_t_idx;
   output [( nbit_data - 1 ):0] dout;
   output 			vout;
   
   localparam cnbit_cnt  = 28;
   //localparam cnbit_cnt  = 24;
   localparam [cnbit_cnt-1:0] cstep_thr0  = 28'd190;
   //localparam [cnbit_cnt-1:0] cstep_thr0  = 24'd190;	
   
   localparam clog2_n_pwl  = 3;
   localparam [clog2_n_pwl-1:0] cn_pwl  = 7;
   localparam [clog2_n_pwl-1:0] cpwl_thr = cn_pwl - 1;
   
   localparam [nbit_data-1:0] cval_max  = ( ( 2 ** nbit_data ) - 1 );
   //localparam cval_min  = 0;   
   
   wire 			sattack_tc;
   wire 			sinit_cnt_from_attack;
   wire 			sinit_cnt_from_decay;
   wire 			sinit_cnt_from_release;
   reg [2:0] 			sstate;
   reg 				sis_idle;
   reg 				sis_attack;
   reg 				sis_decay;
   reg 				sis_sustain;
   reg 				sis_release;
   reg [27:0] 			scnt_step_thr0;
   
   reg [27:0] 			scnt_step_thri;
   reg [27:0] 			scnt_step;
   reg 				scnt_step_tc;
   reg [( nbit_data - 1 ):0] 	scnt_val;
   reg 				sdecay_tc;
   reg 				srelease_tc;
   reg 				scnt_val_tc;
   reg [clog2_n_pwl-1:0] 			scnt_pwl;
   reg 				scnt_pwl_tc;

   wire [cnbit_cnt-1:0] 		cstep_thr0_v [0:max_idx];   
   wire [nbit_data-1:0] 		cval_thr_v [0:cn_pwl-1];   

   assign cstep_thr0_v[0] = cstep_thr0;
   assign cstep_thr0_v[1] = {cstep_thr0_v[0][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[2] = {cstep_thr0_v[1][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[3] = {cstep_thr0_v[2][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[4] = {cstep_thr0_v[3][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[5] = {cstep_thr0_v[4][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[6] = {cstep_thr0_v[5][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[7] = {cstep_thr0_v[6][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[8] = {cstep_thr0_v[7][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[9] = {cstep_thr0_v[8][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[10] = {cstep_thr0_v[9][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[11] = {cstep_thr0_v[10][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[12] = {cstep_thr0_v[11][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[13] = {cstep_thr0_v[12][cnbit_cnt-2:0], 1'b1};
   assign cstep_thr0_v[14] = {cstep_thr0_v[13][cnbit_cnt-2:0], 1'b1};   
   
   assign cval_thr_v[0] = 15;
   assign cval_thr_v[1] = 39;
   assign cval_thr_v[2] = 51;
   assign cval_thr_v[3] = 59;      
   assign cval_thr_v[4] = 61;
   assign cval_thr_v[5] = 62;
   assign cval_thr_v[6] = 63;         
   
   /// FSM
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             sstate <= 3'b000;
          end
        else
          begin 
             case ( sstate ) 
               3'b000:
                 begin
                    if ( vin == 1'b1 ) 
                      begin
                         sstate <= 3'b001;
                      end
                 end
               3'b001:
                 begin
                    if ( vin == 1'b0 ) 
                      begin
                         sstate <= 3'b100;
                      end
                    else
                      begin 
                         if ( sattack_tc == 1'b1 ) 
                           begin
                              sstate <= 3'b010;
                           end
                      end
                 end
               3'b010:
                 begin
                    if ( vin == 1'b0 ) 
                      begin
                         sstate <= 3'b100;
                      end
                    else
                      begin 
                         if ( sdecay_tc == 1'b1 ) 
                           begin
                              sstate <= 3'b011;
                           end
                      end
                 end
               3'b011:
                 begin
                    if ( vin == 1'b0 ) 
                      begin
                         sstate <= 3'b100;
                      end
                 end
               3'b100:
                 begin
                    if ( vin == 1'b1 ) 
                      begin
                         sstate <= 3'b001;
                      end
                    else
                      begin 
                         if ( srelease_tc == 1'b1 ) 
                           begin
                              sstate <= 3'b000;
                           end
                      end
                 end
               default :
                 begin
                    sstate <= 3'b000;
                 end
             endcase
          end
     end // always @ (  posedge clk)

   /// FSM outputs
   
   always @ (  sstate)
     begin
        sis_idle <= 1'b0;
        sis_attack <= 1'b0;
        sis_decay <= 1'b0;
        sis_sustain <= 1'b0;
        sis_release <= 1'b0;
        case ( sstate ) 
          3'b000:
            begin
               sis_idle <= 1'b1;
            end
          3'b001:
            begin
               sis_attack <= 1'b1;
            end
          3'b010:
            begin
               sis_decay <= 1'b1;
            end
          3'b011:
            begin
               sis_sustain <= 1'b1;
            end
          3'b100:
            begin
               sis_release <= 1'b1;
            end
          default :
            begin
               sis_idle <= 1'b0;
               sis_attack <= 1'b0;
               sis_decay <= 1'b0;
               sis_sustain <= 1'b0;
               sis_release <= 1'b0;
            end
        endcase
     end // always @ (  sstate)
   
   assign sinit_cnt_from_attack = ( sis_attack &  ~( vin) );
   assign sinit_cnt_from_decay = ( sis_decay &  ~( vin) );
   assign sinit_cnt_from_release = ( sis_release & vin );
   
   always @ (  sis_idle or  sis_attack or  sis_decay or  sis_release or  a_t_idx or  d_t_idx or  r_t_idx)
     begin
        if ( sis_idle == 1'b1 ) 
          begin
             scnt_step_thr0 <= cstep_thr0_v[0];
          end
        else
          begin 
             if ( sis_attack == 1'b1 ) 
               begin
                  scnt_step_thr0 <= cstep_thr0_v[a_t_idx];
               end
             else
               begin 
                  if ( sis_decay == 1'b1 ) 
                    begin
                       scnt_step_thr0 <= cstep_thr0_v[d_t_idx];
                    end
                  else
                    begin 
                       if ( sis_release == 1'b1 ) 
			 begin
                            scnt_step_thr0 <= cstep_thr0_v[r_t_idx];
			 end
                       else
			 begin 
                            scnt_step_thr0 <= cstep_thr0_v[0];
			 end
                    end
               end
          end
     end // always @ (  sis_idle or  sis_attack or  sis_decay or  sis_release or  a_t_idx or  d_t_idx or  r_t_idx)
   
   always @ (  scnt_step_thr0 or  scnt_pwl)
     begin : cnt_step_threshold
	reg [cnbit_cnt-1:0] tmp [0:cn_pwl-1];
	
        integer 	    idx;
        tmp[0] = scnt_step_thr0;
        for ( idx = 1 ; ( idx <= 6 ) ; idx = ( idx + 1 ) )
          begin 
             tmp[idx] = { tmp[idx-1][cnbit_cnt-2:0], 1'b1 };
          end
        scnt_step_thri <= tmp[scnt_pwl];
     end
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             scnt_step <= 0;
          end
        else
          begin 
             if ( ( ( ( ( sis_idle == 1'b1 ) | ( sis_sustain == 1'b1 ) ) | ( sinit_cnt_from_attack == 1'b1 ) ) | ( sinit_cnt_from_decay == 1'b1 ) ) | ( sinit_cnt_from_release == 1'b1 ) ) 
               begin
                  scnt_step <= 0;
               end
             else
               begin 
                  if ( ( ( sis_attack == 1'b1 ) | ( sis_decay == 1'b1 ) ) | ( sis_release == 1'b1 ) ) 
                    begin
                       if ( scnt_step_tc == 1'b1 ) 
                         begin
                            scnt_step <= 0;
                         end
                       else
                         begin 
                            scnt_step <= ( scnt_step + 1'b1 );
                         end
                    end
               end
          end
     end // always @ (  posedge clk)
   
   always @ (  scnt_step or  scnt_step_thri)
     begin
        if ( scnt_step == scnt_step_thri ) 
          begin
             scnt_step_tc <= 1'b1;
          end
        else
          begin 
             scnt_step_tc <= 1'b0;
          end
     end // always @ (  scnt_step or  scnt_step_thri)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             scnt_val <= 0;
          end
        else
          begin 
             if ( ( sis_idle == 1'b1 ) | ( sinit_cnt_from_release == 1'b1 ) ) 
               begin
                  scnt_val <= 0;
               end
             else
               begin 
                  if ( sis_attack == 1'b1 ) 
                    begin
                       if ( scnt_step_tc == 1'b1 ) 
                         begin
                            //if ( scnt_val < $unsigned(( 2 ** nbit_data ) - 1 ) ) 
				 if ( scnt_val < $unsigned(cval_max) ) 				 
                              begin
                                 scnt_val <= ( scnt_val + 1'b1 );
                              end
                         end
                    end
                  else
                    begin 
                       if ( ( sis_decay == 1'b1 ) | ( sis_release == 1'b1 ) ) 
                         begin
                            if ( scnt_step_tc == 1'b1 ) 
                              begin
                                 if ( scnt_val > 0 ) 
                                   begin
                                      scnt_val <= ( scnt_val - 1'b1 );
                                   end
                              end
                         end
                    end
               end
          end
     end // always @ (  posedge clk)
   
   always @ (  sis_decay or  scnt_val or  s_level)
     begin
        if ( ( sis_decay == 1'b1 ) & ( scnt_val == s_level ) ) 
          begin
             sdecay_tc <= 1'b1;
          end
        else
          begin 
             sdecay_tc <= 1'b0;
          end
     end // always @ (  sis_decay or  scnt_val or  s_level)
   
   always @ (  sis_release or scnt_val )
     begin
        if ( ( sis_release == 1'b1 ) & ( scnt_val == 0 ) ) 
          begin
             srelease_tc <= 1'b1;
          end
        else
          begin 
             srelease_tc <= 1'b0;
          end
     end // always @ (  sis_release)
   
   always @ (  sis_decay or  sis_release or  scnt_val or  scnt_pwl or  s_level)
     begin
        if ( sis_decay == 1'b1 ) 
          begin
             //if ( scnt_val == ( $unsigned( ( 2 ** nbit_data ) - 1 ) - cval_thr_v[scnt_pwl] ) ) 
		  if ( scnt_val == ( $unsigned(cval_max) - cval_thr_v[scnt_pwl] ) )
               begin
                  scnt_val_tc <= 1'b1;
               end
             else
               begin 
                  scnt_val_tc <= 1'b0;
               end
          end
        else
          begin 
             if ( sis_release == 1'b1 ) 
               begin
                  if ( scnt_val == ( s_level - cval_thr_v[scnt_pwl] ) ) 
                    begin
                       scnt_val_tc <= 1'b1;
                    end
                  else
                    begin 
                       scnt_val_tc <= 1'b0;
                    end
               end
             else
               begin 
                  if ( scnt_val == cval_thr_v[scnt_pwl] ) 
                    begin
                       scnt_val_tc <= 1'b1;
                    end
                  else
                    begin 
                       scnt_val_tc <= 1'b0;
                    end
               end
          end
     end // always @ (  sis_decay or  sis_release or  scnt_val or  scnt_pwl or  s_level)
   
   always @ (  posedge clk or negedge rstn)
     begin
        if ( rstn == 1'b0 ) 
          begin
             scnt_pwl <= 0;
          end
        else
          begin 
             if ( ( ( ( ( sis_idle == 1'b1 ) | ( sis_sustain == 1'b1 ) ) | ( sinit_cnt_from_attack == 1'b1 ) ) | ( sinit_cnt_from_decay == 1'b1 ) ) | ( sinit_cnt_from_release == 1'b1 ) ) 
               begin
                  scnt_pwl <= 0;
               end
             else
               begin 
                  if ( ( ( sis_attack == 1'b1 ) | ( sis_decay == 1'b1 ) ) | ( sis_release == 1'b1 ) ) 
                    begin
                       if ( ( scnt_val_tc == 1'b1 ) & ( scnt_step_tc == 1'b1 ) ) 
                         begin
                            //if ( scnt_pwl < $unsigned( 7 - 1 ) ) 
			    if ( scnt_pwl < $unsigned(cpwl_thr) ) 				    
                              begin
                                 scnt_pwl <= ( scnt_pwl + 1'b1 );
                              end
                            else
                              begin 
                                 scnt_pwl <= 0;
                              end
                         end
                    end
               end
          end
     end // always @ (  posedge clk)
   
   always @ (  scnt_pwl)
     begin
        //if ( scnt_pwl == $unsigned( 7 - 1 ) ) 
	if ( scnt_pwl == $unsigned(cpwl_thr) ) 	     		
          begin
             scnt_pwl_tc <= 1'b1;
          end
        else
          begin 
             scnt_pwl_tc <= 1'b0;
          end
     end // always @ (  scnt_pwl)
   
   assign sattack_tc = ( ( ( sis_attack & scnt_pwl_tc ) & scnt_val_tc ) & scnt_step_tc );
   assign dout = scnt_val;
   assign vout = ( ( ( sis_attack | sis_decay ) | sis_sustain ) | sis_release );
   
endmodule 
