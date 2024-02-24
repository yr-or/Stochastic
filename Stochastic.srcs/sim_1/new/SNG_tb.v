`timescale 1ns / 1ps

module SNG_tb();

    reg clk_tb = 1'b1;
    reg reset_tb = 1'b0;
    reg [7:0] prob_tb;
    wire bit_stream_tb;
    wire [3:0] bin_number_out;

    StochNumGen SNG(
        .clk                (clk_tb),
        .reset              (reset_tb),
        .prob               (prob_tb),
        .stoch_num          (bit_stream_tb)
    );

    StochToBin STB(
        .clk                (clk_tb),
        .reset              (reset_tb),
        .bit_stream         (bit_stream_tb),
        .bin_number         (bin_number_out)
    );

    initial begin
        reset_tb = 1;
        #40;
        reset_tb = 0;
        prob_tb = 8'b10000000;  // 0.5
        #400;
    end

    always begin
        #10;
        clk_tb = ~clk_tb;
    end

endmodule
