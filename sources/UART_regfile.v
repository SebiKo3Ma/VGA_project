module uart_regfile(input clk_16bd, rst, valid, input[3:0] data, address, output ack, parity, parity_type, stop_bits, output[3:0] frame_length);
    
    reg parity_ff, parity_nxt, parity_type_ff, parity_type_nxt, stop_bits_ff, stop_bits_nxt, ack_ff, ack_nxt;
    reg[3:0] frame_length_ff, frame_length_nxt;
    reg count_ff, count_nxt;

    assign parity = parity_ff;
    assign parity_type = parity_type_ff;
    assign stop_bits = stop_bits_ff;
    assign frame_length = frame_length_ff;
    assign ack = ack_ff;

    always @* begin
        parity_nxt = parity_ff;
        parity_type_nxt = parity_type_ff;
        stop_bits_nxt = stop_bits_ff;
        frame_length_nxt = frame_length_ff;
        count_nxt = count_ff;
        ack_nxt = ack_ff;

        if(valid && !count_ff) begin
            case(address)
                4'b1001: begin
                    parity_nxt = data[0];
                    ack_nxt = 1'b1;
                end

                4'b1010: begin
                    parity_type_nxt = data[0];
                    ack_nxt = 1'b1;
                end

                4'b1011: begin
                    stop_bits_nxt = data[0];
                    ack_nxt = 1'b1;
                end

                4'b1100: begin
                    frame_length_nxt = data;
                    ack_nxt = 1'b1;
                end
            endcase

            count_nxt = 1'b1;
        end

        if(count_ff) begin
            ack_nxt = 1'b0;
            count_nxt = 1'b0;
        end
    end
    
    always @(posedge clk_16bd or posedge rst) begin
        if(rst) begin
            parity_ff <= 1'b1;
            parity_type_ff <= 1'b0;
            stop_bits_ff <= 1'b0;
            frame_length_ff <= 4'b1000;
            count_ff <= 1'b0;
            ack_ff <= 1'b0;
        end else begin
            parity_ff <= parity_nxt;
            parity_type_ff <= parity_type_nxt;
            stop_bits_ff <= stop_bits_nxt;
            frame_length_ff <= frame_length_nxt;
            count_ff <= count_nxt;
            ack_ff <= ack_nxt;
        end
    end
endmodule