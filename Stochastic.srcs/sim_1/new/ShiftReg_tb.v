`timescale 1ns / 1ps

module ShiftReg_tb();

    reg clk_tb = 1'b0;
    reg reset_tb = 1'b0;
    reg shift_en_tb = 1'b1;
    reg shift_in_tb = 1'b0;
    wire shift_out_tb;
    wire [7:0] parallel_out_tb;

    ShiftReg shreg(
        .clk                (clk_tb),
        .reset              (reset_tb),
        .shiftIn            (shift_in_tb),
        .shiftEn            (shift_en_tb),
        .shiftOut           (shift_out_tb),
        .parallelOut        (parallel_out_tb)
    );

    initial begin
        #10;
        shift_in_tb = 1'b1; // Set value on D pin AT clock edge
    end

    always begin
        #10;
        clk_tb = ~clk_tb;
    end


endmodule
