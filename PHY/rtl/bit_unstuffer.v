module bit_unstuffer (
    input wire clk,
    input wire reset,
    input wire data_enable,
    input wire bit_in,             // From NRZI decoder
    output reg valid_bit,          // Cleaned bit (excluding stuff bits)
    output reg shift_en            // High when valid_bit is ready
);

reg [2:0] one_count;
reg skip_next;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        one_count <= 0;
        skip_next <= 0;
        valid_bit <= 0;
        shift_en <= 0;
    end else if (data_enable) begin
        if (skip_next) begin
            // Skip this bit (stuffed 0)
            shift_en <= 0;
            skip_next <= 0;
            one_count <= 0;
        end else begin
            valid_bit <= bit_in;
            shift_en <= 1;

            if (bit_in == 1'b1)
                one_count <= one_count + 1;
            else
                one_count <= 0;

            // After 6 consecutive 1s, next bit is stuffed 0
            if (one_count == 6)
                skip_next <= 1;
        end
    end else begin
        shift_en <= 0;
    end
end

endmodule
