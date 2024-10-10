`timescale 1ns/1ns
module color_processor_wrapper(input clk, rst, swap_h, swap_v, color_next, SW0, SW1, input[1:0] channel, input[3:0] resolution, address, data, input valid, output ack, input[10:0] px_h, px_v, output [11:0] px_12bit_data, output [23:0] px_24bit_data, rgb0, rgb1, rgb2, rgb3);
    wire[23:0] ch0, ch1, ch2, ch3;
    wire color_valid;
    color_processor color_processor(clk, rst, SW0, SW1, swap_h, swap_v, color_valid, rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3);
    color_regfile color_regfile(clk, rst, color_next, channel, data, address, valid, ack, color_valid, rgb0, rgb1, rgb2, rgb3);
    vga_interface vga_interface(clk, rst, ch0, ch1, ch2, ch3, resolution, px_h, px_v, px_12bit_data, px_24bit_data);
endmodule