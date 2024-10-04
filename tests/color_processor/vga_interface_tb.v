`timescale 1ns/1ns
module tb_vga_int();
    reg clk, rst;
    reg[23:0] ch0, ch1, ch2, ch3;
    reg[3:0] resolution;
    reg[10:0] px_h, px_v;
    wire[11:0] px_12bit_data;
    wire[23:0] px_24bit_data;

    vga_interface vga_int(clk, rst, ch0, ch1, ch2, ch3, resolution, px_h, px_v, px_12bit_data, px_24bit_data);


    integer i, j;

    initial begin
        clk = 1'b0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        ch0 = 24'b111111110000000000000000;
        ch1 = 24'b000000001111111100000000;
        ch2 = 24'b000000000000000011111111;
        ch3 = 24'b111111110000000011111111;
        px_h = 11'd0;
        px_v = 11'd0;
        resolution = 4'b0101;
        #100 rst = 1'b0;
        
        #1000
        for(i = 0 ; i < 800 ; i = i + 1) begin
            for(j = 0 ; j < 1280 ; j = j + 1) begin
                px_v = i;
                px_h = j;
                #40;
            end
        end

    end
endmodule