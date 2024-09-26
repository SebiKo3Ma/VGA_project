module channel_processor(input clk, rst, SW0, SW1, add, input[3:0] address, data, input valid, output ack, output[3:0] data_out, output data_out_valid, output[1:0] channel);
    
    reg ack_ff, ack_nxt, data_out_valid_ff, data_out_valid_nxt;
    reg[3:0] data_out_ff, data_out_nxt;
    reg[1:0] ch_ff, ch_nxt, channel_ff, channel_nxt;
    reg count_ff, count_nxt, check_add_ff, check_add_nxt;

    assign channel = channel_ff;
    assign ack = ack_ff;
    assign data_out = data_out_ff;
    assign data_out_valid = data_out_valid_ff;

    always @* begin
        ch_nxt = ch_ff;
        channel_nxt = channel_ff;
        count_nxt = count_ff;
        check_add_nxt = check_add_ff;
        ack_nxt = ack_ff;
        data_out_nxt = data_out_ff;
        data_out_valid_nxt = data_out_valid_ff;

        if(valid && !count_ff) begin
            case(address)
                4'b0010: begin
                    if(data == 4'b1111) begin
                        data_out_nxt = ch_nxt;
                        data_out_valid_nxt = 1'b1;
                    end else begin
                        ch_nxt = data[1:0];
                    end
                    
                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                default: begin
                end
            endcase
        end

        if(count_ff) begin
            ack_nxt = 1'b0;
            count_nxt = 1'b0;
            data_out_valid_nxt = 1'b0;
            data_out_nxt = 4'b0000;
        end

        if((ch_nxt == 2'b00) || ((ch_nxt == 2'b01) && SW0) || ((ch_nxt == 2'b10) && SW1) || ((ch_nxt == 2'b11) && SW0 && SW1)) begin
            channel_nxt = ch_nxt;
        end else begin
            ch_nxt = channel_nxt;
        end

        if(add && !check_add_nxt) begin
            if(channel_nxt == 2'b00) begin
                if(SW0) begin
                    ch_nxt = 2'b01;
                end else if(SW1) begin
                    ch_nxt = 2'b10;
                end
            end else if(channel_nxt == 2'b01) begin
                if(SW1) begin
                    ch_nxt = 2'b10;
                end else begin
                    ch_nxt = 2'b00;
                end
            end else if(channel_nxt == 2'b10) begin
                if(SW0 && SW1) begin
                    ch_nxt = 2'b11;
                end else begin
                    ch_nxt = 2'b00;
                end
            end else begin
                ch_nxt = 2'b00;
            end
            check_add_nxt = 1'b1;            
        end else if(!add) begin
            check_add_nxt = 1'b0;
        end

        if((channel_ff == 2'b01 && !SW0) || (channel_ff == 2'b10 && !SW1) || (channel_ff == 2'b11 && (!SW0 || !SW1))) begin
            ch_nxt = 2'b00;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            channel_ff <= 2'b00;
            ch_ff <= 2'b00;
            count_ff <= 1'b0;
            ack_ff <= 1'b0;
            data_out_ff <= 4'b0000;
            data_out_valid_ff <= 1'b0;
            check_add_ff <= 1'b0;
        end else begin
            ch_ff <= ch_nxt;
            channel_ff <= channel_nxt;
            count_ff <= count_nxt;
            ack_ff <= ack_nxt;
            data_out_ff <= data_out_nxt;
            data_out_valid_ff <= data_out_valid_nxt;
            check_add_ff <= check_add_nxt;
        end
    end
endmodule


// end else begin
