`timescale 1ns/1ns
module tb_wrapper();
    reg clk, rst, swap_h, swap_v, color_next, SW0, SW1;
    reg [1:0] channel;
    reg[3:0] resolution, address, data;
    reg valid;
    wire ack;
    reg[10:0] px_h, px_v;
    wire[11:0] px_12bit_data;
    wire[23:0] px_24bit_data;

    color_processor_wrapper clr_pw(clk, rst, swap_h, swap_v, color_next, SW0, SW1, channel, resolution, address, data, valid, ack, px_h, px_v, px_12bit_data, px_24bit_data);

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

    integer i, j;

    initial begin
        rst = 1'b1;
        swap_h = 1'b0;
        swap_v = 1'b0;
        color_next = 1'b0;
        SW0 = 1'b0;
        SW1 = 1'b0;
        channel = 2'b00;
        resolution = 4'b0000;
        address = 4'b0000;
        data = 4'b0000;
        valid = 1'b0;
        px_h = 11'd0;
        px_v = 11'd0;
        #50 rst = 1'b0;

        #200
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

        configure(4'b0011, 4'b0111);
        configure(4'b0100, 4'b0111);
        configure(4'b0101, 4'b0111);
        configure(4'b0110, 4'b0111);
        configure(4'b0111, 4'b0111);
        configure(4'b1000, 4'b0111);

        #400 channel = 2'b01; //channel 1;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #100 color_next = 1'b1;
        #50 color_next = 1'b0;

        #500 SW0 = 1'b1;

        for(i = 0 ; i < 480 ; i = i + 1) begin
            for(j = 0 ; j < 640 ; j = j + 1) begin
                px_v = i;
                px_h = j;
                #40;
            end
        end

        #600 SW0 = 1'b0;

        for(i = 0 ; i < 480 ; i = i + 1) begin
            for(j = 0 ; j < 640 ; j = j + 1) begin
                px_v = i;
                px_h = j;
                #40;
            end
        end

        #50
        SW1 = 1'b1;

        #700 SW0 = 1'b1;

        for(i = 0 ; i < 480 ; i = i + 1) begin
            for(j = 0 ; j < 640 ; j = j + 1) begin
                px_v = i;
                px_h = j;
                #40;
            end
        end

        #1000 swap_h = 1'b1;
        #30 swap_h = 1'b0;

        for(i = 0 ; i < 480 ; i = i + 1) begin
            for(j = 0 ; j < 640 ; j = j + 1) begin
                px_v = i;
                px_h = j;
                #40;
            end
        end

        #1000 swap_v = 1'b1;
        #30 swap_v = 1'b0;


        

    end
endmodule
