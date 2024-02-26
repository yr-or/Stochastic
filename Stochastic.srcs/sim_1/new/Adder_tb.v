`timescale 1ns / 1ps

module Adder_tb();

    reg clk = 1'b0;
    reg reset = 1'b0;

    always begin
        clk = ~clk;
        #10;
    end

endmodule
