`timescale 1ns/1ns
module top(input clk, rst, Rx, output[8:0] frame, output frame_valid);
    wire clk_16bd, clk_bd, ack;

    reg[2:0] baud = 2'b01;
    reg baud_ready = 1'b1;

    clock_handler clock_handler(baud, clk, baud_ready, rst, clk_16bd, clk_bd);
    UART_module uart_module(clk_16bd, rst, Rx, 1'b0, 4'b0000, 4'b0000, ack, frame_valid, frame);
endmodule