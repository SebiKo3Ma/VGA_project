`timescale 1ns/1ns
module UART_processor(input clk_16bd, clk_bd, Rx, valid, input [3:0] data, address, output [8:0] frame, output frame_valid, ack);
    localparam[2:0] IDLE = 3'b000,
                    START = 3'b001,
                    READ = 3'b010,
                    PARITY = 3'b011,
                    CHECK = 3'b100;
                    STOP = 3'b101;
                    DROP = 3'b110

    reg[2:0] state_ff, state_nxt;
    reg crt_bit;
    reg odd_bits;

    reg[3:0] data_count_ff, data_count_nxt;
    
    reg[3:0] sample_count_ff, sample_count_nxt;

    reg parity, parity_type, stop_bits;
    reg[3:0] frame_length;

    reg[8:0] frame_ff, frame_nxt;

    always @* begin
        state_nxt = state_ff;
        data_count_nxt = data_count_ff;
        sample_count_nxt = sample_count_ff + 1;

        case(state_ff)
            IDLE: begin
                if(!crt_bit) begin
                    state_nxt = START;
                end else begin
                    state_nxt = IDLE;
                end
            end

            START: begin
                sample_count_nxt = 4'd0;
                state_nxt = READ;
            end

            READ: begin
                if(data_count_ff == frame_length) begin
                    state_nxt = PARITY;
                end else begin
                    if(crt_bit) begin
                        frame_nxt = frame_ff | (9'b1 << data_count_ff );
                    end
                    count_nxt = count_ff + 1;
                end
            end

            PARITY: begin
                if(!parity) begin
                    state_nxt = STOP;
                end else begin
                    odd_bits = frame_ff[0] ^ frame_ff[1] ^ frame_ff[2] ^ frame_ff[3] ^ frame_ff[4] ^ frame_ff[5] ^ frame_ff[6] ^ frame_ff[7] ^ frame_ff[8];
                    if(!parity_type && odd_bits == crt_bit) begin  //even parity
                        state_nxt = STOP;
                    end else if(parity_type && odd_bits != crt_bit) begin //odd parity
                        state_nxt = STOP;
                    end else begin
                        state_nxt = DROP;
                    end
                end
            end

            
        endcase
    end

    always @(posedge clk_16bd, negedge rst) begin
        if(rst) begin
            state_ff <= IDLE;
            sample_count_ff <= 4'd0;
            odd_bits = 1'b0;
        end

        if(!rst) begin
            count_ff <= count_ff + 1;
            
            if(count_ff == 4'd8) begin
                crt_bit <= Rx;
            end
        end
    end
endmodule


/*
if(valid) begin
                    case(address)
                        4'b1001: begin
                            parity = data[3];
                            ack = 1'b1;
                        end

                        4'b1010: begin
                            parity_type = data[3];
                            ack = 1'b1;
                        end

                        4'b1011: begin
                            stop_bits = data[3];
                            ack = 1'b1;
                        end

                        4'b1100: begin
                            frame_length = 4'b0101 + data;
                            ack = 1'b1;
                        end
                    endcase
                end
*/