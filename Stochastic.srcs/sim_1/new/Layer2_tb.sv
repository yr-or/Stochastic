`timescale 1ns / 1ps

module Layer2_tb();

    // regs
    reg clk = 0;
    reg reset = 0;

    //wires
    wire [7:0] results_bin [0:7];
    wire [7:0] macc_results_bin [0:7];
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
    Layer2_test dut(
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
            $write("L2_out = ");
            for (int j=0; j<8; j=j+1) begin
                $write("%d, ", results_bin[j]);
            end
            $write("\nL2_macc_out = ");
            for (int j=0; j<8; j=j+1) begin
                $write("%d, ", macc_results_bin[j]);
            end
        end
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end

endmodule
