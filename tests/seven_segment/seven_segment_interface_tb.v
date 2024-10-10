`timescale 1ns/1ns
module tb_7seg_int();
    reg clk, rst, en_7s_frame, frame_valid, debug_color, fault;
    reg[23:0] rgb0, rgb1, rgb2, rgb3;
    reg[8:0] frame;
    reg[1:0] channel;
    wire[31:0] digit;
    wire[7:0] en_dot, en_digit;

    seven_segment_interface int7(clk, rst, en_7s_frame, debug_color, fault, frame_valid, frame, channel, rgb0, rgb1, rgb2, rgb3, digit, en_dot, en_digit);

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
        rgb0 = 24'b111111110000000000000000; //red
        rgb1 = 24'b000000001111111100000000; //green
        rgb2 = 24'b000000000000000011111111; //blue
        rgb3 = 24'b111111111111111100000000; //yellow
        fault = 1'b0;
        debug_color = 1'b0;
        #100 rst = 1'b0;

        #100
        frame = 9'b010011001;
        frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

        #100
        channel = 2'b11;
        #100

        en_7s_frame = 1'b1;
        #100
        en_7s_frame = 1'b0;
        #20 fault = 1'b1;
        #100 debug_color = 1'b1;
        #100 fault = 1'b0;
    end
endmodule