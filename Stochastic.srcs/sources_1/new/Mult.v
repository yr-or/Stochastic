// Multiply two stochastic numbers together

module Mult(
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

    // Generate num1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .prob               (num1),
        .stoch_num          (num1_stoch)
    );

    // Generate num2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .prob               (num2),
        .stoch_num          (num2_stoch)
    );

    // Multiply using AND gate
    assign prod_stoch = num1_stoch & num2_stoch;

    // Convert to binary non-stochastic
    StochToBin STB(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (prod_stoch),
        .bin_number         (prod)
    );

    assign num_mul = prod;

endmodule
