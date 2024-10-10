`timescale 1ns/1ns
module tb_7seg_ctrl();
    reg clk, rst;
    reg[31:0] digit;
    reg[7:0] en_dot, en_digit;

    wire[7:0] pos, segments;

    seven_segment_controller ctrl7(clk, rst, digit, en_dot, en_digit, pos, segments);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        en_dot = 8'b00000000;
        en_digit = 8'b11111111;
        digit[3:0] = 4'b1111;
        digit[7:4] = 4'b1111;
        digit[11:8] = 4'b1111;
        digit[15:12] = 4'b1111;
        digit[19:16] = 4'b1111;
        digit[23:20] = 4'b1111;
        digit[27:24] = 4'b1111;
        digit[31:28] = 4'b1111;
        #100 rst = 1'b0;

        #100 digit[31:28] = 4'b0101;
        #100 digit[3:0] = 4'b0000;
        #100 digit[19:16] = 4'b1001;

        
    end
endmodule