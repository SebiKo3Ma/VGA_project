module top(input clk, rst, Rx, output[8:0] frame, output frame_valid);
    wire clk_16bd, clk_bd, ack, valid;
    wire[3:0] data, address;

    reg[2:0] baud = 2'b01;
    reg baud_ready = 1'b1;

    clock_handler clock_handler(baud, clk, baud_ready, rst, clk_16bd, clk_bd);
    UART_module uart_module(clk_16bd, rst, Rx, valid, data, address, ack, frame_valid, frame);
    frame_decoder frame_decoder(clk, rst, frame[7:0], frame_valid, ack, data, address, valid);
endmodule