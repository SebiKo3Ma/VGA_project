module color_processor(input clk, rst, SW0, SW1, swap_h, swap_v, input[3:0] color_valid, input[23:0] rgb0, rgb1, rgb2, rgb3, output[23:0] ch0, ch1, ch2, ch3);
    reg[23:0] ch0_ff, ch0_nxt, ch1_ff, ch1_nxt, ch2_ff, ch2_nxt, ch3_ff, ch3_nxt;
    reg[23:0] rgb0_ff, rgb0_nxt, rgb1_ff, rgb1_nxt, rgb2_ff, rgb2_nxt, rgb3_ff, rgb3_nxt;
    reg swap_h_check_ff, swap_h_check_nxt, swap_v_check_ff, swap_v_check_nxt;

    assign ch0 = ch0_ff;
    assign ch1 = ch1_ff;
    assign ch2 = ch2_ff;
    assign ch3 = ch3_ff;

    always @* begin
        rgb0_nxt = rgb0_ff;
        rgb1_nxt = rgb1_ff;
        rgb2_nxt = rgb2_ff;
        rgb3_nxt = rgb3_ff;

        ch0_nxt = ch0_ff;
        ch1_nxt = ch1_ff;
        ch2_nxt = ch2_ff;
        ch3_nxt = ch3_ff;

        swap_h_check_nxt = swap_h_check_ff;
        swap_v_check_nxt = swap_v_check_ff;
        

        if(color_valid[0]) begin
            rgb0_nxt = rgb0;
        end

        if(color_valid[1]) begin
            rgb1_nxt = rgb1;
        end

        if(color_valid[2]) begin
            rgb2_nxt = rgb2;
        end

        if(color_valid[3]) begin
            rgb3_nxt = rgb3;
        end

        if(!swap_h && !swap_v) begin
            ch0_nxt = rgb0_ff;
            if(SW0 && SW1) begin
                ch1_nxt = rgb1_ff;
                ch2_nxt = rgb2_ff;
                ch3_nxt = rgb3_ff;
            end else if(SW0 && !SW1) begin
                ch1_nxt = rgb1_ff;
                ch2_nxt = rgb0_ff;
                ch3_nxt = rgb1_ff;
            end else if(!SW0 && SW1) begin
                ch1_nxt = rgb0_ff;
                ch2_nxt = rgb2_ff;
                ch3_nxt = rgb2_ff;
            end else begin
                ch1_nxt = rgb0_ff;
                ch2_nxt = rgb0_ff;
                ch3_nxt = rgb0_ff;
            end
        end

        if(swap_h && !swap_h_check_ff) begin
            rgb0_nxt = rgb2_ff;
            rgb1_nxt = rgb3_ff;
            rgb2_nxt = rgb0_ff;
            rgb3_nxt = rgb1_ff;
            swap_h_check_nxt = 1'b1;
        end

        if(swap_v && !swap_v_check_ff) begin
            rgb0_nxt = rgb1_ff;
            rgb1_nxt = rgb0_ff;
            rgb2_nxt = rgb3_ff;
            rgb3_nxt = rgb2_ff;
            swap_v_check_nxt = 1'b1;
        end

        if(!swap_h && swap_h_check_ff) begin
            swap_h_check_nxt = 1'b0;
        end

        if(!swap_v && swap_v_check_ff) begin
            swap_v_check_nxt = 1'b0;
        end

    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            ch0_ff <= 24'd0;
            ch1_ff <= 24'd0;
            ch2_ff <= 24'd0;
            ch3_ff <= 24'd0;
            rgb0_ff <= 24'hff0000;
            rgb1_ff <= 24'h00ff00;
            rgb2_ff <= 24'h0000ff;
            rgb3_ff <= 24'hffff00;
            swap_h_check_ff <= 1'b0;
            swap_v_check_ff <= 1'b0;
        end else begin
            ch0_ff <= ch0_nxt;
            ch1_ff <= ch1_nxt;
            ch2_ff <= ch2_nxt;
            ch3_ff <= ch3_nxt;
            rgb0_ff <= rgb0_nxt;
            rgb1_ff <= rgb1_nxt;
            rgb2_ff <= rgb2_nxt;
            rgb3_ff <= rgb3_nxt;
            swap_h_check_ff <= swap_h_check_nxt;
            swap_v_check_ff <= swap_v_check_nxt;
        end
    end
endmodule