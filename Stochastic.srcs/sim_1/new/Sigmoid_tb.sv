`timescale 1ns / 1ps

module Sigmoid_tb();

    reg clk = 0;
    reg reset = 0;
    // Inputs and outputs to DUT
    reg [7:0] inp_prob;
    wire [7:0] out_prob;

    // FSM DUT
    Sigmoid_FSM_top FSM_top(
        .clk                (clk),
        .reset              (reset),
        .inp_prob           (inp_prob),
        .seed               (8'd103),
        .out_prob           (out_prob)
    );

    // Test data
    reg [7:0] test_data [0:99] = '{ 52, 228, 27, 217, 70, 94, 170, 171, 230, 58, 87, 177, 245, 77, 238, 94, 57, 23, 47, 233, 81, 166, 163, 76, 224, 65, 195, 239, 216, 130, 177, 62, 51, 65, 158, 165, 131, 207, 112, 252, 116, 128, 7, 234, 193, 181, 146, 166, 133, 3, 232, 58, 193, 131, 221, 183, 153, 90, 119, 223, 39, 42, 168, 254, 58, 65, 141, 204, 65, 97, 12, 218, 224, 142, 117, 26, 165, 107, 108, 181, 81, 240, 22, 220, 93, 89, 211, 31, 46, 219, 177, 246, 104, 125, 237, 225, 111, 179, 94, 129 };

    integer fd;     // File descriptor

    // Input test data
    initial begin
        fd = $fopen("sigmoid_data.txt", "w");
        reset = 1;
        #10;

        for (int i=0; i<100; i=i+1) begin
            // Set inputs
            reset = 1;
            inp_prob = test_data[i];

            // Hold reset for 2 clks
            #40;
            reset = 0;

            // Wait 256 clock cycles
            #5120;
            $fdisplay(fd, "Input: %d, Output: %d", inp_prob, out_prob);
        end
        $fclose(fd);
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end

endmodule
