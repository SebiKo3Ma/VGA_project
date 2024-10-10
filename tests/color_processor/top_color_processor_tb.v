`timescale 1ns/1ns
module tb_top_cp();
    reg clk, rst, debug, Rx, SW0, SW1, BTNC, BTNR, BTNL, BTNU, en_7s_frame;
    wire [8:0] debug_frame;
    wire[3:0] debug_reg;
    wire[1:0] debug_ch;
    wire[7:0] pos, segments;

    top aux_modules(clk, rst, Rx, SW0, SW1, BTNC, BTNR, BTNU, BTNL, debug, en_7s_frame, debug_frame, debug_reg, debug_ch, pos, segments);

    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end

    task send(input [7:0] data);
        begin
            Rx = 1'b0; //start bit;
            #320 Rx = data[0];
            #320 Rx = data[1];
            #320 Rx = data[2];
            #320 Rx = data[3];
            #320 Rx = data[4];
            #320 Rx = data[5];
            #320 Rx = data[6];
            #320 Rx = data[7];

            #320 Rx = data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[5] ^ data[6] ^ data[7]; //parity bit
            #320 Rx = 1'b1; //stop bit
            
            #400;
        end
    endtask

    initial begin
        rst = 1'b1;
        SW0 = 1'b0;
        SW1 = 1'b0;
        BTNC = 1'b0;
        BTNR = 1'b0;
        BTNU = 1'b0;
        BTNL = 1'b0;
        en_7s_frame = 1'b0;
        debug = 1'b0;
        Rx = 1'b1;
        #300 rst = 1'b0;
        debug = 1'b1;

        en_7s_frame = 1'b1;

        send(8'b00110101);
        send(8'b01001010);
        send(8'b01011101);
        send(8'b01100001);
        send(8'b01111110);
        send(8'b10000111);

        send(8'b00100001);

        send(8'b01100110);

        SW0 = 1'b1;
        #40  send(8'b00100001);

        send(8'b01100110);

        SW1 = 1'b1;

        #100 BTNC = 1'b1;
        #40   BTNC = 1'b0;

        #100 BTNR = 1'b1;
        #40   BTNR = 1'b0;

        #100 BTNU = 1'b1;
        #40   BTNU = 1'b0;

        #100 BTNL = 1'b1;
        #40   BTNL = 1'b0;


    end

endmodule