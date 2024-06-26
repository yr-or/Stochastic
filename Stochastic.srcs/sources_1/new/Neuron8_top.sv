
// Takes std binary values in
module Neuron8_top(
    input clk,
    input reset,
    input [7:0] input_data_bin [0:7],
    input [7:0] weights_bin [0:7],
    input [7:0] bias_bin,
    output [7:0] result_bin,
    output [7:0] macc_result_bin,    // debug wire
    output [7:0] bias_out_bin,
    output result_stoch,
    output done
    );

    // Stochastic inputs
    wire inps_stoch [0:7];
    wire wghts_stoch [0:7];
    wire bias_stoch;

    // Stochastic outputs
    wire neur_result_stoch;
    wire macc_result_stoch;
    wire bias_out_stoch;

    // Generate stoachastic inputs, weights
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            StochNumGen SNG_inps(
                .clk                (clk),
                .reset              (reset),
                .seed               (8'd134),               // Using set seeds as better outputs.
                .prob               (input_data_bin[i]),
                .stoch_num          (inps_stoch[i])
            );

            StochNumGen SNG_wghts(
                .clk                (clk),
                .reset              (reset),
                .seed               (8'd104),
                .prob               (weights_bin[i]),
                .stoch_num          (wghts_stoch[i])
            );
        end
    endgenerate
    // Generate bias stoch num
    StochNumGen SNG_bias(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd132),       // Changed from 12 to 132, fixed issue of outputs too high
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
        .macc_result        (macc_result_stoch),
        .bias_out           (bias_out_stoch)
    );

    // STB output
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (neur_result_stoch),
        .bin_number         (result_bin),
        .done               (done)
    );

    // STB for macc result
    StochToBin stb_macc(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (macc_result_stoch),
        .bin_number         (macc_result_bin)
    );

    // STB bias result
    StochToBin stb_bias(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (bias_out_stoch),
        .bin_number         (bias_out_bin)
    );

    assign result_stoch = neur_result_stoch;

endmodule
