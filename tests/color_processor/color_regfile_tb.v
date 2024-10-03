`timescale 1ns/1ns
module tb_color_regfile();
    reg clk, rst, color_next, valid;
    reg[1:0] channel;
    reg[3:0] data, address;
    wire ack;
    wire[23:0] rgb0, rgb1, rgb2, rgb3;

    color_regfile clr_reg(clk, rst, color_next, channel, data, address, valid, ack, rgb0, rgb1, rgb2, rgb3);

    initial begin
        clk = 1'b0;
        forever #5 clk = !clk;
    end

    task configure(input [3:0] input_address, input [3:0] input_data);
        begin
            #200
            data = input_data;
            address = input_address;
            #2 valid = 1'b1;
            #20 valid = 1'b0;
        end
    endtask

    initial begin
        rst = 1'b1;
        color_next = 1'b0;
        valid = 1'b0;
        data = 4'b0000;
        address = 4'b0000;
        channel = 2'b00;
        #30 rst = 1'b0;

        configure(4'b0011, 4'b1010);
        configure(4'b0100, 4'b1010);
        configure(4'b0101, 4'b1010);
        configure(4'b0110, 4'b1010);
        configure(4'b0111, 4'b1010);
        configure(4'b1000, 4'b1010);

        #400 channel = 2'b01;

        configure(4'b0011, 4'b0101);
        configure(4'b0100, 4'b0101);
        configure(4'b0101, 4'b0101);
        configure(4'b0110, 4'b0101);
        configure(4'b0111, 4'b0101);
        configure(4'b1000, 4'b0101);

        #400 channel = 2'b10;

        configure(4'b0011, 4'b1001);
        configure(4'b0100, 4'b1001);
        configure(4'b0101, 4'b1001);
        configure(4'b0110, 4'b1001);
        configure(4'b0111, 4'b1001);
        configure(4'b1000, 4'b1001);

        #400 channel = 2'b11;

        configure(4'b0011, 4'b0110);
        configure(4'b0100, 4'b0110);
        configure(4'b0101, 4'b0110);
        configure(4'b0110, 4'b0110);
        configure(4'b0111, 4'b0110);
        configure(4'b1000, 4'b0110);

        #300 rst = 1'b1;

        #40 rst = 1'b0;

        #400 channel = 2'b00; //channel 0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;




        #400 channel = 2'b01; //channel 1

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;




        #400 channel = 2'b10; // channel 2

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;



        #400 channel = 2'b11; //channel 3

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        configure(4'b0011, 4'b0110);
        configure(4'b0100, 4'b0110);
        configure(4'b0101, 4'b0110);
        configure(4'b0110, 4'b0110);
        configure(4'b0111, 4'b0110);
        configure(4'b1000, 4'b0110);

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;






        
    end
endmodule