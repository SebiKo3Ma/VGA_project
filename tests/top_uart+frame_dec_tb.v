`timescale 1ns/1ns
module tb_top();
    reg clk, rst, Rx;
    wire [8:0] frame;
    wire frame_valid;

    top uart_processor_decoder(clk, rst, Rx, frame, frame_valid);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #300 rst = 1'b0;

        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        #300 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //stop bit
    end

endmodule