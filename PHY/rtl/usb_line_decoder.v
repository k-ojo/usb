module usb_line_decoder (
    input wire usb_dp,
    input wire usb_dn,
    output reg [1:0] usb_line_state
);

//display the state of the USB line based on the DP and DN signals
parameter USB_LINE_IDLE = 2'b00;
parameter USB_LINE_J = 2'b01;
parameter USB_LINE_K = 2'b10;
parameter USB_LINE_SE0 = 2'b11;

always @(*) begin
    if (usb_dp == 1'b0 && usb_dn == 1'b0) begin
        usb_line_state = USB_LINE_IDLE; // SE0 state
    end else if (usb_dp == 1'b1 && usb_dn == 1'b0) begin
        usb_line_state = USB_LINE_J; // J state
    end else if (usb_dp == 1'b0 && usb_dn == 1'b1) begin
        usb_line_state = USB_LINE_K; // K state
    end else begin
        usb_line_state = USB_LINE_SE0; // Invalid state, should not happen in normal operation
    end
end