module usb_packet_fsm (
    input wire clk,
    input wire reset,
    input wire [1:0] usb_line_state,
    input wire sync_detected,      // from SYNC FSM
    output reg data_enable,
    output reg packet_done,
    output reg error
);

parameter IDLE = 3'b000, SYNC = 3'b001, DATA = 3'b010,
          EOP_WAIT = 3'b011, DONE = 3'b100, ERROR = 3'b101;

reg [2:0] state = IDLE, next_state;

always @(*) begin
    next_state = state;
    data_enable = 0;
    packet_done = 0;
    error = 0;

    case (state)
        IDLE: begin
            if (sync_detected)
                next_state = SYNC;
        end
        SYNC: begin
            next_state = DATA;
        end
        DATA: begin
            data_enable = 1;
            if (usb_line_state == 2'b00) // SE0 = potential EOP
                next_state = EOP_WAIT;
        end
        EOP_WAIT: begin
            if (usb_line_state == 2'b01 || usb_line_state == 2'b10) // back to J/K = EOP complete
                next_state = DONE;
            else if (usb_line_state != 2'b00)
                next_state = ERROR;
        end
        DONE: begin
            packet_done = 1;
            next_state = IDLE;
        end
        ERROR: begin
            error = 1;
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

endmodule