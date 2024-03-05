`timescale 1ns / 1ps

module ReLU_tb();

    reg clk = 0;
    reg reset = 0;
    // Inputs and outputs to DUT
    reg [7:0] inp_prob = 0;
    wire [7:0] out_prob;
    reg [7:0] SNG_seed = 8'd5;

    // FSM DUT
    ReLU_FSM_top FSM_top(
        .clk                (clk),
        .reset              (reset),
        .inp_prob           (inp_prob),
        .seed               (SNG_seed),
        .out_prob           (out_prob)
    );

    // variables for stimulus
    integer fd;     // File descriptor
    integer i;
    // 128 random seeds for SNG
    reg [7:0] SNG_seeds [0:127] = '{201, 23, 83, 112, 240, 192, 173, 102, 76, 170, 51, 148, 94, 30, 249, 243, 150, 45, 60, 91, 252, 238, 133, 245, 13, 237, 138, 110, 106, 242, 211, 233, 4, 227, 140, 113, 148, 88, 27, 53, 63, 197, 74, 100, 87, 145, 60, 44, 55, 110, 123, 220, 12, 123, 93, 77, 78, 201, 250, 143, 77, 195, 190, 105, 163, 246, 234, 179, 127, 227, 13, 38, 138, 19, 229, 30, 195, 34, 99, 78, 240, 84, 9, 164, 201, 12, 239, 105, 212, 212, 29, 225, 119, 117, 7, 37, 249, 145, 187, 212, 209, 166, 205, 114, 52, 16, 17, 133, 230, 39, 31, 221, 164, 229, 29, 65, 187, 122, 124, 228, 120, 254, 245, 183, 167, 40, 187, 115};

    // Input test data
    initial begin
        fd = $fopen("relu_data.txt", "w");
        reset = 1;
        #30;
        reset = 0;
        for (i=0; i<128; i=i+1) begin
            inp_prob = i*2;
            SNG_seed = SNG_seeds[i];
            #5120;      // wait 256 clock cycles
            $fdisplay(fd, "Input: %d, Output: %d", inp_prob, out_prob);
            reset = 1;
            #40;
            reset = 0;
        end
        $fclose(fd);
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end

endmodule
