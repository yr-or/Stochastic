// Layer 3 small scale NN - 5 neurons8s, 

module Layer3(
    input clk,
    input reset,
    input data_in_stoch [0:7],
    input weights_stoch [0:4][0:7],
    input biases_stoch [0:4],
    output results [0:4],
    output macc_results [0:4]
    );

    wire neurons_out [0:4];
    wire maccs_out [0:4];

    // Generate 8 neurons
    genvar i;
    generate
        for (i=0; i<5; i=i+1) begin
            Neuron8 neur_l3(
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
