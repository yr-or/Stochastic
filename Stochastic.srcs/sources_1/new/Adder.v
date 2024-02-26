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
        .prob               (8'b10000000), // 0.5
        .rand_num           (rand_num),
        .stoch_num          (stoch_num_sel)
    );
    // LFSR for sng_sel
    LFSR lfsr_sng_sel(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01001110),
        .parallel_out       (rand_num)
    );

    // Multiplexer with two inputs
    always @(posedge clk) begin
        if (stoch_num_sel)
            sum_stoch <= stoch_num2;    // sel = 1
        else
            sum_stoch <= stoch_num1;    // sel = 0
    end

    assign result_stoch = sum_stoch;

endmodule
