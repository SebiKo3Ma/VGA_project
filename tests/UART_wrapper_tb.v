`timescale 1ns/1ns
module wrapper_tb();
    reg[3:0] data, address;
    reg valid, clk, rst, Rx;

    wire frame_valid, ack;
    wire[8:0] frame;

    UART_module uart_module(.clk_16bd(clk), .rst(rst), .Rx(Rx), .valid(valid), .data(data), .address(address), .ack(ack), .frame_valid(frame_valid), .frame(frame));

    initial begin
    clk = 0;
    forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #20 rst = 1'b0;
        #45

        data = 4'b0000;
        address = 4'b1001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b0001;
        address = 4'b1001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b0001;
        address = 4'b1010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b0001;
        address = 4'b1011;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 rst = 1'b1;
        #20 rst = 1'b0;

        #45 data = 4'b0110;
        address = 4'b1100;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 rst = 1'b1;
        #20 rst = 1'b0;

        #40 Rx = 1'b0; //start bit

        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b0;
        #160 Rx = 1'b1;
        #160 Rx = 1'b1;

        #160 Rx = 1'b1; //parity bit
        #160 Rx = 1'b1; //stop bit

    end


endmodule