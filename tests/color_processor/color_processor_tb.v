module color_processor_tb();
    reg clk, rst, SW0, SW1, swap_h, swap_v, color_valid;
    reg[23:0] rgb0, rgb1, rgb2, rgb3;
    wire[23:0] ch0, ch1, ch2, ch3;

    color_processor cp(clk, rst, SW0, SW1, swap_h, swap_v, color_valid, rgb0, rgb1, rgb2, rgb3, ch0, ch1, ch2, ch3);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        SW0 = 1'b0;
        SW1 = 1'b0;
        swap_h = 1'b0;
        swap_v = 1'b0;
        color_valid = 1'b0;
        rgb0 = 24'd0;
        rgb1 = 24'd0;
        rgb2 = 24'd0;
        rgb3 = 24'd0;
        #20 rst = 1'b0;

        rgb0 = 24'b111100001111000011110000;
        rgb1 = 24'b010100110101001101010011;
        rgb2 = 24'b110011001100110011001100;
        rgb3 = 24'b001100110011001100110011;

        #50 color_valid = 1'b1;
        #30 color_valid = 1'b0;

        #500 SW0 = 1'b1;

        #600 SW0 = 1'b0;
        #50
        SW1 = 1'b1;

        #700 SW0 = 1'b1;

        #1000 swap_h = 1'b1;
        #30 swap_h = 1'b0;

        #1000 swap_v = 1'b1;
        #30 swap_v = 1'b0;


    end
endmodule