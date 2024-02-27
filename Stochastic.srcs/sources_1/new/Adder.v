// Multiplexer with select line = stoch number = 0.5

module Adder(
    input clk,
    input reset,
    input stoch_num1,
    input stoch_num2,
    output result_stoch
    );

    reg sum_stoch;

    // SNG for select line
    wire [7:0] rand_num;
    wire stoch_num_sel;
    StochNumGen sng_sel(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01001110),
        .prob               (8'b10000000), // 0.5
        .stoch_num          (stoch_num_sel)
    );

    // Multiplexer with two inputs
    always @(posedge clk) begin
        if (reset) begin
            // zero everything
            sum_stoch <= 0;
        end else begin
            if (stoch_num_sel)
                sum_stoch <= stoch_num2;    // sel = 1
            else
                sum_stoch <= stoch_num1;    // sel = 0
        end
    end

    assign result_stoch = sum_stoch;

endmodule
