`timescale 1ns/1ns
module vga_controller(input px_clk, rst, input[11:0] px_data, output[10:0] px_h, px_v, 
                        output[3:0] RED, GRN, BLU, output HSYNC, VSYNC);
    reg hs_ff, hs_nxt, vs_ff, vs_nxt;
    reg[9:0] hcount_ff, hcount_nxt;
    reg[9:0] vcount_ff, vcount_nxt;
    
    localparam h_data = 640;
    localparam h_fp = 16;
    localparam h_pw = 96;
    localparam h_bp = 48;
    localparam h_total = 800;

    localparam v_data = 480;
    localparam v_fp = 10;
    localparam v_pw = 2;
    localparam v_bp = 29;
    localparam v_total = 521;

    localparam polarity = 1;

    assign RED = px_data[11:8];
    assign GRN = px_data[7:4];
    assign BLU = px_data[3:0];
    assign HSYNC = hs_ff;
    assign VSYNC = vs_ff;

    assign px_h = hcount_ff;
    assign px_v = vcount_ff;

    always @* begin
        hs_nxt = hs_ff;
        vs_nxt = vs_ff;
        hcount_nxt = hcount_ff + 1;
        vcount_nxt = vcount_ff;

        //horizontal zero detect
        if(hcount_ff == h_total - 1) begin
            hcount_nxt = 10'd0;
            vcount_nxt = vcount_ff + 1;
        end

        //horizontal sync start
        if(hcount_ff == h_data + h_fp - 1) begin
            hs_nxt = !polarity;
        end
        //horizontal sync stop
        if(hcount_ff == h_data + h_fp + h_pw - 1) begin
            hs_nxt = polarity;
        end

        //vertical zero detect
        if(vcount_ff == v_total - 1) begin
            vcount_nxt = 10'd0;
        end

        //vertical sync start
        if(vcount_ff == v_data + v_fp - 1) begin
            vs_nxt = !polarity;
        end
        //vertical sync stop
        if(vcount_ff == v_data + v_fp + v_pw - 1) begin
            vs_nxt = polarity;
        end
    end

    always @(posedge px_clk or posedge rst) begin
        if(rst) begin
            hs_ff <= 1'b1;
            vs_ff <= 1'b1;
            hcount_ff <= 10'd0;
            vcount_ff <= 10'd0;
        end else begin
            hs_ff <= hs_nxt;
            vs_ff <= vs_nxt;
            hcount_ff <= hcount_nxt;
            vcount_ff <= vcount_nxt;
        end
    end
endmodule