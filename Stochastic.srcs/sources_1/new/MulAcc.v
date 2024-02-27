
module MulAcc(
    input clk,
    input reset
    );

    // Instantiate multiplier 
    Mult mult(
        .clk                    (clk),
        .reset                  (reset),
        .num1                   ()
    );


endmodule
