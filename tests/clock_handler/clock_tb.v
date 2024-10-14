`timescale 1ns/1ns
module clock_tb();
  reg clk, rst;
  reg [2:0] baud;
  wire clk_16bd, clk_8KHz, clk_25MHz;
  
  clock_handler clk_handler(clk, rst, baud, clk_16bd, clk_8KHz, clk_25MHz);
  
  initial begin
    clk = 0;
    forever #5 clk = !clk;
  end
  initial begin
    baud = 2'b10;
    rst = 1'b1;
    #30 rst = 1'b0;
    #1000 baud = 2'b01;
    #1000;
  end
endmodule