// Multiply two stochastic numbers together

module Mult_top (
    input clk,
    input reset,
    input [7:0] num1,
    input [7:0] num2,
    output [3:0] num_mul,
    output done
    );

    wire num1_stoch;
    wire num2_stoch;
    wire prod_stoch;
    wire [7:0] prod;


    // Generate num1, connect to RNG1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd50),
        .prob               (num1),
        .stoch_num          (num1_stoch)
    );

    // Generate num2, connect to RNG2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd238),
        .prob               (num2),
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
        .bin_number         (prod),
        .done               (done)
    );

    assign num_mul = prod;

endmodule
