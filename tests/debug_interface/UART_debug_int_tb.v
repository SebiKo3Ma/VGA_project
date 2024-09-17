`timescale 1ns/1ns
module tb_uart_debug_int();
    reg[8:0] frame;
    reg clk, rst, frame_valid;
    wire[8:0] debug_frame;

    UART_debug_int UART_debug_int(.clk(clk), .rst(rst), .frame(frame), .frame_valid(frame_valid), .debug_frame(debug_frame));

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        rst = 1'b1;
        #10 rst = 1'b0;
        #20 frame = 9'b010101010;
        #2 frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

        #100 frame = 9'b010110011;
        #2 frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

    end

endmodule