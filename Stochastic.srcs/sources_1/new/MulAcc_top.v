// Inst. MulAcc module and inputs and STB

module MulAcc_top(
    input clk,
    input reset,
    output res_stoch,
    output [7:0] res_bin
    );

    wire num1_stoch;
    wire num2_stoch;
    reg [7:0] num1 = 8'b10000000;
    reg [7:0] num2 = 8'b01000000;
    wire stoch_mac_res;

    // Generate num1
    StochNumGen SNG1(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b10110111),
        .prob               (num1),
        .stoch_num          (num1_stoch)
    );
    // Generate num2
    StochNumGen SNG2(
        .clk                (clk),
        .reset              (reset),
        .seed               (8'b01011100),
        .prob               (num2),
        .stoch_num          (num2_stoch)
    );

    // MulAcc
    MulAcc mac(
        .clk                    (clk),
        .reset                  (reset),
        .stoch_num1             (num1_stoch),
        .stoch_num2             (num2_stoch),
        .stoch_res              (stoch_mac_res)
    );

    // STB
    StochToBin stb(
        .clk                (clk),
        .reset              (reset),
        .bit_stream         (stoch_mac_res),
        .bin_number         (res_bin)
    );

    assign res_stoch = stoch_mac_res;

endmodule
