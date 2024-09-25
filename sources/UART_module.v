module UART_module(input clk_16bd, clk, rst, Rx, valid, input[3:0] data, address, output ack, data_out_valid, frame_valid, output[8:0] frame, output[3:0] data_out);

    wire parity, parity_type, stop_bits;
    wire[3:0] frame_length;

    UART_processor UART(clk_16bd, rst, Rx, parity, parity_type, stop_bits, frame_length, frame, frame_valid);
    uart_regfile uart_regfile(clk, rst, valid, data, address, ack, data_out_valid, parity, parity_type, stop_bits, frame_length, data_out);
endmodule