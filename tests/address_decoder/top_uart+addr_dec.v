module top(input clk, rst, Rx, debug, output[8:0] debug_frame, output[3:0] debug_reg);
    wire clk_16bd, ack, ack_clk, ack_uart, valid;
    wire[3:0] data, address, data_out, data_out_clk, data_out_uart;
    wire data_out_valid, data_out_valid_clk, data_out_valid_uart;
    wire[8:0] frame;

    or2_1b or_ack(ack_clk, ack_uart, ack);
    or2_1b or_data_out_valid(data_out_valid_clk, data_out_valid_uart, data_out_valid);
    or2_4b or_data_out(data_out_clk, data_out_uart, data_out);

    clock_handler_module clock_handler_module(clk, rst, address, data, valid, ack_clk, data_out_clk, data_out_valid_clk, clk_16bd);
    UART_module uart_module(clk_16bd, rst, Rx, valid, data, address, ack_uart, data_out_valid_uart, frame_valid, frame, data_out_uart);
    address_decoder address_decoder(clk, rst, frame[7:0], frame_valid, ack, data, address, valid);
    debug_interface debug_interface(clk, rst, debug, frame_valid, data_out_valid, frame, data_out, debug_frame, debug_reg);
endmodule