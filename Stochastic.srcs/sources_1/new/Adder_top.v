`default_nettype none

// Incl. input SNGs and output STB
module Adder_top(
    input wire clk,
    input wire reset,
    output wire result_stoch,
    output wire [7:0] result_bin
    );

    wire [7:0] rand_num1;
    wire [7:0] rand_num2;
    reg [7:0] num1 = 8'b10000000; // 0.5
    reg [7:0] num2 = 8'b01000000; // 0.25
    wire num1_stoch;
    wire num2_stoch;
    wire sum_stoch;
    wire [7:0] sum_bin;

    // Input stoch numbers
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
