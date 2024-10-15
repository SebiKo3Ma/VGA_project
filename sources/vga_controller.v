`timescale 1ns/1ns
module vga_controller(input px_clk, rst, input[11:0] px_data, output[10:0] px_h, px_v, 
                        output[3:0] RED, GRN, BLU, output HSYNC, VSYNC);
    reg hs_ff, hs_nxt, vs_ff, vs_nxt;
    reg[10:0] pxv_ff, pxv_nxt;
    reg[9:0] hcount_ff, hcount_nxt;
    reg[18:0] vcount_ff, vcount_nxt;
    
    assign RED = px_data[11:8];
    assign GRN = px_data[7:4];
    assign BLU = px_data[3:0];
    assign HSYNC = hs_ff;
    assign VSYNC = vs_ff;

    assign px_h = hcount_ff - 144;
    assign px_v = pxv_ff - 31;

    always @* begin
        hs_nxt = hs_ff;
        vs_nxt = vs_ff;
        pxv_nxt = pxv_ff;
        hcount_nxt = hcount_ff + 1;
        vcount_nxt = vcount_ff + 1;

        //heorizontal zero detect
        if(hcount_ff == 10'd799) begin
            hcount_nxt = 10'd0;
            hs_nxt = 1'b1;
            pxv_nxt = pxv_ff + 1;
        end

        //horizontal 3.84us detect
        if(hcount_ff == 10'd95) begin
            hs_nxt = 1'b0;
        end

        //vertical zero detect
        if(vcount_ff == 19'd416799) begin
            vcount_nxt = 10'd0;
            vs_nxt = 1'b1;
            pxv_nxt = 1'b0;
        end

        //vertical 64us detect
        if(vcount_ff == 19'd1599) begin
            vs_nxt = 1'b0;
        end




    end

    always @(posedge px_clk or posedge rst) begin
        if(rst) begin
            hs_ff <= 1'b1;
            vs_ff <= 1'b1;
            hcount_ff <= 10'd0;
            vcount_ff <= 19'd0;
            pxv_ff <= 11'd0;
        end else begin
            hs_ff <= hs_nxt;
            vs_ff <= vs_nxt;
            pxv_ff <= pxv_nxt;
            hcount_ff <= hcount_nxt;
            vcount_ff <= vcount_nxt;
        end

    end
endmodule