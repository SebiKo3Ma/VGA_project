`timescale 1ns/1ns
module top(input clk, rst, Rx, output[8:0] frame, output frame_valid);
    wire clk_16bd, clk_bd;

    reg[2:0] baud = 2'b01;
    reg baud_ready = 1'b1;

    clock_handler clock_handler(baud, clk, baud_ready, rst, clk_16bd, clk_bd);
    UART_processor uart_processor(clk_16bd, rst, Rx, 1'b1, 1'b0, 1'b0, 4'b1001, frame, frame_valid);
endmodule