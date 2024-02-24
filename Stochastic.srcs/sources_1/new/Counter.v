
module Counter(
    input clk,
    input reset,
    input en,
    output [3:0] count
    );

    reg [3:0] count_ff = 0;

    always @(posedge clk) begin
        if (reset)
            count_ff <= 0;
        else
            count_ff <= count_ff + en;
    end

    assign count = count_ff;

endmodule
