`timescale 1ns/1ns
module vga_interface(input clk, rst, input[23:0] ch0, ch1, ch2, ch3, input[3:0] resolution, input[10:0] px_h, px_v, output [11:0] px_12bit_data, output [23:0] px_24bit_data);
    reg[11:0] px_12_ff, px_12_nxt;
    reg[23:0] px_24_ff, px_24_nxt;

    assign px_12bit_data = px_12_ff;
    assign px_24bit_data = px_24_ff;

    reg[10:0] hmax_ff, hmax_nxt, vmax_ff, vmax_nxt;

    always @* begin
        px_12_nxt = px_12_ff;
        px_24_nxt = px_12_ff;
        hmax_nxt = hmax_ff;
        vmax_nxt = vmax_ff;

        case(resolution)
            4'b0000 : begin //640 x 480
                hmax_nxt = 11'd320;
                vmax_nxt = 11'd240;
            end

            4'b0001 : begin //800 x 600 
                hmax_nxt = 11'd400;
                vmax_nxt = 11'd300;
            end

            4'b0010 : begin //1024 x 768
                hmax_nxt = 11'd512;
                vmax_nxt = 11'd384;
            end

            4'b0011 : begin //1152 x 864 
                hmax_nxt = 11'd576;
                vmax_nxt = 11'd432;
            end

            4'b0100 : begin //1280 x 720
                hmax_nxt = 11'd640;
                vmax_nxt = 11'd360;
            end

            4'b0101 : begin //1280 x 800 
                hmax_nxt = 11'd640;
                vmax_nxt = 11'd400;
            end

            4'b0110 : begin //1280 x 1024
                hmax_nxt = 11'd640;
                vmax_nxt = 11'd512;
            end

            4'b0111 : begin //1400 x 1050
                hmax_nxt = 11'd700;
                vmax_nxt = 11'd525;
            end

            4'b1000 : begin //1400 x 900 
                hmax_nxt = 11'd700;
                vmax_nxt = 11'd450;
            end

            4'b1001 : begin //1600 x 900 
                hmax_nxt = 11'd800;
                vmax_nxt = 11'd450;
            end

            4'b1010 : begin //1680 x 1050
                hmax_nxt = 11'd840;
                vmax_nxt = 11'd525;
            end

            4'b1011 : begin //1920 x 1080
                hmax_nxt = 11'd960;
                vmax_nxt = 11'd540;
            end

            default : begin
                vmax_nxt = 11'd240;
                hmax_nxt = 11'd320;
            end
        endcase

        if(px_v < vmax_ff) begin
            if(px_h < hmax_ff) begin
                px_24_nxt = ch0;
                px_12_nxt[11:8] = ch0[23:20];
                px_12_nxt[7:4] = ch0[15:12];
                px_12_nxt[3:0] = ch0[7:4];
            end else begin
                px_24_nxt = ch1;
                px_12_nxt[11:8] = ch1[23:20];
                px_12_nxt[7:4] = ch1[15:12];
                px_12_nxt[3:0] = ch1[7:4];
            end
        end else begin
            if(px_h < hmax_ff) begin
                px_24_nxt = ch2;
                px_12_nxt[11:8] = ch2[23:20];
                px_12_nxt[7:4] = ch2[15:12];
                px_12_nxt[3:0] = ch2[7:4];
            end else begin
                px_24_nxt = ch1;
                px_12_nxt[11:8] = ch3[23:20];
                px_12_nxt[7:4] = ch3[15:12];
                px_12_nxt[3:0] = ch3[7:4];
            end
        end

    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            px_12_ff <= 12'd0;
            px_24_ff <= 24'd0;
            hmax_nxt <= 320;
            vmax_nxt <= 240;
        end else begin
            px_12_ff <= px_12_nxt;
            px_24_ff <= px_24_nxt;
            hmax_ff <= hmax_nxt;
            vmax_ff <= vmax_nxt;
        end
    end       
    endmodule