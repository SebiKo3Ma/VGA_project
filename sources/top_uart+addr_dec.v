module top(input clk, rst, Rx, output[8:0] debug_frame);
    wire clk_16bd, ack, valid;
    wire[3:0] data, address;

    reg[2:0] baud = 2'b01;
    reg baud_ready = 1'b1;
    wire[8:0] frame_wire;

    clock_handler clock_handler(baud, clk, baud_ready, rst, clk_16bd);
    UART_module uart_module(clk_16bd, rst, Rx, valid, data, address, ack, frame_valid, frame_wire);
    address_decoder address_decoder(clk, rst, frame_wire[7:0], frame_valid, ack, data, address, valid);
    UART_debug_int uart_debug_int(clk, rst, frame_wire, frame_valid, debug_frame);
endmodule