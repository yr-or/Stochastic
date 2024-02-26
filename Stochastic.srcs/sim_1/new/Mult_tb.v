`timescale 1ns / 1ps

module Mult_tb();

    reg clk_tb = 1'b0;
    reg reset_tb = 1'b0;
    reg [7:0] num1_tb;
    reg [7:0] num2_tb;
    wire [3:0] mul_tb;


    Mult mu (
        .clk                (clk_tb),
        .reset              (reset_tb),
        .num1               (num1_tb),
        .num2               (num2_tb),
        .num_mul            (mul_tb)
    );

    initial begin
        reset_tb = 1'b1;
        #100;
        reset_tb = 1'b0;
        // Test 0.5*0.25 = 0.125 = 0010 4-bit or 0010 0000 8-bit
        num1_tb = 8'b10000000; // 0.5
        num2_tb = 8'b01000000; // 0.25
        #100;
    end

    always begin
        clk_tb = ~clk_tb;
        #10;
    end

endmodule
