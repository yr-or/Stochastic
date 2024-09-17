// 8-bit LFSR, maximum length of loop = 255
// https://www.eetimes.com/tutorial-linear-feedback-shift-registers-lfsrs-part-1/
// based on https://www.digitalxplore.org/up_proc/pdf/91-1406198475105-107.pdf

module LFSR(
    input clk,
    input reset,
    input [7:0] seed,
    output [7:0] parallel_out
    );

    reg [7:0] shift_reg;
    // intermediate wires
    wire xor1, xor2, xor3;
    assign xor1 = shift_reg[2] ^ shift_reg[0];
    assign xor2 = xor1 ^ shift_reg[3];
    assign xor3 = xor2 ^ shift_reg[4];

    // 8-bit shift register with two taps
    always @(posedge clk) begin
        if (reset)
            shift_reg <= seed;  // initial seed
        else
            shift_reg <= {xor3, shift_reg[7:1]};
    end

assign parallel_out = shift_reg;

endmodule
