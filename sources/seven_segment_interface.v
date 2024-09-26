`timescale 1ns/1ns
module seven_segment_interface(input clk, rst, en_7s_frame, frame_valid, input[8:0] frame, input[1:0] channel, output[7:0][3:0] digit, output[7:0] en_dot);
    reg[7:0][3:0] digit_ff, digit_nxt;
    reg[7:0] en_dot_ff, en_dot_nxt;
    reg[7:0] frame_ff, frame_nxt;

    assign digit = digit_ff;
    assign en_dot = en_dot_ff;

    always @* begin
        digit_nxt = digit_ff;
        en_dot_nxt = en_dot_ff;

        if(frame_valid) begin
                frame_nxt = frame[7:0];
            end

        if(!en_7s_frame) begin
            digit_nxt[0] = channel;
        end else begin
            digit_nxt[0] = frame_nxt[0];
            digit_nxt[1] = frame_nxt[1];
            digit_nxt[2] = frame_nxt[2];
            digit_nxt[3] = frame_nxt[3];
            digit_nxt[4] = frame_nxt[4];
            digit_nxt[5] = frame_nxt[5];
            digit_nxt[6] = frame_nxt[6];
            digit_nxt[7] = frame_nxt[7];
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_ff[0] <= 4'b0000;
            digit_ff[1] <= 4'b0000;
            digit_ff[2] <= 4'b0000;
            digit_ff[3] <= 4'b0000;
            digit_ff[4] <= 4'b0000;
            digit_ff[5] <= 4'b0000;
            digit_ff[6] <= 4'b0000;
            digit_ff[7] <= 4'b0000;
            en_dot_ff <= 8'b00000000;
        end else begin
            digit_ff <= digit_nxt;
            en_dot_ff <= en_dot_nxt;
        end
    end 
endmodule