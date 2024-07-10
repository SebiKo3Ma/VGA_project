`timescale 1ns/1ns
module top(input clk, rst, Rx, output[8:0] frame)
    wire clk_16bd, clk_bd, frame_valid;
    wire[8:0] temp_frame_ff, temp_frame_nxt;

    assign frame = temp_frame_ff;

    clock_handler clock_handler(2'b01, clk, 1'b1, rst, clk_16bd, clk_bd);
    UART_processor uart_processor(clk_16bd, rst, Rx, 1'b1, 1'b0, 1'b0, 4'b1000, temp_frame_nxt, frame_valid);

    always @(posedge clk, negedge rst) begin
        if(frame_valid) begin
            temp_frame_ff <= temp_frame_nxt;
        end
    end
endmodule