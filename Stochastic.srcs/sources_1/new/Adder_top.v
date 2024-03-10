
// Ista. input SNGs and output STB
module Adder_top(
    input clk,
    input reset,
    input [7:0] num1_bin,
    input [7:0] num2_bin,
    output result_stoch,
    output [7:0] result_bin,
    output done
    );

    // Wires
    wire num1_stoch;
    wire num2_stoch;
    wire sum_stoch;
    wire [7:0] sum_bin;
    wire done_stb;

    // Generate num1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd100),
        .prob               (num1_bin),
        .stoch_num          (num1_stoch)
    );
    // Generate num2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd81),
        .prob               (num2_bin),
        .stoch_num          (num2_stoch)
    );

    // Adder
    Adder adder(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd24),
        .stoch_num1         (num1_stoch),
        .stoch_num2         (num2_stoch),
        .result_stoch       (sum_stoch)
    );

    // STB
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (sum_stoch),
        .bin_number         (sum_bin),
        .done               (done_stb)
    );

    assign result_bin = sum_bin;
    assign result_stoch = sum_stoch;
    assign done = done_stb;

endmodule
