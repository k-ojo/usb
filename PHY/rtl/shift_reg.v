module shift_reg_8bit (
    input clk,
    input reset,
    input enable,
    input reg serial_in,
    output reg [7:0] parallel_out;
);
always @(posedge clk) begin
    if (reset) begin
        Q<=8'b0;
    end
    else begin
        Q<={serial_in, parallel_out[7:1]};
    end
end
    
endmodule
