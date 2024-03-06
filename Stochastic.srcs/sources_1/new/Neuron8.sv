// SC Neuron rev 2 - with activation function

// Inputs and outputs all SNs
module Neuron8(
    input clk,
    input reset,
    input input_data [0:7],     // Bus of 8 stochastic numbers
    input weights [0:7],
    input bias,
    output result,
    output macc_result          // debug wire
    );

    // Wires / register
    wire result_macc;
    wire result_bias;
    wire result_relu;

    // MulAcc module
    MulAcc8_bi macc8(
        .clk                (clk),
        .reset              (reset),
        .inps_stoch         (input_data),
        .weights_stoch      (weights),
        .result_stoch       (result_macc)
    );

    // Add bias - instantiate adder
    Adder add_bias(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd12),
        .stoch_num1         (result_macc),
        .stoch_num2         (bias),
        .result_stoch       (result_bias)
    );

    // Activation function
    ReLU_FSM act_fcn(
        .clk                (clk),
        .reset              (reset),
        .in_stoch           (result_bias),
        .out_stoch          (result_relu)
    );

    assign result = result_relu;
    assign macc_result = result_macc;

endmodule
