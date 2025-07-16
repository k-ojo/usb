module nrzi_decoder (
    input wire clk,
    input wire reset,
    input wire [1:0] usb_line_state,
    output reg decoded_output
);

parameter USB_LINE_IDLE = 2'b00;  // SE0
parameter USB_LINE_J    = 2'b01;
parameter USB_LINE_K    = 2'b10;
parameter USB_LINE_SE0  = 2'b11;  // Illegal (D+ = 1, D- = 1)

reg [1:0] last_state = USB_LINE_IDLE;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        last_state <= USB_LINE_IDLE;
        decoded_output <= 0;
    end else begin
        case (usb_line_state)
            USB_LINE_J: begin
                if (last_state == USB_LINE_K) begin
                    decoded_output <= 1; // Transition from K to J
                end else begin
                    decoded_output <= 0; // No valid transition
                end
            end
            
            USB_LINE_K: begin
                if (last_state == USB_LINE_J) begin
                    decoded_output <= 0; // Transition from J to K
                end else begin
                    decoded_output <= 1; // No valid transition, assume K state
                end
            end
            
            USB_LINE_IDLE: begin
                decoded_output <= 0; // SE0 state, no data output
            end
            
            default: begin
                decoded_output <= 0; // Illegal state, no data output
            end
        endcase
        
        last_state <= usb_line_state; // Update last state for next clock cycle
    end
end

