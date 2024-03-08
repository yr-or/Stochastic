// Layer 3 small scale NN - 5 neurons8s, hardcoded weights and biases

// Only stochastic inputs and outputs
module Layer3(
    input clk,
    input reset,
    input data_in_stoch [0:7],
    output results [0:4],
    output macc_results [0:4]
    );

    localparam NUM_NEUR = 5;
    localparam NUM_INP = 8;

    // Wires for SNGs -> Neurons
    wire inps_stoch [0:NUM_INP-1];
    wire wghts_stoch [0:NUM_NEUR-1][0:NUM_INP-1];
    wire bias_stoch [0:NUM_NEUR];

    // Stoch output wires from neurons
    wire neurons_out_stoch [0:NUM_NEUR-1];
    wire maccs_out_stoch [0:NUM_NEUR-1];

    // LFSR seeds for weights
    reg [7:0] LFSR_seeds_wghts [0:NUM_NEUR-1][0:NUM_INP-1] = '{
        { 218, 47, 26, 198, 74, 26, 151, 19 },
        { 180, 83, 140, 237, 253, 206, 39, 16 },
        { 143, 155, 179, 53, 229, 228, 41, 8 },
        { 144, 77, 243, 94, 204, 76, 231, 22 },
        { 2, 39, 251, 183, 22, 168, 15, 20 }
    };
    // Binary probability weights values
    reg [7:0] weights_prob [0:NUM_NEUR-1][0:NUM_INP-1] = '{
        { 114, 57, 252, 135, 6, 61, 183, 17 },
        { 10, 71, 247, 1, 183, 3, 216, 22 },
        { 140, 13, 20, 251, 133, 178, 116, 12 },
        { 61, 80, 98, 27, 132, 40, 72, 19 },
        { 83, 68, 143, 31, 230, 160, 53, 14 }
    };

    // LFSR seeds for biases
    reg [7:0] LFSR_seeds_biases [0:NUM_NEUR-1] = '{ 8, 128, 252, 101, 25 };
    // Binary probability bias values
    reg [7:0] bias_probs [0:NUM_NEUR-1] = '{ 219, 217, 10, 120, 107 };

    // SNGs for weights and biases
    genvar i, j;
    generate
        for (i=0; i<NUM_NEUR; i=i+1) begin
            for (j=0; j<NUM_INP; j=j+1) begin
                // 8x8 SNGs for weights
                StochNumGen SNG_wghts(
                    .clk                (clk),
                    .reset              (reset),
                    .seed               (LFSR_seeds_wghts[i][j]),
                    .prob               (weights_prob[i][j]),
                    .stoch_num          (wghts_stoch[i][j])
                );
            end
            // 8 SNGs for biases
            StochNumGen SNG_bias(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds_biases[i]),
                .prob               (bias_probs[i]),
                .stoch_num          (bias_stoch[i])
            );
        end
    endgenerate

    // Generate 5 neurons
    generate
        for (i=0; i<NUM_NEUR; i=i+1) begin
            Neuron8 neur_l2(
                .clk                (clk),
                .reset              (reset),
                .input_data         (data_in_stoch),
                .weights            (wghts_stoch[i]),
                .bias               (bias_stoch[i]),
                .result             (neurons_out_stoch[i]),
                .macc_result        (maccs_out_stoch[i])
            );
        end
    endgenerate

    assign results = neurons_out_stoch;
    assign macc_results = maccs_out_stoch;

endmodule
