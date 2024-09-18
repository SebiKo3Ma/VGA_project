`timescale 1ns/1ns
module tb_debug_interface();
    reg[8:0] frame;
    reg[3:0] data_out;
    reg clk, rst, debug, frame_valid;
    wire[8:0] debug_frame;
    wire[3:0] debug_reg;

    debug_interface debug_interface(clk, rst, debug, frame_valid, frame, data_out, debug_frame, debug_reg);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    initial begin
        debug = 1'b0;
        rst = 1'b1;
        #10 rst = 1'b0;
        #20 frame = 9'b010101010;
        #2 frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

        #20 debug = 1'b1;

        #100 frame = 9'b010110011;
        #2 frame_valid = 1'b1;
        #10 frame_valid = 1'b0;

        #100 frame = 9'b001010101;
        #2 frame_valid = 1'b1;
        data_out = 4'b0101;
        #10 frame_valid = 1'b0;

    end

endmodule