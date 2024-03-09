`timescale 1ns / 1ps

// Inlcude SNGs and STB in tb
module Neuron8_tb();

    // regs
    reg clk = 0;
    reg reset = 0;

    localparam NUM_TESTS = 100;

    // Test data - binary probabilities - 100 tests
    reg [7:0] test_inputs [0:NUM_TESTS-1][0:7] = '{ 
        { 174, 171, 31, 234, 212, 178, 148, 44 },
        { 113, 92, 226, 34, 68, 118, 47, 14 },
        { 204, 255, 78, 2, 209, 93, 28, 193 },
        { 28, 176, 36, 187, 47, 154, 21, 187 },
        { 14, 126, 15, 169, 124, 99, 52, 171 },
        { 174, 189, 250, 2, 193, 73, 188, 117 },
        { 78, 227, 229, 148, 41, 155, 5, 105 },
        { 144, 192, 93, 24, 194, 244, 106, 119 },
        { 237, 223, 3, 59, 57, 67, 190, 93 },
        { 226, 180, 0, 183, 181, 51, 217, 34 },
        { 191, 83, 214, 106, 84, 212, 78, 187 },
        { 169, 124, 181, 72, 145, 213, 92, 254 },
        { 138, 45, 147, 131, 81, 23, 120, 14 },
        { 64, 217, 113, 185, 177, 237, 220, 14 },
        { 91, 7, 46, 47, 201, 89, 153, 204 },
        { 122, 58, 40, 187, 240, 197, 219, 15 },
        { 158, 123, 1, 137, 32, 121, 9, 72 },
        { 145, 242, 168, 79, 215, 69, 52, 60 },
        { 214, 220, 200, 206, 184, 107, 33, 235 },
        { 149, 238, 109, 144, 19, 7, 48, 48 },
        { 239, 201, 108, 112, 74, 140, 175, 108 },
        { 167, 25, 61, 245, 207, 39, 214, 54 },
        { 21, 255, 246, 127, 185, 28, 59, 113 },
        { 33, 191, 129, 47, 18, 189, 245, 23 },
        { 3, 151, 202, 60, 189, 68, 69, 126 },
        { 94, 147, 124, 54, 150, 57, 141, 79 },
        { 181, 196, 247, 147, 224, 243, 221, 224 },
        { 103, 24, 43, 241, 169, 209, 155, 92 },
        { 15, 0, 126, 91, 197, 125, 235, 25 },
        { 50, 27, 179, 244, 37, 243, 8, 0 },
        { 137, 78, 207, 2, 77, 34, 222, 188 },
        { 221, 218, 253, 96, 127, 197, 30, 148 },
        { 181, 138, 28, 22, 140, 134, 193, 211 },
        { 194, 98, 195, 35, 168, 75, 134, 170 },
        { 143, 94, 208, 14, 38, 216, 34, 120 },
        { 82, 72, 227, 131, 85, 12, 252, 250 },
        { 103, 50, 173, 59, 162, 166, 72, 11 },
        { 46, 148, 78, 168, 221, 127, 187, 204 },
        { 33, 17, 43, 2, 106, 24, 247, 63 },
        { 56, 178, 232, 249, 227, 238, 112, 6 },
        { 93, 100, 253, 113, 8, 64, 255, 243 },
        { 200, 126, 242, 216, 102, 213, 237, 168 },
        { 191, 152, 3, 102, 189, 222, 191, 94 },
        { 154, 184, 175, 101, 89, 10, 57, 157 },
        { 82, 26, 102, 80, 246, 51, 55, 33 },
        { 64, 213, 98, 232, 177, 246, 103, 28 },
        { 147, 252, 136, 156, 251, 199, 6, 92 },
        { 29, 202, 1, 26, 226, 11, 2, 55 },
        { 178, 3, 139, 73, 236, 93, 74, 160 },
        { 132, 228, 162, 88, 7, 192, 239, 178 },
        { 97, 147, 42, 252, 229, 47, 123, 47 },
        { 137, 212, 226, 64, 72, 47, 208, 57 },
        { 203, 212, 230, 39, 153, 67, 89, 6 },
        { 156, 106, 73, 42, 217, 237, 38, 54 },
        { 49, 104, 144, 91, 116, 14, 52, 43 },
        { 130, 108, 8, 188, 76, 197, 102, 236 },
        { 84, 151, 75, 234, 42, 68, 91, 144 },
        { 82, 231, 251, 40, 223, 216, 7, 21 },
        { 116, 202, 255, 166, 42, 90, 183, 12 },
        { 131, 175, 148, 168, 48, 142, 239, 5 },
        { 155, 1, 168, 157, 6, 241, 8, 57 },
        { 207, 221, 120, 150, 27, 213, 203, 192 },
        { 16, 172, 255, 187, 221, 197, 156, 192 },
        { 7, 130, 168, 84, 145, 39, 123, 147 },
        { 76, 217, 214, 22, 196, 52, 219, 193 },
        { 137, 116, 199, 129, 126, 25, 18, 162 },
        { 96, 184, 186, 247, 82, 139, 74, 193 },
        { 161, 84, 67, 20, 0, 233, 167, 29 },
        { 213, 75, 31, 182, 197, 65, 7, 99 },
        { 54, 249, 225, 151, 92, 155, 7, 154 },
        { 14, 110, 148, 75, 165, 210, 67, 210 },
        { 6, 195, 224, 65, 17, 70, 237, 206 },
        { 84, 60, 101, 76, 71, 21, 106, 143 },
        { 74, 154, 69, 230, 16, 197, 114, 218 },
        { 22, 107, 57, 236, 58, 248, 64, 144 },
        { 23, 95, 78, 61, 39, 61, 98, 179 },
        { 152, 80, 110, 18, 138, 104, 164, 178 },
        { 165, 244, 236, 112, 7, 227, 189, 252 },
        { 243, 45, 91, 122, 238, 24, 135, 89 },
        { 57, 117, 64, 54, 212, 62, 92, 253 },
        { 154, 111, 25, 65, 246, 222, 110, 220 },
        { 207, 197, 37, 173, 128, 42, 202, 240 },
        { 229, 168, 223, 138, 4, 0, 233, 92 },
        { 54, 236, 204, 17, 215, 70, 108, 96 },
        { 104, 243, 191, 216, 216, 46, 79, 192 },
        { 8, 212, 231, 249, 73, 13, 95, 27 },
        { 224, 62, 167, 29, 181, 108, 141, 234 },
        { 59, 206, 57, 56, 218, 21, 160, 14 },
        { 106, 82, 167, 236, 180, 98, 41, 38 },
        { 197, 253, 92, 31, 27, 42, 144, 233 },
        { 67, 203, 228, 238, 111, 134, 79, 241 },
        { 163, 127, 24, 86, 237, 160, 216, 91 },
        { 138, 127, 92, 59, 120, 39, 49, 53 },
        { 183, 203, 122, 200, 234, 142, 32, 53 },
        { 91, 234, 224, 249, 37, 149, 254, 76 },
        { 145, 188, 105, 51, 99, 102, 35, 63 },
        { 205, 57, 185, 169, 24, 238, 111, 78 },
        { 178, 153, 240, 146, 234, 254, 200, 108 },
        { 155, 230, 93, 28, 123, 136, 189, 4 },
        { 169, 230, 244, 99, 188, 120, 199, 0 }
    };

    reg [7:0] test_weights [0:NUM_TESTS-1][0:7] = '{ 
        { 123, 72, 133, 215, 143, 100, 56, 176 },
        { 48, 25, 155, 68, 227, 109, 149, 213 },
        { 41, 172, 234, 9, 34, 12, 122, 41 },
        { 167, 136, 218, 194, 232, 91, 246, 45 },
        { 131, 15, 236, 197, 132, 93, 105, 50 },
        { 98, 83, 149, 224, 99, 47, 39, 124 },
        { 34, 150, 134, 13, 50, 180, 255, 85 },
        { 61, 142, 253, 147, 195, 79, 223, 92 },
        { 141, 25, 16, 245, 61, 124, 111, 25 },
        { 29, 49, 19, 190, 171, 129, 88, 176 },
        { 39, 52, 226, 125, 6, 138, 81, 151 },
        { 52, 103, 7, 160, 253, 246, 93, 148 },
        { 38, 35, 120, 125, 36, 206, 130, 3 },
        { 240, 108, 144, 14, 197, 60, 183, 131 },
        { 225, 58, 129, 18, 141, 237, 112, 198 },
        { 126, 252, 36, 93, 5, 110, 105, 169 },
        { 111, 47, 90, 237, 35, 39, 253, 13 },
        { 254, 169, 128, 119, 220, 210, 224, 176 },
        { 4, 53, 161, 176, 81, 67, 242, 129 },
        { 120, 211, 220, 19, 26, 104, 66, 81 },
        { 237, 67, 29, 230, 118, 204, 0, 140 },
        { 77, 88, 56, 92, 127, 183, 244, 84 },
        { 76, 180, 72, 230, 179, 171, 250, 111 },
        { 185, 166, 202, 59, 48, 225, 204, 141 },
        { 167, 144, 94, 178, 99, 83, 188, 115 },
        { 42, 111, 4, 56, 161, 130, 87, 172 },
        { 194, 119, 45, 123, 56, 249, 237, 186 },
        { 195, 192, 171, 98, 26, 187, 165, 7 },
        { 89, 137, 167, 106, 222, 232, 101, 18 },
        { 251, 157, 142, 228, 145, 99, 9, 136 },
        { 69, 56, 199, 141, 85, 81, 201, 23 },
        { 72, 227, 105, 147, 239, 95, 173, 11 },
        { 61, 25, 141, 2, 252, 162, 232, 133 },
        { 248, 101, 195, 17, 229, 154, 186, 137 },
        { 217, 50, 250, 224, 153, 89, 248, 90 },
        { 131, 160, 122, 103, 200, 167, 210, 104 },
        { 180, 47, 4, 159, 73, 45, 215, 81 },
        { 68, 31, 26, 37, 223, 42, 193, 116 },
        { 206, 119, 78, 91, 216, 152, 67, 242 },
        { 101, 10, 95, 186, 216, 231, 57, 200 },
        { 102, 125, 2, 231, 22, 91, 41, 66 },
        { 17, 110, 73, 105, 73, 194, 155, 242 },
        { 152, 169, 194, 226, 230, 247, 87, 79 },
        { 187, 144, 96, 201, 236, 174, 69, 244 },
        { 90, 65, 158, 162, 227, 160, 169, 0 },
        { 249, 216, 12, 79, 247, 81, 56, 174 },
        { 86, 193, 74, 149, 207, 107, 52, 152 },
        { 39, 51, 48, 183, 33, 58, 213, 154 },
        { 105, 103, 95, 134, 164, 191, 42, 179 },
        { 126, 122, 96, 120, 99, 10, 118, 228 },
        { 145, 60, 193, 200, 92, 219, 29, 60 },
        { 36, 5, 213, 41, 95, 36, 87, 231 },
        { 227, 36, 32, 160, 153, 9, 209, 78 },
        { 3, 140, 87, 169, 97, 180, 17, 0 },
        { 112, 98, 13, 83, 4, 157, 123, 254 },
        { 25, 202, 63, 73, 61, 200, 204, 24 },
        { 65, 7, 68, 138, 26, 16, 157, 192 },
        { 192, 172, 170, 228, 202, 225, 76, 210 },
        { 246, 48, 167, 0, 172, 41, 220, 244 },
        { 245, 51, 193, 75, 88, 7, 60, 161 },
        { 162, 21, 64, 129, 233, 58, 216, 26 },
        { 172, 136, 204, 75, 233, 107, 19, 248 },
        { 246, 0, 237, 227, 188, 105, 255, 100 },
        { 253, 76, 179, 81, 106, 99, 220, 222 },
        { 154, 155, 250, 243, 177, 231, 203, 77 },
        { 167, 55, 90, 233, 123, 255, 59, 70 },
        { 246, 114, 125, 7, 82, 105, 51, 164 },
        { 92, 245, 164, 54, 114, 111, 39, 249 },
        { 98, 69, 133, 55, 54, 191, 173, 59 },
        { 234, 191, 46, 36, 178, 1, 37, 80 },
        { 232, 163, 126, 165, 232, 229, 72, 177 },
        { 64, 17, 221, 98, 57, 241, 236, 23 },
        { 92, 103, 72, 27, 66, 80, 139, 255 },
        { 18, 109, 254, 33, 50, 94, 52, 185 },
        { 207, 123, 28, 41, 117, 50, 186, 2 },
        { 144, 99, 11, 134, 101, 113, 218, 23 },
        { 167, 213, 188, 78, 69, 84, 255, 190 },
        { 93, 207, 39, 240, 125, 149, 122, 228 },
        { 162, 85, 26, 146, 63, 148, 245, 47 },
        { 155, 42, 32, 28, 201, 55, 51, 244 },
        { 9, 113, 155, 167, 11, 164, 253, 239 },
        { 130, 159, 17, 132, 224, 189, 227, 75 },
        { 45, 68, 223, 103, 185, 2, 92, 204 },
        { 205, 226, 7, 23, 177, 93, 215, 163 },
        { 58, 157, 138, 221, 102, 144, 128, 222 },
        { 228, 115, 218, 216, 76, 0, 14, 185 },
        { 192, 94, 252, 207, 252, 131, 45, 226 },
        { 168, 7, 99, 119, 27, 176, 41, 50 },
        { 226, 30, 109, 187, 48, 215, 174, 140 },
        { 42, 126, 75, 243, 40, 11, 11, 2 },
        { 243, 103, 137, 60, 17, 115, 241, 172 },
        { 206, 162, 226, 100, 74, 185, 236, 121 },
        { 184, 37, 255, 240, 8, 194, 44, 173 },
        { 80, 202, 235, 84, 234, 88, 211, 30 },
        { 143, 175, 252, 140, 177, 78, 196, 26 },
        { 178, 183, 114, 193, 255, 156, 71, 150 },
        { 1, 113, 86, 165, 29, 251, 87, 181 },
        { 53, 95, 231, 79, 49, 39, 156, 74 },
        { 48, 4, 160, 38, 125, 77, 180, 12 },
        { 149, 127, 31, 220, 238, 212, 152, 108 }
    };

    reg [7:0] test_biases [0:NUM_TESTS-1] = '{ 137, 26, 20, 220, 40, 2, 115, 83, 90, 127, 207, 20, 1, 109, 157, 237, 140, 27, 14, 234, 18, 66, 117, 154, 102, 229, 73, 79, 60, 138, 131, 147, 245, 213, 110, 179, 63, 244, 83, 101, 215, 25, 93, 8, 120, 180, 75, 129, 78, 83, 190, 59, 59, 67, 97, 128, 154, 203, 1, 250, 78, 113, 106, 124, 36, 221, 75, 191, 90, 238, 173, 203, 125, 73, 166, 135, 214, 55, 107, 152, 36, 115, 254, 54, 210, 5, 184, 32, 39, 104, 15, 44, 92, 14, 37, 1, 103, 109, 68, 38 };

    // wires
    wire [7:0] result_bin;
    wire [7:0] macc_result_bin;
    wire [7:0] bias_out_bin;
    wire result_stoch;
    wire done_stb;

    // Regs to apply test data to
    reg [7:0] input_data_bin [0:7];
    reg [7:0] weights_bin [0:7];
    reg [7:0] bias_bin;

    // Inst. Neuron
    Neuron8_top dut(
        .clk                    (clk),
        .reset                  (reset),
        .input_data_bin         (input_data_bin),
        .weights_bin            (weights_bin),
        .bias_bin               (bias_bin),
        .result_bin             (result_bin),
        .macc_result_bin        (macc_result_bin),
        .bias_out_bin           (bias_out_bin),
        .result_stoch           (result_stoch),
        .done                   (done_stb)
    );

    integer fd; // file descriptor

    // Apply test data in order
    initial begin
        fd = $fopen("neuron8_test.txt", "w");
        reset = 1;
        #10;

        for (int i=0; i<NUM_TESTS; i=i+1) begin
            // Set inputs
            reset = 1;
            input_data_bin = test_inputs[i];
            weights_bin = test_weights[i];
            bias_bin = test_biases[i];

            // Hold reset for 2 clks
            #40;
            reset = 0;

            // Wait 256 clock cycles
            #5120;
            $fwrite(fd, "Test: %d, ", i+1);
            $fwrite(fd, "Result: %d, ", result_bin);
            $fwrite(fd, "macc_out: %d, ", macc_result_bin);
            $fwrite(fd, "bias_out: %d\n", bias_out_bin);
        end
        $fclose(fd);
    end

    // Clock gen
    always begin
        #10;
        clk = ~clk;
    end


endmodule
