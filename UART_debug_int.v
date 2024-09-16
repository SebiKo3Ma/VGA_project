`timescale 1ns/1ns
module UART_debug_int(input clk, rst, input[8:0] frame, input frame_valid, output[8:0] debug_frame);

reg[8:0] debug_frame_ff, debug_frame_nxt;
assign debug_frame = debug_frame_ff;

always @* begin
    debug_frame_nxt = debug_frame_ff;
    if(frame_valid) begin
        debug_frame_nxt = frame;
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        debug_frame_ff <= 9'b000000000;
    end else begin
        debug_frame_ff <= debug_frame_nxt;
    end
end

endmodule