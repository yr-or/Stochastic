
module NN_top(
    input clk,
    input reset,
    input [7:0] input_data_bin [0:7],     // 8 8-bit values
    input [7:0] weights_bin [0:7][0:7],   // binary prob of weights for each neur
    input [7:0] biases_bin [0:7],
    output results_bin [0:7],
    output macc_results_bin [0:7],
    output done
    );

    localparam NUM_NEUR_L2 = 8;
    localparam NUM_NEUR_L3 = 5;
    localparam NUM_INP = 8;

    // Stoch wires inputs
    wire inps_stoch [0:NUM_INP-1];
    wire wghts_stoch [0:NUM_NEUR_L2-1][0:NUM_INP-1];
    wire bias_stoch [0:NUM_NEUR_L2-1];

    // stoch wires output
    wire neur_res_stoch [0:NUM_NEUR_L2-1];
    wire macc_res_stoch [0:NUM_NEUR_L2-1];

    // LFSR seeds for inputs
    reg [7:0] LFSR_seeds_inps [0:NUM_INP-1] = '{ 213, 110, 175, 246, 139, 218, 49, 230 };

    // LFSR seeds for weights
    reg [7:0] LFSR_seeds_wghts [0:NUM_NEUR_L2-1][0:NUM_INP-1] = '{
        { 110, 71, 221, 252, 136, 133, 118, 9 },
        { 13, 168, 208, 110, 139, 233, 117, 1 },
        { 215, 5, 108, 197, 251, 115, 133, 6 },
        { 27, 98, 173, 160, 102, 224, 254, 20 },
        { 181, 111, 117, 254, 37, 193, 182, 24 },
        { 69, 8, 252, 69, 47, 7, 238, 25 },
        { 220, 68, 48, 162, 193, 199, 181, 20 },
        { 213, 77, 47, 135, 224, 28, 252, 12 }
    };

    // LFSR seeds for biases
    reg [7:0] LFSR_seeds_biases [0:NUM_NEUR_L2-1] = '{ 66, 232, 239, 215, 227, 34, 141, 16 };

    // Generate stoachastic inputs - 8x8 SNGs
    genvar i, j;
    generate
        for (i=0; i<NUM_NEUR_L2; i=i+1) begin
            // generate 8 input streams
            StochNumGen SNG_inps(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds_inps[i]),
                .prob               (input_data_bin[i]),
                .stoch_num          (inps_stoch[i])
            );
            // generate weights
            for (j=0; j<NUM_INP; j=j+1) begin
                StochNumGen SNG_wghts(
                    .clk                (clk),
                    .reset              (reset),
                    .seed               (LFSR_seeds_wghts[i][j]),
                    .prob               (weights_bin[i][j]),
                    .stoch_num          (wghts_stoch[i][j])
                );
            end
            // generate biases
            StochNumGen SNG_bias(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds_biases[i]),
                .prob               (biases_bin[i]),
                .stoch_num          (bias_stoch[i])
            );
        end
    endgenerate

    // Connect to Layer2
    Layer2 L2(
        .clk                    (clk),
        .reset                  (reset),
        .data_in_stoch          (inps_stoch),
        .weights_stoch          (wghts_stoch),
        .biases_stoch           (bias_stoch),
        .results                (neur_res_stoch),
        .macc_results           (macc_res_stoch)
    );


    // Convert to binary with STBs
    wire [0:NUM_NEUR_L2-1] done_stb_res;
    wire [0:NUM_NEUR_L2-1] done_stb_macc;

    genvar k;
    generate
        for (k=0; k<NUM_NEUR_L2; k=k+1) begin
            // Convert final outputs to binary
            StochToBin stb_res(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (neur_res_stoch[k]),
                .bin_number         (results_bin[k]),
                .done               (done_stb_res[k])
            );

            // Convert macc results to binary
            StochToBin stb_macc(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (macc_res_stoch[k]),
                .bin_number         (macc_results_bin[k]),
                .done               (done_stb_macc[k])
            );
        end
    endgenerate

    assign done = &(done_stb_res);
endmodule
