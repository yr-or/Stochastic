// Stochastic to Binary converter

module StochToBin (
    input clk,
    input reset,
    input bit_stream,
    output [3:0] bin_number
    );

    // unsigned counter with 2^k values
    reg [3:0] count_ff = 0;
    reg [4:0] clk_count = 0;
    reg done = 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            count_ff <= 0;
            done <= 1'b0;
            clk_count <= 1'b0;
        end
        else begin
            // 16 clock cycles, assert done signal on counter = 16
            if (clk_count < 5'd16) begin
                count_ff <= count_ff + bit_stream;
                clk_count <= clk_count + 1;
            end else begin
                // reset for next cycle
                clk_count <= 1;
                count_ff <= bit_stream;
            end
        end
    end

    always @(posedge clk) begin
        if (clk_count == 5'd15) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

    assign bin_number = count_ff;

endmodule
