
module SNG_into_STB(
    input clk,
    input reset,
    input prob,
    output [7:0] bin_number,
    output done
    );

    reg reset_tb = 1'b0;
    reg [7:0] prob_tb;
    wire bit_stream_tb;
    wire [7:0] bin_number_out;

    StochNumGen SNG(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'd73),
        .prob               (prob),
        .stoch_num          (bit_stream_tb)
    );

    StochToBin STB(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (bit_stream_tb),
        .bin_number         (bin_number_out),
        .done               (done)
    );

    assign bin_number = bin_number_out;

endmodule
