`timescale 1ns/1ns
module tb_top();
    reg clk, rst, baud_ready;
    reg [2:0] baud;
    wire clk_16bd, clk_bd;

    reg Rx, parity, parity_type, stop_bits;
    reg [3:0] frame_length;
    wire [8:0] frame;
    wire frame_valid;

    clock_handler clk_handler(.clk(clk), .baud(baud), .baud_ready(baud_ready), .rst(rst), .clk_16bd(clk_16bd), .clk_bd(clk_bd));
    UART_processor UART(.clk_16bd(clk), .rst(rst), .Rx(Rx), .parity(parity), .parity_type(parity_type), .stop_bits(stop_bits), .frame_length(frame_length), .frame(frame), .frame_valid(frame_valid));

    initial begin
    clk = 0;
    forever #10 clk = !clk;
    end
    
    initial begin
        baud_ready = 1'b0;
        #1 baud = 2'b01;
        baud_ready = 1'b1;
        rst = 1'b1;
        parity = 1;
        parity_type = 0;
        stop_bits = 1; 
        frame_length = 4'b1000;
        #3 rst = 1'b0;
        #4 Rx = 1'b0; //start bit

        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;

        #160 Rx = 1'b0; //parity bit
        #160 Rx = 1'b1; //stop bit

        #348 Rx = 1'b0; //start bit

        #160 Rx = 1'b1;
        #160 Rx = 1'b1;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b0;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;

        #160 Rx = 1'b0; //parity bit
        #160 Rx = 1'b1; //stop bit

    end
endmodule