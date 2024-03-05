
module ReLU_FSM_top(
    input clk,
    input reset,
    input [7:0] inp_prob,
    input [7:0] seed,
    output [7:0] out_prob
    );

    // Wires
    wire inp_stoch;
    wire out_stoch;

    // Generate stochastic number
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (seed),
        .prob               (inp_prob),
        .stoch_num          (inp_stoch)
    );

    // Apply stoch input to FSM
    ReLU_FSM FSM(
        .clk                (clk),
        .reset              (reset),
        .in_stoch           (inp_stoch),
        .out_stoch          (out_stoch)
    );

    // Estimate probability of output
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (out_stoch),
        .bin_number         (out_prob)
    );  

endmodule
