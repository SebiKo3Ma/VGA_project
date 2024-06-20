`timescale 1ns/1ns
module UART_processor(input clk_16bd, clk_bd, Rx, valid, input[3:0] data, address, output [7:0] frame, output frame_valid, ack);
    localparam[2:0] IDLE = 3'b000,
                    START = 3'b001,
                    READ = 3'b010,
                    PARITY = 3'b011,
                    CHECK = 3'b100;
                    STOP = 3'b101;

    reg[2:0] state_ff, state_nxt;
    reg crt_bit;
    reg [2:0] counter;

    reg idle;
    reg[3:0] count;

    reg parity, parity_type, stop_bits;
    reg[2:0] frame_length;

    always @* begin
        state_nxt = state_ff;

        case(state_ff)
            IDLE: begin
                if(!crt_bit) begin
                    state_nxt = START;
                end else begin
                    state_nxt = IDLE;
                end
            end

            START: begin

            end

            READ: begin
                if()
            end
        endcase
    end

    always @(posedge clk_16bd, negedge rst) begin
        if(rst) begin
            idle <= 1'b1;
            count <= 4'd0;
        end

        if(!Rx) begin
            idle <= 1'b0;
        end

        if(!idle) begin
            count <= count + 1;
        end

        if(!count) begin
            if(count == 4'd8) begin
                data <= Rx;
            end
        end else begin
            idle <= 1'b1;
        end
    end
endmodule