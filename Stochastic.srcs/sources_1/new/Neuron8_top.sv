
// Takes std binary values in
module Neuron8_top(
    input clk,
    input reset,
    input [7:0] input_data_bin [0:7],
    input [7:0] weights_bin [0:7],
    input [7:0] bias_bin,
    output [7:0] result_bin,
    output [7:0] macc_result_bin,    // debug wire
    output result_stoch
    );

    // Stochastic inputs
    wire inps_stoch [0:7];
    wire wghts_stoch [0:7];
    wire bias_stoch;

    // Stochastic outputs
    wire neur_result_stoch;

    // LFSR seeds - 1 for each number generated
    reg [7:0] LFSR_seeds [0:15] = '{225, 254, 225, 243, 44, 9, 163, 124, 153, 223, 58, 255, 18, 202, 147, 179};

    // Generate stoachastic inputs, weights
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            StochNumGen SNG_inps(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds[i]),
                .prob               (input_data_bin[i]),
                .stoch_num          (inps_stoch[i])
            );

            StochNumGen SNG_wghts(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds[i+8]),
                .prob               (weights_bin[i]),
                .stoch_num          (wghts_stoch[i])
            );
        end
    endgenerate
    // Generate bias stoch num
    StochNumGen SNG_bias(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd12),
        .prob               (bias_bin),
        .stoch_num          (bias_stoch)
    );

    // Neuron
    Neuron8 neur(
        .clk                (clk),
        .reset              (reset),
        .input_data         (inps_stoch),
        .weights            (wghts_stoch),
        .bias               (bias_stoch),
        .result             (neur_result_stoch),
        .macc_result        (macc_result)
    );

    // STB output
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (neur_result_stoch),
        .bin_number         (result_bin)
    );

    // STB for macc result
    StochToBin stb_macc(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (macc_result),
        .bin_number         (macc_result_bin)
    );

    assign result_stoch = neur_result_stoch;

endmodule
