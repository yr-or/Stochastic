// Used to contain SNGs, and STB for MulAcc8_bi module

module MulAcc8_bi_top(
    input clk,
    input reset,
    input [7:0] inps_num_bin [0:7],
    input [7:0] wghts_num_bin [0:7],
    output stoch_mac_res,
    output [7:0] mac_res_bin,
    output [7:0] mul_res_bin [0:7],     // Debug wire
    output [7:0] add1_res_bin [0:3],    // Debug wire
    output [7:0] add2_res_bin [0:1]     // Debug wire
    );

    // Stochastic numbers
    wire inps_stoch [0:7];
    wire wghts_stoch [0:7];
    // Intermediate wires
    wire mul_stoch [0:7];
    reg [7:0] mul_bin [0:7];
    wire add1_stoch [0:3];
    wire add2_stoch [0:1];
    reg [7:0] add1_bin [0:3];
    reg [7:0] add2_bin [0:1];

    // LFSR seeds - 1 for each number generated
    reg [7:0] LFSR_seeds [0:15] = '{225, 254, 225, 243, 44, 9, 163, 124, 153, 223, 58, 255, 18, 202, 147, 179};

    // Generate stoachastic inputs
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            StochNumGen SNG_inps(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds[i]),
                .prob               (inps_num_bin[i]),
                .stoch_num          (inps_stoch[i])
            );

            StochNumGen SNG_wghts(
                .clk                (clk),
                .reset              (reset),
                .seed               (LFSR_seeds[i+8]),
                .prob               (wghts_num_bin[i]),
                .stoch_num          (wghts_stoch[i])
            );
        end
    endgenerate

    // MulAcc
    MulAcc8_bi mac(
        .clk                    (clk),
        .reset                  (reset),
        .inps_stoch             (inps_stoch),
        .weights_stoch          (wghts_stoch),
        .result_stoch           (stoch_mac_res),
        .mul_res_stoch          (mul_stoch),
        .add1_res_stoch         (add1_stoch),
        .add2_res_stoch         (add2_stoch)
    );

    // STB output
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (stoch_mac_res),
        .bin_number         (mac_res_bin)
    );

    // STB for mult values
    generate
        for (i=0; i<8; i=i+1) begin
            StochToBin stb_mu(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (mul_stoch[i]),
                .bin_number         (mul_bin[i])
            );
        end
    endgenerate

    // STB for add_1 values
    generate
        for (i=0; i<4; i=i+1) begin
            StochToBin stb_add1(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (add1_stoch[i]),
                .bin_number         (add1_bin[i])
            );
        end
    endgenerate
    // STB for add_2 values
    generate
        for (i=0; i<2; i=i+1) begin
            StochToBin stb_add2(
                .clk                (clk),
                .reset              (reset),
                .bit_stream         (add2_stoch[i]),
                .bin_number         (add2_bin[i])
            );
        end
    endgenerate
    
    assign mul_res_bin = mul_bin;
    assign add1_res_bin = add1_bin;
    assign add2_res_bin = add2_bin;
endmodule
