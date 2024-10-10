module seven_segment_controller(input clk_8KHz, rst, input[31:0] digit, input[7:0] en_dot, en_digit, output [7:0] pos, segments);
    reg[7:0] segments_ff, segments_nxt, pos_ff, pos_nxt;
    reg[2:0] count_ff, count_nxt;

    assign pos = pos_ff;
    assign segments = segments_ff;

    function [7:0] convert;
        input[3:0] digit;
        input dot;
        begin
            case(digit)
            //digit 0
                4'b0000 : begin
                    if(dot) begin
                        convert =  8'b00000010;
                    end else begin
                        convert =  8'b00000011;
                    end
                end

            //digit 1
                4'b0001 : begin
                    if(dot) begin
                        convert =  8'b10011110;
                    end else begin
                        convert =  8'b10011111;
                    end
                end

            //digit 2
                4'b0010 : begin
                    if(dot) begin
                        convert =  8'b00100100;
                    end else begin
                        convert =  8'b00100101;
                    end
                end

            //digit 3
                4'b0011 : begin
                    if(dot) begin
                        convert =  8'b00001100;
                    end else begin
                        convert =  8'b00001101;
                    end
                end

            //digit 4
                4'b0100 : begin
                    if(dot) begin
                        convert =  8'b10011000;
                    end else begin
                        convert =  8'b10011001;
                    end
                end

            //digit 5
                4'b0101 : begin
                    if(dot) begin
                        convert =  8'b01001000;
                    end else begin
                        convert =  8'b01001001;
                    end
                end

            //digit 6
                4'b0110 : begin
                    if(dot) begin
                        convert =  8'b01000000;
                    end else begin
                        convert =  8'b01000001;
                    end
                end

            //digit 7
                4'b0111 : begin
                    if(dot) begin
                        convert =  8'b00011110;
                    end else begin
                        convert =  8'b00011111;
                    end
                end

            //digit 8
                4'b1000 : begin
                    if(dot) begin
                        convert =  8'b00000000;
                    end else begin
                        convert =  8'b00000001;
                    end
                end

            //digit 9
                4'b1001 : begin
                    if(dot) begin
                        convert =  8'b00001000;
                    end else begin
                        convert =  8'b00001001;
                    end
                end

            //digit A
                4'b1010 : begin
                    if(dot) begin
                        convert =  8'b00010000;
                    end else begin
                        convert =  8'b00010001;
                    end
                end

            //digit B
                4'b1011 : begin
                    if(dot) begin
                        convert =  8'b11000000;
                    end else begin
                        convert =  8'b11000001;
                    end
                end

            //digit C
                4'b1001 : begin
                    if(dot) begin
                        convert =  8'b01100010;
                    end else begin
                        convert =  8'b01100011;
                    end
                end

            //digit D
                4'b1001 : begin
                    if(dot) begin
                        convert =  8'b10000100;
                    end else begin
                        convert =  8'b10000101;
                    end
                end

            //digit E
                4'b1001 : begin
                    if(dot) begin
                        convert =  8'b01100000;
                    end else begin
                        convert =  8'b01100001;
                    end
                end

            //digit F
                4'b1001 : begin
                    if(dot) begin
                        convert =  8'b01110000;
                    end else begin
                        convert =  8'b01110001;
                    end
                end

                default : convert = 8'b11111111;
            endcase
        end
    endfunction 

    always @* begin
        pos_nxt = pos_ff;
        segments_nxt = segments_ff;
        count_nxt = count_ff + 1;

        case(count_nxt)
            3'b000: begin 
                pos_nxt = 8'b11111110;
                if(en_digit[0]) begin
                    segments_nxt = convert(digit[3:0], en_dot[0]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b001: begin 
                pos_nxt = 8'b11111101;
                if(en_digit[1]) begin
                    segments_nxt = convert(digit[7:4], en_dot[1]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b010: begin 
                pos_nxt = 8'b11111011;
                if(en_digit[2]) begin
                    segments_nxt = convert(digit[11:8], en_dot[2]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b011: begin 
                pos_nxt = 8'b11110111;
                if(en_digit[3]) begin
                    segments_nxt = convert(digit[15:12], en_dot[3]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b100: begin 
                pos_nxt = 8'b11101111;
                if(en_digit[4]) begin
                    segments_nxt = convert(digit[19:16], en_dot[4]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b101: begin 
                pos_nxt = 8'b11011111;
                if(en_digit[5]) begin
                    segments_nxt = convert(digit[23:20], en_dot[5]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b110: begin 
                pos_nxt = 8'b10111111;
                if(en_digit[6]) begin
                    segments_nxt = convert(digit[27:24], en_dot[6]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end

            3'b111: begin 
                pos_nxt = 8'b01111111;
                if(en_digit[7]) begin
                    segments_nxt = convert(digit[31:28], en_dot[7]);
                end else begin
                    segments_nxt = 8'b11111111;
                end
            end
        endcase
    end

    always @(posedge clk_8KHz or posedge rst) begin
        if(rst) begin
            segments_ff <= 8'b11111111;
            pos_ff <= 8'b11111111;
            count_ff <= 4'b0000;
        end else begin
            segments_ff <= segments_nxt;
            pos_ff <= pos_nxt;
            count_ff <= count_nxt;
        end

    end
endmodule