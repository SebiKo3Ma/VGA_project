`timescale 1ns/1ns
module tb_top_aux_modules();
    reg clk, rst, debug, Rx, SW0, SW1, BTNC;
    wire [8:0] debug_frame;
    wire[3:0] debug_reg;
    wire[1:0] debug_ch;
    wire[7:0] pos, segments;

    top aux_modules(clk, rst, Rx, SW0, SW1, BTNC, debug, debug_frame, debug_reg, debug_ch, pos, segments);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        SW0 = 1'b0;
        SW1 = 1'b0;
        BTNC = 1'b0;
        #300 rst = 1'b0;
        debug = 1'b1;

        #1000 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #500 SW0 = 1'b1;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 SW0 = 1'b0;

        #100 SW0 = 1'b1;
        #2 SW1 = 1'b1;

        #300 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #200 SW1 = 1'b0;
        #300 SW1 = 1'b1;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #200 SW0 = 1'b0;
        #200 SW0 = 1'b1;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 SW1 = 1'b0;
    end

endmodule