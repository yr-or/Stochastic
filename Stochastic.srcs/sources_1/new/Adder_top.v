
// Ista. input SNGs and output STB
module Adder_top(
    input wire clk,
    input wire reset,
    output wire result_stoch,
    output wire [7:0] result_bin
    );

    reg [7:0] num1 = 8'b10000000; // 0.5
    reg [7:0] num2 = 8'b01000000; // 0.25
    wire num1_stoch;
    wire num2_stoch;
    wire sum_stoch;
    wire [7:0] sum_bin;


    // Generate num1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b10110111),
        .prob               (num1),
        .stoch_num          (num1_stoch)
    );
    // Generate num2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01011100),
        .prob               (num2),
        .stoch_num          (num2_stoch)
    );

    // Adder
    Adder adder(
        .clk                (clk),
        .reset              (reset),
        .stoch_num1         (num1_stoch),
        .stoch_num2         (num2_stoch),
        .result_stoch       (sum_stoch)
    );

    // STB
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (sum_stoch),
        .bin_number         (sum_bin)
    );

    assign result_bin = sum_bin;
    assign result_stoch = sum_stoch;

endmodule
