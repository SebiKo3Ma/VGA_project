`timescale 1ns/1ns
module debug_interface(input clk, rst, debug, frame_valid, data_out_valid, input[1:0] channel, input[8:0] frame, input[3:0] data_out, output[8:0] debug_frame, output [3:0] debug_reg, output[1:0] debug_ch);

reg[8:0] debug_frame_ff, debug_frame_nxt;
reg[3:0] debug_reg_ff, debug_reg_nxt;
reg[1:0] channel_ff, channel_nxt;

assign debug_ch = channel_ff;
assign debug_frame = debug_frame_ff;
assign debug_reg = debug_reg_ff;

always @* begin
    debug_frame_nxt = debug_frame_ff;
    debug_reg_nxt = debug_reg_ff;
    channel_nxt = channel;

    if(frame_valid) begin
        debug_frame_nxt = frame;
    end

    if(data_out_valid) begin
        debug_reg_nxt = data_out;
    end

end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        debug_frame_ff <= 9'b000000000;
        debug_reg_ff <= 4'b0000;
        channel_ff <= 2'b00;
    end else if(debug) begin
        debug_frame_ff <= debug_frame_nxt;
        debug_reg_ff <= debug_reg_nxt;
        channel_ff <= channel_nxt;
    end else begin
        debug_frame_ff <= 9'b000000000;
        debug_reg_ff <= 4'b0000;
        channel_ff <= 2'b00;
    end
end

endmodule