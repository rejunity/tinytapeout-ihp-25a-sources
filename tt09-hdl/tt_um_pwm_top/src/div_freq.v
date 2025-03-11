module div_freq(
    input wire clk,
    input [5:0] div_bin_in,
    input wire reset,        // Señal de reset
    output reg clk_out
);
    reg [5:0] counter;          // Contador de 6 bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;    // Reinicia el contador a 0
            clk_out <= 0;    // Reinicia la salida a 0
        end
        else if (counter >= ((div_bin_in - 1)/2)) begin
            // Cuando el contador alcanza el valor de división
            counter <= 0;    // Reinicia el contador
            clk_out <= ~clk_out; // Invierte la salida para crear una nueva frecuencia
        end
        else begin
            counter <= counter + 1; // Incrementa el contador
        end
    end
endmodule