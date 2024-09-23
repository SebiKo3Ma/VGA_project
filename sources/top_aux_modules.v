module top(input clk, rst, Rx, SW0, SW1, BTNC, debug, output[8:0] debug_frame, output[3:0] debug_reg);
    wire clk_16bd, ack, ack_clk, ack_uart, ack_ch, valid, add;
    wire[3:0] data, address, data_out, data_out_clk, data_out_uart, data_out_ch;
    wire data_out_valid, data_out_valid_clk, data_out_valid_uart, data_out_valid_ch;
    wire[8:0] frame;
    wire[1:0] channel;

    or3_1b or_ack(ack_clk, ack_uart, ack_ch, ack);
    or3_1b or_data_out_valid(data_out_valid_clk, data_out_valid_uart, data_out_valid_ch, data_out_valid);
    or3_4b or_data_out(data_out_clk, data_out_uart, data_out_ch, data_out);

    clock_handler_module clock_handler_module(clk, rst, address, data, valid, ack_clk, data_out_clk, data_out_valid_clk, clk_16bd);
    UART_module uart_module(clk_16bd, rst, Rx, valid, data, address, ack_uart, data_out_valid_uart, frame_valid, frame, data_out_uart);
    address_decoder address_decoder(clk, rst, frame[7:0], frame_valid, ack, data, address, valid);
    debug_interface debug_interface(clk, rst, debug, frame_valid, data_out_valid, frame, data_out, debug_frame, debug_reg);
    debouncer dbc3(clk, rst, BTNC, add);
    channel_processor channel_processor(clk, rst, SW0, SW1, add, address, data, valid, ack_ch, data_out_ch, data_out_valid_ch, channel);
endmodule