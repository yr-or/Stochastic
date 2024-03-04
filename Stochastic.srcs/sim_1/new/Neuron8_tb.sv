`timescale 1ns / 1ps

// Inlcude SNGs and STB in tb
module Neuron8_tb();

    // regs
    reg clk = 0;
    reg reset = 0;

    //wires
    wire [7:0] result_bin;
    wire [7:0] macc_result_bin;
    wire result_stoch;

    // Input values and weights, as binary probabilities
    //reg [7:0] input_data_bin [0:7] = '{182, 59, 17, 134, 155, 116, 48, 147};
    //reg [7:0] weights_bin [0:7] = '{3, 149, 145, 141, 174, 165, 225, 106};

    reg [7:0] input_data_bin [0:7] = '{66, 67, 112, 162, 140, 227, 138, 70};
    reg [7:0] weights_bin [0:7] = '{232, 67, 72, 142, 230, 188, 167, 207};
    
    reg [7:0] bias_bin = 8'd10;     // 128 = bipolar value of 0, bitstream prob = 0.5 //

    // Inst. Neuron
    Neuron8_top dut(
        .clk                    (clk),
        .reset                  (reset),
        .input_data_bin         (input_data_bin),
        .weights_bin            (weights_bin),
        .bias_bin               (bias_bin),
        .result_bin             (result_bin),
        .macc_result_bin        (macc_result_bin),
        .result_stoch           (result_stoch)
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

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end


endmodule
