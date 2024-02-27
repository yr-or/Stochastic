// Multiply two stochastic numbers together

module Mult_top (
    input clk,
    input reset,
    input [7:0] num1,
    input [7:0] num2,
    output [3:0] num_mul
    );

    wire num1_stoch;
    wire num2_stoch;
    wire prod_stoch;
    wire [3:0] prod;
    wire [7:0] rand_num1;
    wire [7:0] rand_num2;

    // Instantiate RNGs
    LFSR lfsr1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b10110111),
        .parallel_out       (rand_num1)
    );

    LFSR lfsr2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01011100),
        .parallel_out       (rand_num2)
    );

    // Generate num1, connect to RNG1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .prob               (num1),
        .rand_num           (rand_num1),
        .stoch_num          (num1_stoch)
    );

    // Generate num2, connect to RNG2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .prob               (num2),
        .rand_num           (rand_num2),
        .stoch_num          (num2_stoch)
    );

    // Multiply using AND gate
    Mult mult(
        .stoch_num1         (num1_stoch),
        .stoch_num2         (num2_stoch),
        .stoch_res          (prod_stoch)
    );

    // Convert to binary non-stochastic
    StochToBin STB (
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (prod_stoch),
        .bin_number         (prod)
    );

    assign num_mul = prod;

endmodule
