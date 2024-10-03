`timescale 1ns/1ns
module vga_interface(input clk, rst, input[23:0] ch0, ch1, ch2, ch3, input[3:0] resolution, input[10:0] px_h, px_v, output [11:0] px_12bit_data, output [23:0] px_24bit_data);
    reg[11:0] px_12_ff, px_12_nxt;
    reg[23:0] px_24_ff, px_24_nxt;

    assign px_12bit_data = px_12_ff;
    assign px_24bit_data = px_24_ff;

    always @* begin
        px_12_nxt = px_12_ff;
        px_24_nxt = px_12_ff;

        case(resolution)
            4'b0000 : begin //640 x 480
                if(px_v < 240) begin
                    if(px_h < 320) begin
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
                    if(px_h < 320) begin
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

            default : begin
            end
        endcase

    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            px_12_ff <= 12'd0;
            px_24_ff <= 24'd0;
        end else begin
            px_12_ff <= px_12_nxt;
            px_24_ff <= px_24_nxt;
        end
    end       
    endmodule