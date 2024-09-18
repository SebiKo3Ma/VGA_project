`timescale 1ns/1ns
module tb_top();
    reg clk, rst, debug, Rx;
    wire [8:0] debug_frame;
    wire[3:0] debug_reg;

    top uart_processor_decoder(clk, rst, Rx, debug, debug_frame, debug_reg);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #300 rst = 1'b0;
        debug = 1'b1;

        //turn off parity
        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        //read parity register
        #2000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;

        #320 Rx = 1'b1; //stop bit

        //random frame
        #2000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //stop bit

        //parity on
        #6000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;

        #320 Rx = 1'b1; //stop bit

        //read parity register
        #6000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;

        #320 Rx = 1'b0;
        #320 Rx = 1'b1; //stop bit

        //read frame_length register
        #6000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit
    end

endmodule