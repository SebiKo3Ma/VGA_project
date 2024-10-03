`timescale 1ns/1ns
module color_regfile(input clk, rst, color_next, input[1:0] channel, input[3:0] data, address, input valid, output ack, output[23:0] rgb0, rgb1, rgb2, rgb3);
    reg[23:0] rgb0_ff, rgb0_nxt, rgb1_ff, rgb1_nxt, rgb2_ff, rgb2_nxt, rgb3_ff, rgb3_nxt;
    reg ack_ff, ack_nxt, color_next_check_ff, color_next_check_nxt, count_ff, count_nxt;
    reg[1:0] preset0_ff, preset0_nxt, preset1_ff, preset1_nxt, preset2_ff, preset2_nxt, preset3_ff, preset3_nxt;

    reg [23:0] preset [3:0];

    assign rgb0 = rgb0_ff;
    assign rgb1 = rgb1_ff;
    assign rgb2 = rgb2_ff;
    assign rgb3 = rgb3_ff;
    assign ack = ack_ff;

       always @* begin
        rgb0_nxt = rgb0_ff;
        rgb1_nxt = rgb1_ff;
        rgb2_nxt = rgb2_ff;
        rgb3_nxt = rgb3_ff;
        preset0_nxt = preset0_ff;
        preset1_nxt = preset1_ff;
        preset2_nxt = preset2_ff;
        preset3_nxt = preset3_ff;
        ack_nxt = ack_ff;
        count_nxt = count_ff;
        color_next_check_nxt = color_next_check_ff;

        if(valid && !count_ff) begin
            case(address)
                4'b0011: begin //RED MSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[23:20] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[23:20] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[23:20] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[23:20] = data;
                        end

                        default : begin
                        end
                    endcase

                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                4'b0100: begin //RED LSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[19:16] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[19:16] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[19:16] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[19:16] = data;
                        end

                        default : begin
                        end
                    endcase

                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                4'b0101: begin //GRN MSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[15:12] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[15:12] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[15:12] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[15:12] = data;
                        end

                        default : begin
                        end
                    endcase

                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                4'b0110: begin //GRN LSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[11:8] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[11:8] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[11:8] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[11:8] = data;
                        end

                        default : begin
                        end
                    endcase

                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                4'b0111: begin //BLU MSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[7:4] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[7:4] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[7:4] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[7:4] = data;
                        end

                        default : begin
                        end
                    endcase

                    ack_nxt = 1'b1;
                    count_nxt = 1'b1;
                end

                4'b1000: begin //BLU LSB
                    case(channel)
                        //channel 0
                        2'b00 : begin
                            rgb0_nxt[3:0] = data;
                        end
                        //channel 1
                        2'b01 : begin
                            rgb1_nxt[3:0] = data;
                        end
                        //channel 2
                        2'b10 : begin
                            rgb2_nxt[3:0] = data;
                        end
                        //channel 3
                        2'b11 : begin
                            rgb3_nxt[3:0] = data;
                        end

                        default : begin
                        end
                    endcase

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
        end

        if(color_next && !color_next_check_ff) begin
            case(channel)
                2'b00 : begin
                    if(preset0_ff == 2'b11) begin
                        rgb0_nxt = preset[0];
                        preset0_nxt = 2'b00;
                    end else begin
                        rgb0_nxt = preset[preset0_ff + 1];
                        preset0_nxt = preset0_ff + 1;
                    end
                end

                2'b01 : begin
                    if(preset1_ff == 2'b11) begin
                        rgb1_nxt = preset[0];
                        preset1_nxt = 2'b00;
                    end else begin
                        rgb1_nxt = preset[preset1_ff + 1];
                        preset1_nxt = preset1_ff + 1;
                    end
                end

                2'b10: begin
                    if(preset2_ff == 2'b11) begin
                        rgb2_nxt = preset[0];
                        preset2_nxt = 2'b00;
                    end else begin
                        rgb2_nxt = preset[preset2_ff + 1];
                        preset2_nxt = preset2_ff + 1;
                    end
                end

                2'b11 : begin
                    if(preset3_ff == 2'b11) begin
                        rgb3_nxt = preset[0];
                        preset3_nxt = 2'b00;
                    end else begin
                        rgb3_nxt = preset[preset3_ff + 1];
                        preset3_nxt = preset3_ff + 1;
                    end
                end

                default : begin
                end
            endcase

            color_next_check_nxt = 1'b1;
        end

        if(!color_next && color_next_check_ff) begin
            color_next_check_nxt = 1'b0;
        end

    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            preset[0] <= 24'b111111110000000000000000; //red
            preset[1] <= 24'b000000001111111100000000; //green
            preset[2] <= 24'b000000000000000011111111; //blue
            preset[3] <= 24'b111111111111111100000000; //yellow
            rgb0_ff <= preset[0];
            rgb1_ff <= preset[1];
            rgb2_ff <= preset[2];
            rgb3_ff <= preset[3];
            preset0_ff <= 2'b00;
            preset1_ff <= 2'b01;
            preset2_ff <= 2'b10;
            preset3_ff <= 2'b11;
            color_next_check_ff <= 1'b0;
            ack_ff <= 1'b0;
            count_ff <= 1'b0;
        end else begin
            rgb0_ff <= rgb0_nxt;
            rgb1_ff <= rgb1_nxt;
            rgb2_ff <= rgb2_nxt;
            rgb3_ff <= rgb3_nxt;
            preset0_ff <= preset0_nxt;
            preset1_ff <= preset1_nxt;
            preset2_ff <= preset2_nxt;
            preset3_ff <= preset3_nxt;
            color_next_check_ff <= color_next_check_nxt;
            ack_ff <= ack_nxt;
            count_ff <= count_nxt;
        end
    end 
endmodule