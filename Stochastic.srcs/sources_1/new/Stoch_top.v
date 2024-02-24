
module Stoch_top(
    input clk,
    input reset,
    input shift_en
    );

    // intermediate wires
    reg [7:0] prob1_wire = 8'b10000000;
    reg [7:0] prob2_wire = 8'b01000000;
    wire stoch_num1;
    wire stoch_num2;
    wire [3:0] bin_number_out;

    // SNG
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .prob               (prob1_wire),
        .stoch_num          (stoch_num1)
    );

    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .prob               (prob2_wire),
        .stoch_num          (stoch_num2)
    );


    StochToBin STB(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (bit_stream_out),
        .bin_number         (bin_number_out)
    );

endmodule
