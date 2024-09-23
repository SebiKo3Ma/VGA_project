`timescale 1ns/1ns
module tb_channel();
    reg clk, rst, SW0, SW1, valid, add;
    reg[3:0] data, address;

    wire ack, data_out_valid;
    wire[1:0] channel;
    wire[3:0] data_out;

    channel_processor chp(clk, rst, SW0, SW1, add, address, data, valid, ack, data_out, data_out_valid, channel);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        SW0 = 1'b0;
        SW1 = 1'b0;
        #10 rst = 1'b0;


        #45 data = 4'b0001;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #10 SW0 = 1'b1;

        #45 data = 4'b0001;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b0010;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #10 SW1 = 1'b1;

        #45 data = 4'b0010;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b1111;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #10 SW1 = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;


        #20 add = 1'b1;
        #10 add = 1'b0;

        #20 add = 1'b1;
        #10 add = 1'b0;

        #45 rst = 1'b1;
        #20 rst = 1'b0;

        #45 data = 4'b0011;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 data = 4'b1111;
        address = 4'b0010;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

    end


endmodule