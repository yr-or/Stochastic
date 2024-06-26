// 8-bit Galois LFSR, maximum length of loop = 255
// based on https://datacipy.cz/lfsr_table.pdf

module LFSR(
    input clk,
    input reset,
    input [7:0] seed,
    output [7:0] parallel_out
    );

    reg [7:0] shift_reg;
    // intermediate wires
    wire xor1, xor2, xor3;
    assign xor1 = shift_reg[5] ^ shift_reg[7];
    assign xor2 = xor1 ^ shift_reg[4];
    assign xor3 = xor2 ^ shift_reg[3];

    // 8-bit shift register with two taps
    always @(posedge clk) begin
        if (reset)
            shift_reg <= seed;  // initial seed
        else
            shift_reg <= {shift_reg[6:0], xor3};
    end

    // Initial seed
    initial begin
        shift_reg = seed;
    end

assign parallel_out = shift_reg;

endmodule
