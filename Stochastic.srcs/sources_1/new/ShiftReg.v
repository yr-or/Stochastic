
module ShiftReg #(parameter NUM_REGS=8) (
    input clk,
    input reset,
    input shiftIn,
    input shiftEn,
    output shiftOut,
    output [NUM_REGS-1:0] parallelOut
    );

    reg [NUM_REGS-1:0] shift_ff = 0;

    always @(posedge clk) begin
        if (reset) begin
            shift_ff <= 0;
        end else if (shiftEn) begin
            shift_ff <= {shift_ff[NUM_REGS-2:0], shiftIn};
        end
    end

    assign parallelOut = shift_ff;
    assign shiftOut = shift_ff[NUM_REGS-1];

endmodule
