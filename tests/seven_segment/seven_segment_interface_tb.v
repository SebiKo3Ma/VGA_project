`timescale 1ns/1ns
module tb_7seg_int();
    reg clk, rst, en_7s_frame, frame_valid;
    reg[8:0] frame;
    reg[1:0] channel;
    wire[7:0][3:0] digit;
    wire[7:0] en_dot;

    seven_segment_interface int7(clk, rst, en_7s_frame, frame_valid, frame, channel, digit, en_dot);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        en_7s_frame = 1'b0;
        frame_valid = 1'b0;
        frame = 9'b000000000;
        channel = 2'b00;
        #100 rst = 1'b0;

        #100
        frame = 9'b010011001;
        frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

        #100
        channel = 2'b11;
        #100

        en_7s_frame = 1'b1;
    end
endmodule