
module Bipolar_to_prob(
    input num_bipolar,
    output prob
    );

    // Apply x = (y+1)/2 or x_int = (y_int/2)+128
    assign prob = (num_bipolar/2)+128;

endmodule
