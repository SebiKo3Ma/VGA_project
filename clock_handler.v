`timescale 1ns/1ns
module clock_handler(input [2:0] baud, input clk, baud_ready, rst, output clk_16bd, clk_bd);
    reg [14:0] baud_ratio [4:0];
    wire [14:0] baudRatio16;
    reg[2:0] baud_pos, baud_pos_next;
    
    assign baudRatio16 = baud_ratio[baud_pos] >> 4;
    clk_divider #(27) clk_module_16bd(clk, rst, 1'b1, baudRatio16, clk_16bd);
    clk_divider #(27) clk_module_bd(clk, rst, 1'b1, baud_ratio[baud_pos], clk_bd);

    always @(*) begin
        if(baud_ready) begin
            baud_pos_next = baud;
        end 
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            baud_ratio[0] <= 15'd20833;
            baud_ratio[1] <= 15'd32;
            baud_ratio[2] <= 15'd48;
            baud_ratio[3] <= 15'd1736;
            baud_ratio[4] <= 15'd868;
        end else begin
            baud_pos <= baud_pos_next;
        end
    end
endmodule