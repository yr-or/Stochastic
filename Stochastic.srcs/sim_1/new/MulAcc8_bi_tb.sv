`timescale 1ns / 1ps

// Test bipolar values MulAcc8_bi module
module MulAcc8_bi_tb();

    reg clk = 0;
    reg reset = 0;
    // Input values and weights, as binary probabilities
    reg [7:0] inps_num_bin [0:7] = '{182, 59, 17, 134, 155, 116, 48, 147};
    reg [7:0] wghts_num_bin [0:7] = '{3, 149, 145, 141, 174, 165, 225, 106};
    // Outputs
    reg stoch_mac_res;
    reg [7:0] bin_mac_res;
    reg [7:0] bin_mul_res [0:7];
    reg [7:0] bin_add1_res [0:3];
    reg [7:0] bin_add2_res [0:1];

    MulAcc8_bi_top macc_top(
        .clk                (clk),
        .reset              (reset),
        .inps_num_bin       (inps_num_bin),
        .wghts_num_bin      (wghts_num_bin),
        .stoch_mac_res      (stoch_mac_res),
        .mac_res_bin        (bin_mac_res),
        .mul_res_bin        (bin_mul_res),
        .add1_res_bin       (bin_add1_res),
        .add2_res_bin       (bin_add2_res)
    );

    integer i;
    reg done = 0;
    initial begin
        done = 0;
        for (int i=0; i<256; i=i+1) begin
            #20;
        end
        done = 1;
    end

    always begin
        #10;
        clk = ~clk;
    end

endmodule
