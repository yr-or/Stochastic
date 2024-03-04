
module Prob_to_bipolar(
    input prob,
    output num_bipolar
    );

    // Apply y=2x-1 or y_int = 2x_int-256
    assign num_bipolar = (2*prob)-256;

endmodule
