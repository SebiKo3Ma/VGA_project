`timescale 1ns/1ns
module regfile_tb();
    reg[3:0] data, address;
    reg valid, clk, rst;
    wire ack, parity, parity_type, stop_bits;
    wire[3:0] frame_length;

    uart_regfile uart_regfile(.clk_16bd(clk), .rst(rst), .valid(valid), .data(data), .address(address), .ack(ack), .parity(parity), .parity_type(parity_type), .stop_bits(stop_bits), .frame_length(frame_length));

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

    end


endmodule