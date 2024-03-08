// Layer 2 for small-scale NN - 8 Neuron8s, hardcoded weights

module Layer2(
    input clk,
    input reset,
    input data_in_stoch [0:7],
    input weights_stoch [0:7][0:7],
    input biases_stoch [0:7],
    output results [0:7],
    output macc_results [0:7]
    );

    wire neurons_out [0:7];
    wire maccs_out [0:7];

    // LFSR seeds for weights
    

    // Generate 8 neurons
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            Neuron8 neur_l2(
                .clk                (clk),
                .reset              (reset),
                .input_data         (data_in_stoch),
                .weights            (weights_stoch[i]),
                .bias               (biases_stoch[i]),
                .result             (neurons_out[i]),
                .macc_result        (maccs_out[i])
            );
        end
    endgenerate

    assign results = neurons_out;
    assign macc_results = maccs_out;

endmodule
