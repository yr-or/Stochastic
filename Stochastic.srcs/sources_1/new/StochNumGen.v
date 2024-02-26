// Stochastic number generator

module StochNumGen
    (
        input clk,
        input reset,
        input [7:0] prob,       // k-bit unsigned binary integer B indicating probability
        input [7:0] rand_num,   // k-bit random number source
        output stoch_num
    );

    // registers
    reg bit_stream_ff;

    // if R < B, output 1, comb logic
    always @(*) begin
        if (rand_num < prob)
            bit_stream_ff = 1'b1;
        else
            bit_stream_ff = 1'b0;
    end

    assign stoch_num = bit_stream_ff;

endmodule
