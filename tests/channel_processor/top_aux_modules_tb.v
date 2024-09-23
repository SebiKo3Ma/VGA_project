`timescale 1ns/1ns
module tb_top_aux_modules();
    reg clk, rst, debug, Rx, SW0, SW1, BTNC;
    wire [8:0] debug_frame;
    wire[3:0] debug_reg;
    wire[1:0] debug_ch;

    top aux_modules(clk, rst, Rx, SW0, SW1, BTNC, debug, debug_frame, debug_reg, debug_ch);

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

        //channel 1
        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        #500 SW0 = 1'b1;

        #2000

        //channel 1
        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        //read channel
        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //parity bit
        #320 Rx = 1'b1; //stop bit

        #1000 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 SW1 = 1'b1;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;
    end

endmodule