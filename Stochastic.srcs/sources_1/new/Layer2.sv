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
    wire wghts_stoch [0:NUM_NEUR-1][0:NUM_INP-1];
    wire bias_stoch [0:NUM_NEUR-1];

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
        {40, 104, 82, 105, 36, 57, 81, 110},
        {50, 54, 24, 112, 33, 77, 58, 17},
        {25, 4, 83, 100, 1, 43, 44, 12},
        {27, 108, 114, 117, 79, 0, 11, 80},
        {117, 10, 56, 16, 77, 4, 102, 106},
        {25, 1, 73, 33, 9, 19, 89, 86},
        {18, 112, 89, 66, 107, 73, 16, 30},
        {45, 88, 62, 0, 23, 97, 42, 47}
    };

    // LFSR seeds for biases
    reg [7:0] LFSR_seeds_biases [0:NUM_NEUR-1] = '{ 66, 232, 239, 215, 227, 34, 141, 16 };
    // Binary prob bias vals
    reg [7:0] bias_probs [0:NUM_NEUR-1] = '{ 127, 127, 127, 127, 127, 127, 127, 127 };

    // SNGs for weights and biases
    genvar i, j;
    generate
        for (i=0; i<NUM_NEUR; i=i+1) begin
            for (j=0; j<NUM_INP; j=j+1) begin
                // 8x8 SNGs for weights
                StochNumGen SNG_wghts(
                    .clk                (clk),
                    .reset              (reset),
                    .seed               (8'd134),       // Changed to single value
                    .prob               (weights_probs[i][j]),
                    .stoch_num          (wghts_stoch[i][j])
                );
            end
        end
    endgenerate

    generate
        // 8 SNGs for biases
        for (i=0; i<NUM_NEUR; i=i+1) begin
            StochNumGen SNG_bias(
                .clk                (clk),
                .reset              (reset),
                .seed               (8'd132),       // Changed from array to single value
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
