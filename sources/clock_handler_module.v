`timescale 1ns/1ns
module clock_handler_module(input clk, rst, input[3:0] address, data, input valid, output ack, output[3:0] data_out, output data_out_valid, clk_16bd, clk_8KHz, px_clk);
    wire[2:0] baud;
    wire[3:0] px_ratio_pos;
    clock_handler clock_handler(clk, rst, baud, px_ratio_pos, clk_16bd, clk_8KHz, px_clk);
    clock_regfile clock_regfile(clk, rst, address, data, valid, ack, data_out, data_out_valid, baud, px_ratio_pos);
endmodule