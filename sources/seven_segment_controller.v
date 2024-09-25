module seven_segment_controller(input clk, rst, input[1:0] channel, output [7:0] pos, segments);
    reg[7:0] segments_ff, segments_nxt, pos_ff, pos_nxt;

    assign pos = pos_ff;
    assign segments = segments_ff;

    always @* begin
        pos_nxt = pos_ff;
        segments_nxt = segments_ff;
        
        if(channel == 2'b00) begin
            segments_nxt = 8'b00000011;
            pos_nxt = 8'b11111110;
        end else if(channel == 2'b01) begin
            segments_nxt = 8'b10011111;
            pos_nxt = 8'b11111110; 
        end else if(channel == 2'b10) begin
            segments_nxt = 8'b00100101;
            pos_nxt = 8'b11111110; 
        end else if(channel == 2'b11) begin
            segments_nxt = 8'b00001101;
            pos_nxt = 8'b11111110; 
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            segments_ff <= 8'b11111111;
            pos_ff <= 8'b11111111;
        end else begin
            segments_ff <= segments_nxt;
            pos_ff <= pos_nxt;
        end

    end
endmodule