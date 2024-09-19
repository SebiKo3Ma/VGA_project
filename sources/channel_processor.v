module channel_processor(input clk, rst, SW0, SW1, add, input[2:0] ch, output[1:0] channel);
    reg[1:0] channel_ff, channel_nxt;

    assign channel = channel_ff;

    always @* begin
        channel_nxt = channel_ff;

        if(!add) begin
            if(ch == 2'b00 or (ch == 2'b01 and SW0) or (ch == 2'b10 and SW1) or (ch == 2'b11 and SW0 and SW1)) begin
                channel_nxt = ch;
            end
        end else begin
            if(ch == 2'b00) begin
                if(SW0) begin
                    channel_nxt = 2'b01;
                end else if(SW1) begin
                    channel_nxt = 2'b10;
                end
            end else if(ch == 2'b01) begin
                if(SW1) begin
                    channel_nxt = 2'b10;
                end else begin
                    channel_nxt = 2'b00;
                end
            end else if(ch == 2'b10) begin
                if(SW0 and SW1) begin
                    channel_nxt = 2'b11;
                end else begin
                    channel_nxt = 2'b00;
                end
            end else begin
                channel_nxt = 2'b00;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            channel_ff <= 2'b00;
        end else begin
            channel_ff <= channel_nxt;
        end
    end
endmodule