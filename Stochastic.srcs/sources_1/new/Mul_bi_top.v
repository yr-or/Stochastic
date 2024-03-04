// Toplevel for bipolar multiplier testing
// Take in 

module Mul_bi_top(
    input clk,
    input reset,
    input [7:0] num1,
    input [7:0] num2,
    output [7:0] num_mul
    );

    wire num1_stoch;
    wire num2_stoch;
    wire prod_stoch;
    wire [7:0] prod;

    // Generate num1, connect to RNG1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b10110111),
        .prob               (num1),
        .stoch_num          (num1_stoch)
    );
    // Generate num2, connect to RNG2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01011100),
        .prob               (num2),
        .stoch_num          (num2_stoch)
    );

    // Multiply with XOR gate
    Mult_bipolar mb(
        .stoch_num1         (num1_stoch),
        .stoch_num2         (num2_stoch),
        .stoch_res          (prod_stoch)
    );

    // Estimate probability
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (prod_stoch),
        .bin_number         (prod)
    );    

    assign num_mul = prod;

endmodule
