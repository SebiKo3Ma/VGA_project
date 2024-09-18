module top(input clk, rst, Rx, debug, output[8:0] debug_frame, output[3:0] debug_reg);
    wire clk_16bd, ack, valid;
    wire[3:0] data, address, data_out;

    reg[2:0] baud = 2'b01;
    reg baud_ready = 1'b1;
    wire[8:0] frame;

    clock_handler clock_handler(baud, clk, baud_ready, rst, clk_16bd);
    UART_module uart_module(clk_16bd, rst, Rx, valid, data, address, ack, frame_valid, frame, data_out);
    address_decoder address_decoder(clk, rst, frame[7:0], frame_valid, ack, data, address, valid);
    debug_interface debug_interface(clk, rst, debug, frame_valid, frame, data_out, debug_frame, debug_reg);
endmodule