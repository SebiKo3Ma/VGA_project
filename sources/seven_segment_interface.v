`timescale 1ns/1ns
module seven_segment_interface(input clk, rst, en_7s_frame, frame_valid, input[8:0] frame, input[1:0] channel, output[31:0] digit, output[7:0] en_dot);
    reg[31:0] digit_ff, digit_nxt;
    reg[7:0] en_dot_ff, en_dot_nxt;
    reg[7:0] frame_ff, frame_nxt;
    reg frame_check_ff, frame_check_nxt;

    assign digit = digit_ff;
    assign en_dot = en_dot_ff;

    always @* begin
        digit_nxt = digit_ff;
        en_dot_nxt = en_dot_ff;
        frame_nxt = frame_ff;
        frame_check_nxt = frame_check_ff;

        if(frame_valid) begin
            frame_nxt = frame[7:0];
            frame_check_nxt = 1'b1;
        end

        if(!en_7s_frame) begin
            digit_nxt[1:0] = channel;
            digit_nxt[31:2] = 30'b111111111111111111111111111100;
        end else if(frame_check_nxt) begin
            digit_nxt[3:0] = frame_nxt[0];
            digit_nxt[7:4] = frame_nxt[1];
            digit_nxt[11:8] = frame_nxt[2];
            digit_nxt[15:12] = frame_nxt[3];
            digit_nxt[19:16] = frame_nxt[4];
            digit_nxt[23:20] = frame_nxt[5];
            digit_nxt[27:24] = frame_nxt[6];
            digit_nxt[31:28] = frame_nxt[7];
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_ff <= 32'b11111111111111111111111111111111;
            en_dot_ff <= 8'b00000000;
            frame_ff <= 9'b00000000;
            frame_check_ff <= 1'b0;
        end else begin
            digit_ff <= digit_nxt;
            en_dot_ff <= en_dot_nxt;
            frame_ff <= frame_nxt;
            frame_check_ff <= frame_check_nxt;
        end
    end 
endmodule