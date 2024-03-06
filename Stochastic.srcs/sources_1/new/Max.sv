// Return index of maximum stochastic number in array

module Max #(parameter NUM_INP=10)(
    input clk,
    input reset,
    input stoch_array [0:NUM_INP-1],
    output [4:0] max_ind,            // 64 vals
    output done
    );
    // Count 1s in bitstreams, most=max val

    // wires
    wire [7:0] stb_out [0:NUM_INP-1];
    wire [0:NUM_INP-1] done_stb_array;
    wire done_stb = &(done_stb_array);

    // Use STBs to count vals
    genvar i;
    generate
        for (i=0; i<NUM_INP; i=i+1) begin
                StochToBin stb(
                    .clk                (clk),
                    .reset              (reset),
                    .bit_stream         (stoch_array[i]),
                    .bin_number         (stb_out[i]),
                    .done               (done_stb_array[i])
                );
        end
    endgenerate

    // Registers
    reg [4:0] index_max = 0;
    reg signed [7:0] max = 0;
    reg [4:0] count_ff = 5'b0;          // 5-bit up-counter from 0 to 9
    reg done_ff = 1'b0;

    always @(posedge clk) begin
        // Posedge synchronous reset
        if (reset) begin
            index_max <= 5'b0;
            max <= 8'b0;
            count_ff <= 5'b0;
        end 
        else if (done_stb) begin
            if (count_ff < NUM_INP) begin
                if (stb_out[count_ff] > max) begin
                    max <= stb_out[count_ff];
                    index_max <= count_ff;
                end
                count_ff <= count_ff + 1'b1;
            end else
                done_ff <= 1'b1;
        end
    end

    assign max_ind = index_max;
    assign done = done_ff;

endmodule
