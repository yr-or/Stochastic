`timescale 1ns / 1ps
// Test 4-bit LFSR

module LFSR_tb();

    reg clk_tb = 1'b1;
    wire [7:0] rand_num;

    // instantiate dut
    LFSR dut(
        .clk                (clk_tb),
        .parallel_out       (rand_num)
    );

    always begin
        #10;
        clk_tb = ~clk_tb;
    end

endmodule
