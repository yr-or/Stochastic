`timescale 1ns / 1ps

module Adder_tb();

    reg clk = 1'b0;
    reg reset = 1'b0;

    // Binary values
    reg [7:0] num1;
    reg [7:0] num2;

    // Stoch values
    wire result_stoch;
    wire [7:0] result_bin;

    // Control wires
    wire done_stb;

    Adder_top adder(
        .clk                    (clk),
        .reset                  (reset),
        .num1_bin               (num1),
        .num2_bin               (num2),
        .result_stoch           (result_stoch),
        .result_bin             (result_bin),
        .done                   (done_stb)
    );

    localparam NUM_TESTS = 100;

    // Test data
    reg [7:0] num1_test [0:NUM_TESTS-1] = '{226, 194, 223, 255, 58, 59, 136, 102, 86, 225, 26, 168, 197, 216, 124, 132, 33, 90, 240, 232, 90, 177, 37, 202, 19, 168, 109, 216, 127, 145, 95, 21, 190, 4, 164, 94, 65, 26, 178, 31, 61, 185, 76, 207, 157, 225, 73, 221, 97, 161, 96, 74, 221, 126, 241, 16, 181, 61, 122, 33, 24, 173, 108, 171, 73, 83, 85, 161, 139, 212, 182, 128, 42, 184, 154, 205, 96, 126, 67, 162, 155, 103, 56, 112, 218, 170, 168, 102, 20, 14, 165, 234, 158, 75, 250, 198, 168, 205, 192, 70};
    reg [7:0] num2_test [0:NUM_TESTS-1] = '{64, 16, 30, 172, 24, 94, 19, 206, 252, 7, 134, 197, 127, 233, 73, 190, 59, 251, 85, 118, 70, 181, 234, 70, 177, 70, 1, 126, 187, 220, 48, 117, 193, 248, 233, 104, 204, 246, 247, 152, 11, 88, 30, 10, 190, 231, 14, 103, 210, 226, 245, 167, 217, 124, 255, 2, 77, 254, 153, 38, 208, 129, 231, 52, 22, 125, 179, 167, 62, 71, 234, 77, 219, 150, 184, 18, 93, 92, 161, 177, 206, 25, 165, 212, 145, 145, 149, 185, 152, 157, 0, 195, 250, 245, 14, 167, 210, 81, 87, 105};

    integer fd;

    // Run tests
    initial begin
        fd = $fopen("Adder_test.txt", "w");
        reset = 1;
        #10;
        for (int i=0; i<NUM_TESTS; i=i+1) begin
            // Set inputs
            reset = 1;
            num1 = num1_test[i];
            num2 = num2_test[i];

            // Hold reset for 2 clks
            #40;
            reset = 0;

            // Wait 256 clock cycles
            #5120;
            // print results
            $display("Test: %d, Result: %d", i+1, result_bin);
            $fdisplay(fd, "Test: %d, Result: %d", i+1, result_bin);
        end
        $fclose(fd);
    end

    always begin
        clk = ~clk;
        #10;
    end

endmodule
