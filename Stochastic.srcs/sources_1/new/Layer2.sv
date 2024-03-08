// Layer 2 for small-scale NN - 8 Neuron8s, hardcoded weights and biases

// all stoch inputs and outputs
module Layer2(
    input clk,
    input reset,
    input data_in_stoch [0:7],
    output results [0:7],
    output macc_results [0:7]
    );

    localparam NUM_NEUR = 8;
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
        { 110, 71, 221, 252, 136, 133, 118, 9 },
        { 13, 168, 208, 110, 139, 233, 117, 1 },
        { 215, 5, 108, 197, 251, 115, 133, 6 },
        { 27, 98, 173, 160, 102, 224, 254, 20 },
        { 181, 111, 117, 254, 37, 193, 182, 24 },
        { 69, 8, 252, 69, 47, 7, 238, 25 },
        { 220, 68, 48, 162, 193, 199, 181, 20 },
        { 213, 77, 47, 135, 224, 28, 252, 12 }
    };
    // Binary prob weights vals
    reg [7:0] weights_probs [0:NUM_NEUR-1][0:NUM_INP-1] = '{
        { 156, 150, 123, 163, 93, 200, 72, 21 },
        { 201, 228, 130, 224, 42, 34, 147, 10 },
        { 60, 131, 2, 42, 108, 127, 117, 17 },
        { 94, 76, 226, 17, 29, 79, 110, 7 },
        { 85, 146, 14, 86, 32, 136, 91, 10 },
        { 128, 13, 8, 74, 210, 97, 23, 20 },
        { 25, 153, 138, 42, 199, 52, 136, 14 },
        { 211, 138, 32, 239, 150, 214, 153, 22 }
    };

    // LFSR seeds for biases
    reg [7:0] LFSR_seeds_biases [0:NUM_NEUR-1] = '{ 66, 232, 239, 215, 227, 34, 141, 16 };
    // Binary prob bias vals
    reg [7:0] bias_probs [0:NUM_NEUR-1] = '{ 29, 129, 134, 185, 129, 156, 211, 17 };

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
                    .prob               (weights_probs[i][j]),
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

    // Generate 8 neurons
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
