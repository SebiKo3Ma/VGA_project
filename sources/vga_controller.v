`timescale 1ns/1ns
module vga_controller(input px_clk, rst, input[11:0] px_data, output[10:0] px_h, px_v, output[3:0] RED, GRN, BLU, output HSYNC, VSYNC);
    reg hs_ff, hs_nxt, vs_ff, vs_nxt, pxh_ff, pxh_nxt, pxv_ff, pxv_nxt;
    reg[9:0] hcount_ff, hcount_nxt;
    reg[18:0] vcount_ff, vcount_nxt;
    
    assign RED = px_data[11:8];
    assign GRN = px_data[7:4];
    assign BLU = px_data[3:0];
    assign HSYNC = hs_ff;
    assign VSYNC = vs_ff;

    assign px_h = pxh_ff;
    assign px_v = pxv_ff;

    always @* begin
        hs_nxt = hs_ff;
        vs_nxt = vs_ff;
        pxh_nxt = pxh_ff;
        pxv_nxt = pxv_ff;
        hcount_nxt = hcount_ff + 1;
        vcount_nxt = vcount_ff + 1;

        if(hcount_ff == 799) begin
            hcount_nxt = 10'd0;
            pxh_nxt = pxh_ff + 1;
        end

        if(vcount_ff == 416799) begin
            vcount_nxt = 10'd0;
            
        end




    end

    always @(posedge px_clk or posedge rst) begin
        if(rst) begin
            hs_ff <= 1'b1;
            vs_ff <= 1'b1;
            pxh_ff <= 11'd0;
            pxv_ff <= 11'd0;
        end else begin
            hs_ff <= hs_nxt;
            vs_ff <= vs_nxt;
            pxh_ff <= pxh_nxt;
            pxv_ff <= pxv_nxt;
        end

    end
endmodule