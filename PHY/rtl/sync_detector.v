module sync_detector (
    input wire clk,
    input wire reset,
    input wire [1:0] nrzi_input,
    output wire ena_data
);

parameter USB_LINE_IDLE = 2'b00;  // SE0
parameter USB_LINE_J    = 2'b01;
parameter USB_LINE_K    = 2'b10;
parameter USB_LINE_SE0  = 2'b11;  // Illegal (D+ = 1, D- = 1)

// FSM states
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011;
parameter E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111;
parameter I = 4'b1000;

reg [3:0] state = A, next_state;

always @(*) begin
    next_state = A; // default fallback
    case (state)
        A: next_state = (nrzi_input == USB_LINE_K) ? B : A;
        B: next_state = (nrzi_input == USB_LINE_J) ? C : A;
        C: next_state = (nrzi_input == USB_LINE_K) ? D : A;
        D: next_state = (nrzi_input == USB_LINE_J) ? E : A;
        E: next_state = (nrzi_input == USB_LINE_K) ? F : A;
        F: next_state = (nrzi_input == USB_LINE_J) ? G : A;
        G: next_state = (nrzi_input == USB_LINE_K) ? H : A;
        H: next_state = (nrzi_input == USB_LINE_K) ? I : A;
        I: next_state = (nrzi_input == USB_LINE_SE0) ? A : I;
        default: next_state = A;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

assign ena_data = (state == I); // Sync pattern fully detected

endmodule