`timescale 1ns/1ns
module tb_7seg_ctrl();
    reg clk, rst;
    reg[7:0][3:0] digit;
    reg[7:0] en_dot;

    wire[7:0] pos, segments;

    seven_segment_controller ctrl7(clk, rst, digit, en_dot, pos, segments);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        en_dot = 8'b00000000;
        digit[0] = 4'b1111;
        digit[1] = 4'b1111;
        digit[2] = 4'b1111;
        digit[3] = 4'b1111;
        digit[4] = 4'b1111;
        digit[5] = 4'b1111;
        digit[6] = 4'b1111;
        digit[7] = 4'b1111;
        #100 rst = 1'b0;

        #100 digit[7] = 4'b0101;
        #100 digit[0] = 4'b0000;
        #100 digit[4] = 4'b1001;

        
    end
endmodule