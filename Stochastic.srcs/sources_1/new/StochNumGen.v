// Stochastic number generator

module StochNumGen(
    input clk,
    input reset,
    input [7:0] prob,  // k-bit unsigned binary integer B indicating probability
    output stoch_num
    );

    // wires
    wire [7:0] rand_num;  // k-bit random number from LFSR
    // registers
    reg bit_stream_ff;

    // Instantiate LFSR
    LFSR lfsr(
        .clk                (clk),
        .reset              (reset),
        .parallel_out       (rand_num)
    );

    // if R < B, output 1, comb logic
    always @(*) begin
        if (rand_num < prob)
            bit_stream_ff = 1'b1;
        else
            bit_stream_ff = 1'b0;
    end

    assign stoch_num = bit_stream_ff;

endmodule
