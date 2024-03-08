`timescale 1ns / 1ps

module NN_tb();

    // regs
    reg clk = 0;
    reg reset = 0;

    //wires
    wire [7:0] results_bin [0:4];
    wire [7:0] macc_results_bin [0:4];
    wire done_stb;

    // Test data - binary probabilities
    reg [7:0] test_inputs [0:4][0:7] = '{ 
        {182, 59, 17, 134, 155, 116, 48, 147}, 
        {66, 67, 112, 162, 140, 227, 138, 70}, 
        {80, 97, 92, 161, 137, 78, 190, 29}, 
        {47, 232, 11, 74, 102, 12, 28, 187}, 
        {216, 89, 48, 1, 174, 107, 57, 237} 
    };

    // Regs to apply test data to
    reg [7:0] input_data_bin [0:7];

    // Inst. NN_top
    NN_top dut(
        .clk                (clk),
        .reset              (reset),
        .input_data_bin     (input_data_bin),
        .results_bin        (results_bin),
        .macc_results_bin   (macc_results_bin),
        .done               (done_stb)
    );

    // Apply test data in order
    initial begin
        reset = 1;
        #10;

        for (int i=0; i<5; i=i+1) begin
            // Set inputs
            reset = 1;
            input_data_bin = test_inputs[i];

            // Hold reset for 2 clks
            #40;
            reset = 0;

            // Wait 256 clock cycles
            #5120;
            // print results
            $display("Results: %d, %d, %d, %d, %d", results_bin[0], results_bin[1], results_bin[2], results_bin[3], results_bin[4]);
            $display("Macc results: %d, %d, %d, %d, %d", macc_results_bin[0], macc_results_bin[1], macc_results_bin[2], macc_results_bin[3], macc_results_bin[4]);
        end
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end

endmodule
