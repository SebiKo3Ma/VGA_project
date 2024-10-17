`timescale 1ns/1ns
module clock_handler(input clk, rst, input[2:0] baud, input[3:0] px_ratio_pos, output clk_16bd, clk_8KHz, px_clk);
    reg [14:0] baud_ratio [4:0], px_ratio;
    wire [14:0] baudRatio16;
    
    assign baudRatio16 = baud_ratio[baud] >> 4;
    clk_divider #(27) clk_div_16bd(clk, rst, 1'b1, baudRatio16, clk_16bd);
    clk_divider #(27) clk_div_8KHz(clk, rst, 1'b1, 15'd12500, clk_8KHz);
    clk_divider #(27) clk_div_px_clk(clk, rst, 1'b1, px_ratio, px_clk);
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            baud_ratio[0] <= 15'd20833;
            baud_ratio[1] <= 15'd32; //10417 //32
            baud_ratio[2] <= 15'd48; //5208 //48
            baud_ratio[3] <= 15'd1736;
            baud_ratio[4] <= 15'd868;
            px_ratio <= 15'd4;
        end else begin
            case(px_ratio_pos)
                4'b0000 : px_ratio <= 15'd4;
                4'b0001 : px_ratio <= 15'd2;
                default : px_ratio <= 15'd4;
            endcase

        end
    end
endmodule