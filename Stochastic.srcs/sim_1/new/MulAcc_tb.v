`timescale 1ns / 1ps

module MulAcc_tb();

    reg clk = 1'b0;
    reg reset = 1'b0;
    wire res_stoch;
    wire [7:0] res_bin;

    // mac_top
    MulAcc_top mac_top(
        .clk                    (clk),
        .reset                  (reset),
        .res_stoch              (res_stoch),
        .res_bin                (res_bin)
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
