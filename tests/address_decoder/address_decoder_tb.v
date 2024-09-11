`timescale 1ns/1ns
module address_dec_tb();
    reg clk, rst, ack, frame_valid;
    reg[7:0] frame;

    wire valid;
    wire[3:0] data, address;

    address_decoder address_decoder(.clk(clk), .rst(rst), .frame(frame), .frame_valid(frame_valid), .ack(ack), .data(data), .address(address), .valid(valid));

    initial begin
    clk = 0;
    forever #10 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #20 rst = 1'b0;

        frame = 8'b10010010;
        frame_valid = 1'b1;

        #25 frame_valid = 1'b0;

        #100 ack = 1'b1;
        #20 ack = 1'b0;

        #100

        frame = 8'b10101010;
        frame_valid = 1'b1;

        #25 frame_valid = 1'b0;

        #100 ack = 1'b1;
        #20 ack = 1'b0;

    end

endmodule