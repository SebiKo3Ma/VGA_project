`timescale 1ns/1ns
module tb_top();
    reg clk, rst, Rx;
    wire [8:0] frame;
    wire frame_valid;

    top uart_processor(clk, rst, Rx, frame, frame_valid);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #300000 rst = 1'b0;

        #30000 Rx = 1'b0; //start bit

        #104200 Rx = 1'b1;
        #104200 Rx = 1'b0;
        #104200 Rx = 1'b1;
        #104200 Rx = 1'b0;
        #104200 Rx = 1'b0;
        #104200 Rx = 1'b1;
        #104200 Rx = 1'b1;
        #104200 Rx = 1'b1;

        #104200 Rx = 1'b1; //parity bit
        #104200 Rx = 1'b1; //stop bit
    end

endmodule