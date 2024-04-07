
module NN_top(
    input clk,
    input reset,
    input [7:0] input_data_bin [0:7],     // 8 8-bit values
    output [7:0] results_bin [0:4],
    output [7:0] macc_results_bin [0:4],
    output done
    );

    localparam NUM_NEUR_L2 = 8;
    localparam NUM_NEUR_L3 = 5;
    localparam NUM_INP = 8;

    // Stoch wires inputs
    wire inps_stoch [0:NUM_INP-1];

    // Wires for Layer2 -> Layer3
    wire L2_out_stoch [0:NUM_NEUR_L2-1];
    wire L2_macc_out_stoch [0:NUM_NEUR_L2-1];

    // stoch wires output
    wire neur_res_stoch [0:NUM_NEUR_L3-1];
    wire macc_res_stoch [0:NUM_NEUR_L3-1];

    // LFSR seeds for inputs
    reg [7:0] LFSR_seeds_inps [0:NUM_INP-1] = '{ 213, 110, 175, 246, 139, 218, 49, 230 };

    // Generate stoachastic inputs - 8 SNGs
    genvar i;
    generate
        for (i=0; i<NUM_NEUR_L2; i=i+1) begin
            StochNumGen SNG_inps(
                .clk                (clk),
                .reset              (reset),
                .seed               (8'd176),
                .prob               (input_data_bin[i]),
                .stoch_num          (inps_stoch[i])
            );
        end
    endgenerate

    // Connect to Layer2
    Layer2 L2(
        .clk                    (clk),
        .reset                  (reset),
        .data_in_stoch          (inps_stoch),
        .results                (L2_out_stoch),
        .macc_results           (L2_macc_out_stoch)
    );

    // Connect to Layer3
    Layer3 L3(
        .clk                    (clk),
        .reset                  (reset),
        .data_in_stoch          (L2_out_stoch),
        .results                (neur_res_stoch),
        .macc_results           (macc_res_stoch)
    );

    // STBs //
    // Layer2
    wire [0:NUM_NEUR_L2-1] done_stb_res_L2;
    wire [0:NUM_NEUR_L2-1] done_stb_macc_L2;
    wire [7:0] L2_out_bin [0:NUM_NEUR_L2-1];
    wire [7:0] L2_macc_out_bin [0:NUM_NEUR_L2-1];

    // Layer2 outputs STBs
    genvar j;
    generate
        for (j=0; j<NUM_NEUR_L2; j=j+1) begin
            // Convert layer 2 outputs to binary
            StochToBin stb_L2_res(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (L2_out_stoch[j]),
                .bin_number         (L2_out_bin[j]),
                .done               (done_stb_res_L2[j])
            );

            // Convert macc results to binary
            StochToBin stb_L2_macc(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (L2_macc_out_stoch[j]),
                .bin_number         (L2_macc_out_bin[j]),
                .done               (done_stb_macc_L2[j])
            );
        end
    endgenerate

    // Layer3
    wire [0:NUM_NEUR_L3-1] done_stb_res_L3;
    wire [0:NUM_NEUR_L3-1] done_stb_macc_L3;
    wire [7:0] L3_out_bin [0:NUM_NEUR_L3-1];
    wire [7:0] L3_macc_out_bin [0:NUM_NEUR_L3-1];

    // Layer3 outputs STBs
    generate
        for (j=0; j<NUM_NEUR_L3; j=j+1) begin
            // Convert final outputs to binary
            StochToBin stb_L3_res(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (neur_res_stoch[j]),
                .bin_number         (L3_out_bin[j]),
                .done               (done_stb_res_L3[j])
            );

            // Convert macc results to binary
            StochToBin stb_L3_macc(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (macc_res_stoch[j]),
                .bin_number         (L3_macc_out_bin[j]),
                .done               (done_stb_macc_L3[j])
            );
        end
    endgenerate

    assign done = &(done_stb_res_L3);
    assign results_bin = L3_out_bin;
    assign macc_results_bin = L3_macc_out_bin;

endmodule
