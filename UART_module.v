module UART_module(input clk_16bd, rst, Rx, valid, input[3:0] data, address, output ack, frame_valid, output[8:0] frame);

    wire parity, parity_type, stop_bits;
    wire[3:0] frame_length;

    UART_processor UART(.clk_16bd(clk_16bd), .rst(rst), .Rx(Rx), .parity(parity), .parity_type(parity_type), .stop_bits(stop_bits), .frame_length(frame_length), .frame(frame), .frame_valid(frame_valid));
    uart_regfile uart_regfile(.clk_16bd(clk_16bd), .rst(rst), .valid(valid), .data(data), .address(address), .ack(ack), .parity(parity), .parity_type(parity_type), .stop_bits(stop_bits), .frame_length(frame_length));
endmodule