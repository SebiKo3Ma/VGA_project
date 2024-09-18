`timescale 1ns/1ns
module tb_clock_module();
  reg clk, rst, valid;
  reg[3:0] address, data;
  wire[3:0] data_out;
  wire ack, data_out_valid;
  wire clk_16bd;
  
  clock_handler_module clk_handler_module(clk, rst, address, data, valid, ack, data_out, data_out_valid, clk_16bd);
  
  initial begin
    clk = 0;
    forever #5 clk = !clk;
  end
  initial begin
    rst = 1'b1;
        #20 rst = 1'b0;
        #45

        data = 4'b0010;
        address = 4'b0001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #500 data = 4'b0001;
        address = 4'b1001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #500 data = 4'b1111;
        address = 4'b0001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #500 data = 4'b0001;
        address = 4'b0001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;

        #45 rst = 1'b1;
        #20 rst = 1'b0;

        #500 data = 4'b1111;
        address = 4'b0001;
        #2 valid = 1'b1;
        #20 valid = 1'b0;
  end
endmodule