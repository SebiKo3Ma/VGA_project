module top(input clk, rst, Rx, SW0, SW1, BTNC, BTNR, BTNU, BTNL, debug, en_7s_frame, debug_color, debug_clr_reg, output[8:0] debug_frame, output[3:0] debug_reg, output[1:0] debug_ch, output[7:0] pos, output[7:0] segments);
    wire clk_16bd, clk_8KHz, ack, ack_clk, ack_uart, ack_ch, ack_clr, valid, add, swap_h, swap_v, color_next, fault;
    wire[3:0] data, address, data_out, data_out_clk, data_out_uart, data_out_ch;
    wire data_out_valid, data_out_valid_clk, data_out_valid_uart, data_out_valid_ch;
    wire[8:0] frame;
    wire[1:0] channel;
    wire[31:0] digit;
    wire[7:0] en_dot, en_digit;

    //wire[10:0] px_h, px_v;
   // wire[11:0] px_12bit_data;
    wire[23:0] rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3;


    or4_1b or_ack(ack_clk, ack_uart, ack_ch, ack_clr, ack);
    or3_1b or_data_out_valid(data_out_valid_clk, data_out_valid_uart, data_out_valid_ch, data_out_valid);
    or3_4b or_data_out(data_out_clk, data_out_uart, data_out_ch, data_out);

    clock_handler_module clock_handler_module(clk, rst, address, data, valid, ack_clk, data_out_clk, data_out_valid_clk, clk_16bd, clk_8KHz);
    UART_module uart_module(clk_16bd, clk, rst, Rx, valid, data, address, ack_uart, data_out_valid_uart, frame_valid, frame, data_out_uart);
    address_decoder address_decoder(clk, rst, frame[7:0], frame_valid, ack, data, address, valid, fault);
    debug_interface debug_interface(clk, rst, debug, frame_valid, data_out_valid, channel, frame, data_out, debug_frame, debug_reg, debug_ch);
    debouncer dbc3(clk, rst, BTNC, add);
    channel_processor channel_processor(clk, rst, SW0, SW1, add, address, data, valid, ack_ch, data_out_ch, data_out_valid_ch, channel);
    seven_segment_interface int7(clk, rst, en_7s_frame, debug_color, debug_clr_reg, fault, frame_valid, frame, channel, rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3, digit, en_dot, en_digit);
    seven_segment_controller ctrl7(clk_8KHz, rst, digit, en_dot, en_digit, pos, segments);
    debouncer dbc0(clk, rst, BTNR, color_next);
    debouncer dbc1(clk, rst, BTNU, swap_v);
    debouncer dbc2(clk, rst, BTNL, swap_h);
    color_processor_wrapper clr_pw(clk, rst, swap_h, swap_v, color_next, SW0, SW1, 
        channel, address, data, valid, ack_clr, rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3);

endmodule