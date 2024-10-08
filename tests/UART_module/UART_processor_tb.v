`timescale 1ns/1ns
module uart_tb();
    reg clk, rst, baud_ready;
    reg [2:0] baud;
    wire clk_16bd, clk_bd;

    reg Rx, parity, parity_type, stop_bits;
    reg [3:0] frame_length;
    wire [8:0] frame;
    wire frame_valid;

    clock_handler clk_handler(.clk(clk), .baud(baud), .baud_ready(baud_ready), .rst(rst), .clk_16bd(clk_16bd), .clk_bd(clk_bd));
    UART_processor UART(.clk_16bd(clk), .rst(rst), .Rx(Rx), .parity(parity), .parity_type(parity_type), .stop_bits(stop_bits), .frame_length(frame_length), .frame(frame), .frame_valid(frame_valid));

    initial begin
    clk = 0;
    forever #10 clk = !clk;
    end
    
    initial begin
        baud_ready = 1'b0;
        #1 baud = 2'b10;
        baud_ready = 1'b1;
        rst = 1'b1;
        #3 rst = 1'b0;
        parity = 1;
        parity_type = 0;
        stop_bits = 0; 
        frame_length = 4'b1000;
        #3 rst = 1'b0;

        #40 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        #2682 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;

        #320 Rx = 1'b1; //parity bit - invalid parity
        #320 Rx = 1'b1; //stop bit


        //valid and invalid frame with even parity

        #10000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        #2682 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //parity bit - invalid parity
        #320 Rx = 1'b1; //stop bit

        // frame with invalid stop

        #5000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b0; //stop bit - invalid stop
        #320 Rx = 1'b1; //idle

        // frame with no parity

        parity = 0;

        #2500 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //stop bit

        // invalid and valid frame with odd parity

        #400 parity = 1;
        parity_type = 1;

        #7500 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit - invalid parity
        #320 Rx = 1'b1; //stop bit

        #2682 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b1; //parity bit
        #320 Rx = 1'b1; //stop bit

        // valid and invalid frames for 2 stop bits
        #400 parity_type = 0;
        stop_bits = 1;

        #10000 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit

        #2682 Rx = 1'b0; //start bit

        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b0;
        #320 Rx = 1'b1;
        #320 Rx = 1'b0;

        #320 Rx = 1'b0; //parity bit
        #320 Rx = 1'b1; //stop bit
        #320 Rx = 1'b0; //invalid second stop bit


        #320 Rx = 1'b1; //idle



    end
endmodule