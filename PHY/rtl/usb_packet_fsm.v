module usb_packet_fsm (
    input wire clk,
    input wire reset,
    input wire [1:0] usb_line_state,
    input wire sync_detected,      // from SYNC FSM

    output reg data_enable,
    output reg packet_done,
    output reg error,
    output wire in_packet
);

parameter IDLE = 3'd0, DATA = 3'd1, EOP_WAIT = 3'd2, DONE = 3'd3, ERROR = 3'd4;

reg [2:0] state = IDLE, next_state;
reg [1:0] se0_count; // to detect 2 SE0 cycles

assign in_packet = (state == DATA);

always @(*) begin
    next_state = state;
    data_enable = 0;
    packet_done = 0;
    error = 0;

    case (state)
        IDLE: begin
            if (sync_detected)
                next_state = DATA;
        end

        DATA: begin
            data_enable = 1;
            if (usb_line_state == 2'b00)  // SE0
                next_state = EOP_WAIT;
        end

        EOP_WAIT: begin
            if (se0_count == 2 && (usb_line_state == 2'b01 || usb_line_state == 2'b10))  // J/K after SE0
                next_state = DONE;
            else if (usb_line_state != 2'b00 && se0_count < 2)
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
    if (reset) begin
        state <= IDLE;
        se0_count <= 0;
    end else begin
        state <= next_state;
        if (state == EOP_WAIT) begin
            if (usb_line_state == 2'b00)
                se0_count <= se0_count + 1;
            else
                se0_count <= 0;
        end else begin
            se0_count <= 0;
        end
    end
end

endmodule
