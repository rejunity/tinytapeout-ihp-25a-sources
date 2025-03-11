// Esteban Oman Mendoza, Fall 2020 Utah Valley University
`ifndef TT_UM_ESTEBAN_OMAN_MENDOZA_MAZE_2024_TOP_H
`define TT_UM_ESTEBAN_OMAN_MENDOZA_MAZE_2024_TOP_H 
module tt_um_Esteban_Oman_Mendoza_maze_2024_top(  
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output) 
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


    wire rst; // reset signal on low
    wire [2:0] user_input; // 3 bit user input user_input[0] = Move forward on low user_input[1] = LSB for direction select, user_input[2]  = MSB for direction select.
    reg [7:0] seg0, seg1, seg2, seg3, seg4, seg5; //mapped to uio[0]: "state LSB"  uio[1]: "state MSB"  uio[2]: "Direction LSB"  uio[3]: "Direction MSB"  uio[4]: "Top half of segment used for wall representation. 0-0, 1-1,...,5-5.
    reg [7:0] state, next_state; // represent room numbers
    reg [3:0] room_walls; // represent the room as seen from above (birds eye view)
    reg [3:0] shifted_room_walls; // turns the room walls to represent the direction choosen. 
    reg [40:0] counter; // used to divide the clock
    reg Hertz_4;  // FIXME not 4 Hz clock to capture user input
    reg Hertz_60; // FIXME not 60 Hz clock to multiplex the displays from 5 bits
    reg blink_toggle; // toggle all displays when in win state
    reg [2:0] display_sel; // counter to cycle between output states
    reg [4:0] seg_enable; // drives output pin low to turn on pnp transistor and allow current to flow into the "on" displays for that current display state (low = on)
    reg [7:0] segments; // 7 segment outputs, common to all 5 segment displays, must tie pins together1,2,4,5,6,7,9,10 

    assign uio_oe = 8'b11111111; // all uio are set as outputs
    assign uo_out[7:0] = segments; // map active wall segemens to output
    assign uio_out[7:0] = {3'b111, seg_enable}; // map segments to output pins, low = on
    assign user_input = ui_in[2:0]; // user input
    assign rst = rst_n; // map reset


    
// parameters to make code more readable
    parameter
        A = 4'b1000,
        B = 4'b0100,
        C = 4'b0010,
        D = 4'b0001,
        move_north	     = 3'b000,  
        move_east	        = 3'b010,		
        move_south 	     = 3'b100,
        move_west	        = 3'b110,
        look_north	     = 3'b001,
        look_east	        = 3'b011,
        look_south	     = 3'b101,
        look_west	        = 3'b111,
        state_0 	        = 0,
        state_1 	        = 1,
        state_2 	        = 2,
        state_3 	        = 3,
        state_4 	        = 4,
        state_5 	        = 5,
        state_6 	        = 6,
        state_7 	        = 7,
        state_8 	        = 8,
        state_9 	        = 9,
        state_10 	        = 10,
        state_11 	        = 11,
        state_12 	        = 12,
        state_13 	        = 13,
        state_14 	        = 14,
        state_15 	        = 15,
        state_16 	        = 16,
        state_17 	        = 17,
        state_18 	        = 18,
        state_19 	        = 19,
        state_20 	        = 20,
        state_21 	        = 21,
        state_22 	        = 22,
        state_23 	        = 23,
        state_24 	        = 24,
        state_25 	        = 25,
        state_26 	        = 26,
        state_27 	        = 27,
        state_28 	        = 28,
        state_29 	        = 29,
        state_30 	        = 30,
        state_31 	        = 31,
        state_32 	        = 32,
        state_33 	        = 33,
        state_34 	        = 34,
        state_35 	        = 35,
        state_36 	        = 36,
        state_37 	        = 37,
        state_38 	        = 38,
        state_39 	        = 39,
        state_40	        = 40,
        u_right             = A|C|D,
        //  *****
        //  *   
        //  *****
        //
        u_down		        = A|B|D,
        //
        //  *****
        //  *   *
        //  *   *
        //
        u_left              = A|B|C,
        //
        //  *****
        //      *
        //  *****
        //
        u_up 		        = B|C|D,
        //
        //  *   *
        //  *   *
        //  *****
        //
        L_right		        = D|C,
        //
        //  *
        //  *
        //  *****
        //
        L_right_mirrored	= A|D,
        //
        //  *****
        //  *
        //  *
        //
        L_left_mirrored	    = A|B,
        //
        //  *****
        //      *
        //      *
        //
        L_left 		        = B|C,
        //
        //      *
        //      *
        //  *****
        //    
        left 			    = D, 
        //
        //  *
        //  *
        //  *
        //
        top 			    = A,
        //
        //  *****
        //  
        //  
        //
        right			    = B,
        //
        //      *
        //      *
        //      *
        //
        bottom		        = C,
        //
        //  
        //  
        //  *****
        //
        left_right		    = D|B,
        //
        //  *   *
        //  *   *
        //  *   *
        //
        top_bottom		    = A|C,
        //
        //  *****
        //  
        //  *****
        //
        blank_4 		        = 4'b1111,
        //
        //  
        //  
        //  
        //
        blank_8 		        = 11;
        //
        //  
        //  
        //  
        //

// output of room walls mapped to seven segment display
  function [7:0] wall_decoder;
        input [3:0] map;
            case (map)
                u_down:
                    wall_decoder = 8'b11011100;
                    //
                    //  *****
                    //  *   *
                    //  *   *
                    //
                u_up:
                    wall_decoder = 8'b10011101;
                    //
                    //  *   *
                    //  *   *
                    //  *****
                    //
                L_right:
                    wall_decoder = 8'b10011111; 
                    //
                    //  *
                    //  *
                    //  *****
                    //
                L_left:
                    wall_decoder = 8'b10111101;
                    //
                    //      *
                    //      *
                    //  *****
                    //
                L_right_mirrored:
                    wall_decoder = 8'b11011110;
                    //
                    //  *****
                    //  *
                    //  *
                    //
                L_left_mirrored:
                    wall_decoder = 8'b11111100;
                    //
                    //  *****
                    //      *
                    //      *
                    //
                left:
                    wall_decoder = 8'b11011111;
                    //
                    //  *
                    //  *
                    //  *
                    //
                top:
                    wall_decoder = 8'b11111110;
                    //
                    //  *****
                    //  
                    //  
                    //
                right:
                    wall_decoder = 8'b11111101;
                    //
                    //      *
                    //      *
                    //      *
                    //
                bottom:
                    wall_decoder = 8'b10111111;
                    //
                    //  
                    //  
                    //  *****
                    //
                left_right:
                    wall_decoder = 8'b11011101;
                    //
                    //  *   *
                    //  *   *
                    //  *   *
                    //
                top_bottom:
                    wall_decoder = 8'b10111110;
                    //
                    //  *****
                    //  
                    //  *****
                    //
                u_left:
                    wall_decoder = 8'b10111100;
                    //
                    //  *****
                    //      *
                    //  *****
                    //
                u_right:
                    wall_decoder = 8'b10011110;
                    //
                    //  *****
                    //  *   
                    //  *****
                    //
                blank_4:
                    wall_decoder = 8'b11111111;
                    //
                    //  
                    //  
                    //  
                    //
            
                default:
                    wall_decoder = 8'b11111111; // all off
            endcase
        endfunction
// seven segment decoder for room and direction outputs
  function [7:0] segment_decoder;
    input [7:0] shape_code;
            begin
                case (shape_code)
                    8'd0:  segment_decoder = 8'b11000000; // 0
                    8'd1:  segment_decoder = 8'b11111001; // 1
                    8'd2:  segment_decoder = 8'b10100100; // 2
                    8'd3:  segment_decoder = 8'b10110000; // 3
                    8'd4:  segment_decoder = 8'b10011001; // 4
                    8'd5:  segment_decoder = 8'b10010010; // 5
                    8'd6:  segment_decoder = 8'b10000010; // 6
                    8'd7:  segment_decoder = 8'b11111000; // 7
                    8'd8:  segment_decoder = 8'b10000000; // 8
                    8'd9:  segment_decoder = 8'b10010000; // 9
                    8'd10: segment_decoder = 8'b10000000; // all on
                  blank_8: segment_decoder = 8'b11111111; // all off
                    default: segment_decoder = 8'b11111111; // all off
                endcase
            end
        endfunction


    always @(*)   //generate next state with combinational logic
        case (state)
        state_0:
            case(user_input)
                move_east:	next_state = state_1;
                default: 		next_state = state_0;
            endcase
        state_1:
            case(user_input)
                move_north:	next_state = state_10;
                move_east: 	next_state = state_2;
                move_west:	next_state = state_0;
                default:		next_state = state_1;
            endcase
        state_2:
            case(user_input)
                move_north:	next_state = state_9;
                move_west:	next_state = state_1;
                default:		next_state = state_2;
            endcase
        state_3:
            case(user_input)
                move_north:	next_state = state_8;
                default:		next_state = state_3;
            endcase
        state_4:
            case(user_input)
                move_north:	next_state = state_7;
                move_east:	next_state = state_5;
                default:		next_state = state_4;
            endcase
        state_5:
            case(user_input)
            move_north: 	next_state = state_6;
            move_west:		next_state = state_4;
            default: 		next_state = state_5;
            endcase
        state_6:
            case(user_input)
            move_north:		next_state = state_17;
            move_south:		next_state = state_5;
            default:		next_state = state_6;
            endcase
        state_7:
            case(user_input)
            move_south:		next_state = state_4;
            move_west:		next_state = state_8;
            default:		next_state = state_7;
            endcase
        state_8:
            case(user_input)
            move_north:		next_state = state_15;
            move_east:		next_state = state_7;
            move_south:		next_state = state_3;
            move_west:		next_state = state_9;
            default:		next_state = state_8;
            endcase
        state_9:
            case(user_input)
            move_east:		next_state = state_8;
            move_south:		next_state = state_2;
            default:		next_state = state_9;
            endcase
        state_10:
            case(user_input)
            move_north:		next_state = state_13;
            move_south: 	next_state = state_1;
            move_west:		next_state = state_11;
            default:		next_state = state_10;
            endcase
        state_11:
            case(user_input)
            move_north: 	next_state = state_12;
            move_east:		next_state = state_10;
            default: 		next_state = state_11;
            endcase
        state_12:
            case(user_input)
            move_east:		next_state = state_13;
            move_south: 	next_state = state_11;
            default:		next_state = state_12;
            endcase	
        state_13:
            case(user_input)
            move_east:		next_state = state_14;
            move_south: 	next_state = state_10;
            move_west:		next_state = state_12;
            default: 		next_state = state_13;
            endcase
        state_14:
            case(user_input)
            move_north: 	next_state = state_21;
            move_west:		next_state = state_13;
            default:		next_state = state_14;
            endcase
        state_15:
            case(user_input)
            move_north:		next_state = state_20;
            move_south: 	next_state = state_8;
            default: 		next_state = state_15;
            endcase
        state_16:
            case(user_input)
            move_north: 	next_state = state_19;
            move_south: 	next_state = state_17;
            default:		next_state = state_16;
            endcase
        state_17:
            case(user_input)
            move_south: 	next_state = state_6;
            move_west:		next_state = state_16;
            default:		next_state = state_17;
            endcase
            state_18:
            case(user_input)
            move_north:		next_state = state_29;
            move_west:		next_state = state_19;
            default:		next_state = state_18;
            endcase
        state_19:
            case(user_input)
            move_east:		next_state = state_18;
            move_south:		next_state = state_16;
            default:		next_state = state_19;
            endcase				
        state_20:
            case(user_input)
            move_north:		next_state = state_27;
            move_south:		next_state = state_15;
            default:		next_state = state_20;
            endcase
        state_21:
            case(user_input)
            move_south:		next_state = state_14;
            move_west:		next_state = state_22;
            default:		next_state = state_21;
            endcase
        state_22:
            case(user_input)
            move_east:		next_state = state_21;
            move_west:		next_state = state_23;
            default:		next_state = state_22;
            endcase
        state_23:
            case(user_input)
            move_north:		next_state = state_24;
            move_east:		next_state = state_22;
            default:		next_state = state_23;
            endcase
        state_24:
            case(user_input)
            move_north:		next_state = state_35;
            move_east:		next_state = state_25;
            move_south:		next_state = state_23;
            default:		next_state = state_24;
            endcase
        state_25:
            case(user_input)
            move_north:		next_state = state_34;
            move_west:		next_state = state_24;
            default:		next_state = state_25;
            endcase
        state_26:
            case(user_input)
            move_north:		next_state = state_33;
            default:		next_state = state_26;
            endcase
        state_27:
            case(user_input)
            move_east:		next_state = state_28;
            move_south:		next_state = state_20;
            default:		next_state = state_27;
            endcase
        state_28:
            case(user_input)
            move_west:		next_state = state_27;
            default:		next_state = state_28;
            endcase
        state_29:
            case(user_input)
            move_north:		next_state = state_30;
            move_south:		next_state = state_18;
            default:		next_state = state_29;
            endcase
        state_30:
            case(user_input)
            move_south:		next_state = state_29;
            move_west:		next_state = state_31;
            default:		next_state = state_30;
            endcase
        state_31:
            case(user_input)
            move_north:		next_state = state_36;
            move_east:		next_state = state_36;
            move_south:		next_state = state_36;
            move_west:		next_state = state_36;
            default:		next_state = state_31;
            endcase
        state_32:
            case(user_input)
            move_west:		next_state = state_33;
            default:		next_state = state_32;
            endcase
        state_33:
            case(user_input)
            move_east:		next_state = state_32;
            move_south:		next_state = state_26;
            move_west:		next_state = state_34;
            default:		next_state = state_33;
            endcase
        state_34:
            case(user_input)
            move_east:		next_state = state_33;
            move_south:		next_state = state_25;
            move_west:		next_state = state_35;
            default:		next_state = state_34;
            endcase
        state_35:
            case(user_input)
            move_east:		next_state = state_34;
            move_south:		next_state = state_24;
            default:		next_state = state_35;
            endcase
        state_36:
            case(user_input)
            default:	next_state = 36;  // Stay in win state until reset.
            endcase
        endcase
		  
		  

    always @(*) 
        begin
			if(!rst)
				begin
					Hertz_4 = 0; 
					blink_toggle = 0;
                                  	Hertz_60 = 0;
				end
			else 
				begin
					Hertz_4 = counter[23]; // ~4 Hertz
                                        Hertz_60 = counter[15]; //~ 60 Hertz
					blink_toggle = counter [24]; // ~ 7 Hertz
				end
        end
		  
		  always @(posedge Hertz_4 or negedge rst) 
        begin
            if (!rst)
                begin
                    state <= state_0;
                end
            else 
                begin
                    state <= next_state;
                end
        end

    // update counter on the system clock
    always @(posedge clk or negedge rst) 
        begin
            if (!rst)
                begin
                    counter <= 0;
                end
            else 
                begin
                    counter <= counter + 1;
                end
        end


    always @(*) // segment outputs right to left
        begin
            if(!rst)
                begin
                    seg0 = segment_decoder (blank_8);
                    seg1 = segment_decoder (blank_8);
                    seg2 = segment_decoder (blank_8);               
                    seg3 = segment_decoder (blank_8);
                    seg4 = segment_decoder (blank_8);
                end
            else if (state == state_36) 
                begin
                    if (blink_toggle) 
                        begin
                            seg0 = segment_decoder(10); // All segments on
                            seg1 = segment_decoder(10);
                            seg2 = segment_decoder(10);
                            seg3 = segment_decoder(10);
                            seg4 = segment_decoder(10);
                        end 
                    else 
                        begin
                            seg0 = segment_decoder(blank_8); // all segments off
                            seg1 = segment_decoder(blank_8);
                            seg2 = segment_decoder(blank_8);
                            seg3 = segment_decoder(blank_8);
                            seg4 = segment_decoder(blank_8);
                        end
                end
            else
                begin
                    seg0 = segment_decoder (state%10); // state ones place
                    seg1 = segment_decoder (state/10); // state tens place
                    seg2 = segment_decoder({7'b0000000, user_input[1:1]}); // dir LSB
                    seg3 = segment_decoder({7'b0000000, user_input[2:2]}); // dir MSB
                    seg4 = wall_decoder(shifted_room_walls); // birds eye view of walls that surround you
                end
        end
  always @(posedge Hertz_60 or negedge rst) //FIXME not actually 60Hz
            if(!rst) display_sel <= 0;
            else display_sel <= display_sel + 1;

    always @(*) begin // select which segment to turn on depending on the counter (display_sel) 
        seg_enable = 5'b11111;

        case(display_sel)
        3'd0:
        begin
            segments = seg4;
            seg_enable = 5'b11110;
        end
        3'd1:
        begin
            segments = seg3;
            seg_enable = 5'b11101;
        end
        3'd2:
        begin
            segments = seg2;
            seg_enable = 5'b11011;
        end
        3'd3:
        begin
            segments = seg1;
            seg_enable = 5'b10111;
        end
        3'd4:
        begin
            segments = seg0;
            seg_enable = 5'b01111;
        end
        default begin
          segments = 8'b11111111;
          seg_enable = 5'b11111;
        end
        endcase
        end




    always @(*) // (Wall Generator) room walls layout when facing north
        case (state)
            state_0:
            room_walls = u_right;        
            state_1:
            room_walls = bottom; 
            state_2:
            room_walls = L_left;         
            state_3:
            room_walls = u_up;
            state_4:
            room_walls = L_right;
            state_5:
            room_walls = L_left;
            state_6:
            room_walls = left_right;         
            state_7:
            room_walls = L_left_mirrored;
            state_8:
            room_walls = blank_4;
            state_9:
            room_walls = L_right_mirrored;
            state_10:
            room_walls = right;        
            state_11:
            room_walls = L_right;
            state_12:
            room_walls = L_right_mirrored;
            state_13:
            room_walls = top;
            state_14:
            room_walls = L_left;
            state_15:
            room_walls = left_right;
            state_16:
            room_walls = L_right;        
            state_17:
            room_walls = L_left_mirrored;
            state_18:
            room_walls = L_left;
            state_19:
            room_walls = L_right_mirrored;
            state_20:
            room_walls = left_right;
            state_21:
            room_walls = L_left_mirrored;
            state_22:
            room_walls = top_bottom;
            state_23:
            room_walls = L_right;
            state_24:
            room_walls = left;
            state_25:
            room_walls = L_left;
            state_26:
            room_walls = u_up;
            state_27:
            room_walls = L_right_mirrored;
            state_28:
            room_walls = u_left;
            state_29:
            room_walls = left_right;
            state_30:
            room_walls = L_left_mirrored;
            state_31:
            room_walls = L_right;
            state_32:
            room_walls = u_left;          
            state_33:
            room_walls = top;           
            state_34:
            room_walls = top;
            state_35:
            room_walls = L_right_mirrored; 
            default: 
            room_walls = blank_4;
        endcase               

     

    always @(*) // (Wall shifter) update wall rotation
        case (user_input)
            look_north: shifted_room_walls = room_walls >> 0;
            look_west:  shifted_room_walls = room_walls >> 1 | room_walls << 3;
            look_south: shifted_room_walls = room_walls >> 2 | room_walls << 2;
            look_east:  shifted_room_walls = room_walls >> 3 | room_walls << 1;
            default:    shifted_room_walls = 4'bxxxx;
        endcase


endmodule

`endif

