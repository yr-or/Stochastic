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
    wire done_stb;

    // Test data - binary probabilities
    reg [7:0] test_inputs [0:4][0:7] = '{ {182, 59, 17, 134, 155, 116, 48, 147}, {66, 67, 112, 162, 140, 227, 138, 70}, 
        {80, 97, 92, 161, 137, 78, 190, 29}, {47, 232, 11, 74, 102, 12, 28, 187}, {216, 89, 48, 1, 174, 107, 57, 237} };

    reg [7:0] test_weights [0:4][0:7] = '{ {3, 149, 145, 141, 174, 165, 225, 106}, {232, 67, 72, 142, 230, 188, 167, 207},
        {11, 250, 2, 139, 202, 134, 152, 59}, {255, 180, 62, 164, 59, 9, 76, 96}, {57, 212, 20, 146, 148, 251, 184, 175} };

    // 128 = bipolar value of 0, bitstream prob = 0.5 //
    reg [7:0] bias_bin = 8'd138;  // 0.08

    // Regs to apply test data to
    reg [7:0] input_data_bin [0:7];
    reg [7:0] weights_bin [0:7];

    // Inst. Neuron
    Neuron8_top dut(
        .clk                    (clk),
        .reset                  (reset),
        .input_data_bin         (input_data_bin),
        .weights_bin            (weights_bin),
        .bias_bin               (bias_bin),
        .result_bin             (result_bin),
        .macc_result_bin        (macc_result_bin),
        .result_stoch           (result_stoch),
        .done                   (done_stb)
    );

    // Apply test data in order
    initial begin
        reset = 1;
        #10;

        for (int i=0; i<5; i=i+1) begin
            // Set inputs
            reset = 1;
            input_data_bin = test_inputs[i];
            weights_bin = test_weights[i];

            // Hold reset for 2 clks
            #40;
            reset = 0;

            // Wait 256 clock cycles
            #5120;
            $display("Result: %d", result_bin);
        end        
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end


endmodule
