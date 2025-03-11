`default_nettype none

module tt_um_pwm_top(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // All output pins must be assigned. If not used, assign to 0.
    assign uio_out[7:0] = 0;        
    assign uio_oe[7:0]  = 0;
    
    //List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in[7:0], uio_out[7:0], uio_oe[7:0], 1'b0};

    pwm_gen PWM_Generador(
        .increase_duty (ui_in[0]),
        .decrease_duty (ui_in[1]),
        .divisor       (ui_in[7:2]),
        .pwm_out0      (uo_out[0]),
        .pwm_out1      (uo_out[1]),
        .pwm_out2      (uo_out[2]),
        .pwm_out3      (uo_out[3]),
        .pwm_out4      (uo_out[4]),
        .pwm_out5      (uo_out[5]),
        .pwm_out6      (uo_out[6]),
        .pwm_out7      (uo_out[7]),
        .clk           (clk),
        .rst_n         (rst_n),
        .ena           (ena)
    );
    
endmodule
