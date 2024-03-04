
module Mult_bi_tb();

    reg clk_tb = 1'b0;
    reg reset_tb = 1'b0;
    reg [7:0] num1_tb;
    reg [7:0] num2_tb;
    wire [7:0] mul_tb;


    Mul_bi_top mu (
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
        // Test 0.5*-0.5 = -0.25
        num1_tb = 8'd192; // 0.5 bipolar
        num2_tb = 8'd64;  // -0.5
        #100;
    end

    always begin
        clk_tb = ~clk_tb;
        #10;
    end

endmodule
