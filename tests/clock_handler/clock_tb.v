`timescale 1ns/1ns
module clock_tb();
  reg clk, rst, baud_ready;
  reg [2:0] baud;
  wire clk_16bd, clk_bd;
  
  clock_handler clk_handler(.clk(clk), .baud(baud), .baud_ready(baud_ready), .rst(rst), .clk_16bd(clk_16bd), .clk_bd(clk_bd));
  
  initial begin
    clk = 0;
    forever #2 clk = !clk;
  end
  initial begin
    baud_ready = 1'b0;
    #1 baud = 2'b10;
    baud_ready = 1'b1;
    rst = 1'b1;
    #3 rst = 1'b0;
    #100 baud_ready = 1'b0;
    #1 baud = 2'b01;
    #1 baud_ready = 1'b1;
    #100;
    $finish();
  end
endmodule