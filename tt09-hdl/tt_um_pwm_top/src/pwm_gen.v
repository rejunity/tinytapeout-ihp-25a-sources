module pwm_gen(
    input clk,
    input rst_n,
    input ena,
    input increase_duty,
    input decrease_duty,
    input [5:0] divisor,
    output pwm_out0,
    output pwm_out1,
    output pwm_out2,
    output pwm_out3,
    output pwm_out4,
    output pwm_out5,
    output pwm_out6,
    output pwm_out7
    );
    reg [27:0] counter_debounce = 0;  // Contador de rebote
    reg [3:0] counter_PWM = 0;        // Contador para generar la señal PWM
    reg [3:0] DUTY_CYCLE = 5;         // Ciclo de trabajo inicial (50%)
    wire duty_inc, duty_dec;           // Señales para aumento y disminución de ciclo
    wire slow_clk_enable;              // Reloj lento para debounce
    wire tmp1, tmp2, tmp3, tmp4;
    wire clk_out;

    wire _unused = &{ena, 1'b0};

    div_freq DIV_FREQ (clk, divisor, rst_n, clk_out);
    
    // Generación de la señal de habilitación de reloj lento (debounce)
    always @(posedge clk_out or posedge rst_n) begin
        if (rst_n)
            counter_debounce <= 0;
        else if (counter_debounce >= 1)
            counter_debounce <= 0;
        else
            counter_debounce <= counter_debounce + 1;
    end
    assign slow_clk_enable = (counter_debounce == 1);  // Activa reloj lento
    
    // Instanciación de los flip-flops para des-rebote del botón de aumento
    DFF_PWM PWM_DFF1(clk_out, slow_clk_enable, increase_duty, tmp1);
    DFF_PWM PWM_DFF2(clk_out, slow_clk_enable, tmp1, tmp2);
    assign duty_inc = tmp1 & (~tmp2) & slow_clk_enable;

    // Instanciación de los flip-flops para des-rebote del botón de disminución
    DFF_PWM PWM_DFF3(clk_out, slow_clk_enable, decrease_duty, tmp3);
    DFF_PWM PWM_DFF4(clk_out, slow_clk_enable, tmp3, tmp4);
    assign duty_dec = tmp3 & (~tmp4) & slow_clk_enable;
    
    // Ajuste del ciclo de trabajo
    always @(posedge clk_out or posedge rst_n) begin
        if (rst_n)
            DUTY_CYCLE <= 5;
        else begin
            if (duty_inc && DUTY_CYCLE < 10)
                DUTY_CYCLE <= DUTY_CYCLE + 1;  // Aumentar ciclo
            else if (duty_dec && DUTY_CYCLE > 0)
                DUTY_CYCLE <= DUTY_CYCLE - 1;  // Disminuir ciclo
        end
    end
    
    // Generación de la señal PWM de 10MHz
    always @(posedge clk_out or posedge rst_n) begin
        if (rst_n)
            counter_PWM <= 0;
        else if (counter_PWM >= 9)
            counter_PWM <= 0;
        else
            counter_PWM <= counter_PWM + 1;
    end
    // PWM en alto mientras el contador esté por debajo del ciclo de trabajo
    assign pwm_out0 = (counter_PWM < DUTY_CYCLE);
    assign pwm_out1 = pwm_out0;
    assign pwm_out2 = pwm_out0;
    assign pwm_out3 = pwm_out0;
    assign pwm_out4 = pwm_out0;
    assign pwm_out5 = pwm_out0;
    assign pwm_out6 = pwm_out0;
    assign pwm_out7 = pwm_out0;
endmodule
