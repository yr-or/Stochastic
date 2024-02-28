
module MulAcc(
    input clk,
    input reset,
    input stoch_num1,
    input stoch_num2,
    output stoch_res
    );

    wire stoch_mul_res;
    wire stoch_add_res;

    // Instantiate multiplier 
    Mult mult(
        .stoch_num1             (stoch_num1),
        .stoch_num2             (stoch_num2),
        .stoch_res              (stoch_mul_res)
    );

    // Instantiate adder
    Adder adder(
        .clk                    (clk),
        .reset                  (reset),
        .stoch_num1             (stoch_mul_res),
        .stoch_num2             (stoch_add_res),     // Feedback for accumulate
        .result_stoch           (stoch_add_res)
    );

    assign stoch_res = stoch_add_res;

endmodule
