`timescale 1ns/1ns
module seven_segment_interface(input clk, rst, en_7s_frame, debug_color, debug_clr_reg, fault, frame_valid, input[8:0] frame, input[1:0] channel, input[23:0]rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3, output[31:0] digit, output[7:0] en_dot, en_digit);
    reg[31:0] digit_ff, digit_nxt;
    reg[7:0] en_dot_ff, en_dot_nxt, en_digit_ff, en_digit_nxt;
    reg[7:0] frame_ff, frame_nxt;
    reg frame_check_ff, frame_check_nxt;

    assign digit = digit_ff;
    assign en_dot = en_dot_ff;
    assign en_digit = en_digit_ff;

    always @* begin
        digit_nxt = digit_ff;
        en_dot_nxt = en_dot_ff;
        en_digit_nxt = en_digit_ff;
        frame_nxt = frame_ff;
        frame_check_nxt = frame_check_ff;

        if(frame_valid) begin
            frame_nxt = frame[7:0];
            frame_check_nxt = 1'b1;
        end

        if(!en_7s_frame) begin
            digit_nxt[1:0] = channel;
            if(debug_color) begin
                en_digit_nxt = 8'b11111101;
                digit_nxt[7:2] = 6'b000000;
                if(debug_clr_reg) begin
                    case(channel)
                        2'b00 : digit_nxt[31:8] = ch0;
                        2'b01 : digit_nxt[31:8] = ch1;
                        2'b10 : digit_nxt[31:8] = ch2;
                        2'b11 : digit_nxt[31:8] = ch3;
                        default : digit_nxt[31:8] = 24'b000000000000000000000000;
                    endcase
                end else begin
                    case(channel)
                        2'b00 : digit_nxt[31:8] = rgb0;
                        2'b01 : digit_nxt[31:8] = rgb1;
                        2'b10 : digit_nxt[31:8] = rgb2;
                        2'b11 : digit_nxt[31:8] = rgb3;
                        default : digit_nxt[31:8] = 24'b000000000000000000000000;
                    endcase
                end
            end else if(fault) begin
                en_digit_nxt = 8'b10000001;
                digit_nxt[31:2] = 30'b111100000000000000000000000000;
            end else begin
                en_digit_nxt = 8'b00000001;
                digit_nxt[31:2] = 30'b000000000000000000000000000000;
            end
        end else if(frame_check_nxt) begin
            en_digit_nxt = 8'b11111111;
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
            en_digit_ff <= 8'b00000000;
            frame_ff <= 9'b00000000;
            frame_check_ff <= 1'b0;
        end else begin
            digit_ff <= digit_nxt;
            en_dot_ff <= en_dot_nxt;
            en_digit_ff <= en_digit_nxt;
            frame_ff <= frame_nxt;
            frame_check_ff <= frame_check_nxt;
        end
    end 
endmodule