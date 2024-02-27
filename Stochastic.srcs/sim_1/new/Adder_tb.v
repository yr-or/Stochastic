`timescale 1ns / 1ps

module Adder_tb();

    reg clk = 1'b0;
    reg reset = 1'b0;
    wire result_stoch;
    wire [7:0] result_bin;

    Adder_top adder(
        .clk                    (clk),
        .reset                  (reset),
        .result_stoch           (result_stoch),
        .result_bin             (result_bin)
    );

    initial begin
        reset = 1;
        #100;
        reset = 0;
        #1000;
    end

    always begin
        clk = ~clk;
        #10;
    end

endmodule
