`timescale 1ns/1ns
module frame_decoder(input clk, rst, input[7:0] frame, input frame_valid, ack, output[3:0] data, address, output valid);
    reg[3:0] data_ff, address_ff, data_nxt, address_nxt;
    reg valid_ff, valid_nxt;

    assign data = data_ff;
    assign address = address_ff;
    assign valid = valid_ff;

    localparam[1:0] WAIT = 2'b00,
                    SPLIT = 2'b01,
                    SEND = 2'b10,
                    ACK = 2'b11;

    reg[1:0] state_ff, state_nxt;

    always @* begin
        state_nxt = state_ff;
        address_nxt = address_ff;
        data_nxt = data_ff;

        case(state_ff)
            WAIT: begin
                if(frame_valid) begin
                    state_nxt = SPLIT;
                end
            end

            SPLIT: begin
                address_nxt = frame[7:4];
                data_nxt = frame[3:0];
                state_nxt = SEND;
            end

            SEND: begin
                valid_nxt = 1'b1;
                if(ack) begin
                    state_nxt = ACK;
                end
            end

            ACK: begin
                valid_nxt = 1'b0;
                state_nxt = WAIT;
            end
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state_ff <= WAIT;
            address_ff <= 4'b0000;
            data_ff <= 4'b0000;
            valid_ff <= 1'b0;
        end else begin
            state_ff <= state_nxt;
            address_ff <= address_nxt;
            data_ff <= data_nxt;
            valid_ff <= valid_nxt;
        end
    end
endmodule