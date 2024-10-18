`timescale 1ns/1ns
module vga_controller(input px_clk, rst, input[11:0] px_data, input[3:0] resolution, output[10:0] px_h, px_v, 
                        output[3:0] RED, GRN, BLU, output HSYNC, VSYNC);
    reg hs_ff, hs_nxt, vs_ff, vs_nxt;
    reg[10:0] hcount_ff, hcount_nxt;
    reg[10:0] vcount_ff, vcount_nxt;

    reg[11:0] h_total, h_total_nxt, v_total, v_total_nxt;
    reg[10:0] h_data, v_data, h_data_nxt, v_data_nxt;
    reg[7:0] h_fp, h_bp, h_pw, h_fp_nxt, h_bp_nxt, h_pw_nxt, v_fp, v_bp, v_pw, v_fp_nxt, v_bp_nxt, v_pw_nxt;
    reg polarity, polarity_nxt;

    assign RED = (hcount_ff < h_data && vcount_ff < v_data) ? px_data[11:8] : 4'b0000;
    assign GRN = (hcount_ff < h_data && vcount_ff < v_data) ? px_data[7:4] : 4'b0000;
    assign BLU = (hcount_ff < h_data && vcount_ff < v_data) ? px_data[3:0] : 4'b0000;
    assign HSYNC = hs_ff;
    assign VSYNC = vs_ff;

    assign px_h = hcount_ff < h_data ? hcount_ff : 1'b0;
    assign px_v = vcount_ff < v_data ? vcount_ff : 1'b0;

    always @* begin
        hs_nxt = hs_ff;
        vs_nxt = vs_ff;
        hcount_nxt = hcount_ff + 1;
        vcount_nxt = vcount_ff;
        polarity_nxt = polarity;
        h_data_nxt = h_data;
        h_fp_nxt = h_fp;
        h_bp_nxt = h_bp;
        h_pw_nxt = h_pw;
        v_data_nxt = v_data;
        v_fp_nxt = v_fp;
        v_bp_nxt = v_bp;
        v_pw_nxt = v_pw;

        h_total_nxt = h_data + h_fp + h_pw + h_bp;
        v_total_nxt = v_data + v_fp + v_pw + v_bp;

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

        case(resolution)
            4'b0000 : begin
                h_data_nxt = 11'd640;
                h_fp_nxt = 8'd16;
                h_pw_nxt = 8'd96;
                h_bp_nxt = 8'd48;

                v_data_nxt = 11'd480;
                v_fp_nxt = 8'd10;
                v_pw_nxt = 8'd2;
                v_bp_nxt = 8'd29;

                polarity_nxt = 1'b1;
            end

            4'b0001 : begin
                h_data_nxt = 11'd800;
                h_fp_nxt = 8'd56;
                h_pw_nxt = 8'd120;
                h_bp_nxt = 8'd64;

                v_data_nxt = 11'd600;
                v_fp_nxt = 8'd37;
                v_pw_nxt = 8'd6;
                v_bp_nxt = 8'd23;

                polarity_nxt = 1'b1;
            end

            default: begin
                h_data_nxt = 11'd640;
                h_fp_nxt = 8'd16;
                h_pw_nxt = 8'd96;
                h_bp_nxt = 8'd48;

                v_data_nxt = 11'd480;
                v_fp_nxt = 8'd10;
                v_pw_nxt = 8'd2;
                v_bp_nxt = 8'd29;

                polarity_nxt = 1'b1;
            end
        endcase
    end

    always @(posedge px_clk or posedge rst) begin
        if(rst) begin
            hs_ff <= 1'b1;
            vs_ff <= 1'b1;
            hcount_ff <= 10'd0;
            vcount_ff <= 10'd0;
            polarity <= 1'b1;
        end else begin
            hs_ff <= hs_nxt;
            vs_ff <= vs_nxt;
            hcount_ff <= hcount_nxt;
            vcount_ff <= vcount_nxt;
            h_data <= h_data_nxt;
            h_fp <= h_fp_nxt;
            h_pw <= h_pw_nxt;
            h_bp <= h_bp_nxt;
            v_data <= v_data_nxt;
            v_fp <= v_fp_nxt;
            v_pw <= v_pw_nxt;
            v_bp <= v_bp_nxt;
            h_total <= h_total_nxt;
            v_total <= v_total_nxt;
            polarity <= polarity_nxt;
        end
    end
endmodule