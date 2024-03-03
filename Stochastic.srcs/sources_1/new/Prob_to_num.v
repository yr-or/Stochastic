// Specifically for bipolar prob -> binary number
// For unipolar, mapping is just the same value

module Prob_to_num(
    input [7:0] prob,
    output [7:0] num
    );

    // Apply the mapping y = 2x-1
    // Interpreting prob as a standard binary unsigned integer, mapping is 2x-256
    assign num = (2*prob)-256;

endmodule
