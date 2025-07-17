module shift_reg_8bit (
    input clk,
    input reset,
    input shift_enable,
    input reg serial_in,
    output reg [7:0] parallel_out;
);
always @(posedge clk) begin
    if (reset) begin
        parallel_out<=8'b0;
    end
    else if (shift_enable) begin
        parallel_out<={serial_in, parallel_out[7:1]};
    end
end
    
endmodule
