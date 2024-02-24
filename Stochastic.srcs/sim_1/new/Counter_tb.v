`timescale 1ns / 1ps

module Counter_tb();

    reg clk_tb = 1'b0;
    reg reset_tb = 1'b0;
    reg en_tb = 1'b0;
    wire [3:0] count_tb;

    Counter cnt(
        .clk            (clk_tb),
        .reset          (reset_tb),
        .en             (en_tb),
        .count          (count_tb)
    );

    initial begin
        #10;
        en_tb = 1'b1;
    end

    always begin
        #10;
        clk_tb = ~clk_tb;
    end

endmodule
