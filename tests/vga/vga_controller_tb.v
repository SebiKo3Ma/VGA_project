`timescale 1ns/1ns
module tb_vga_controller();
    reg px_clk, rst;
    reg[11:0] px_data;
    wire[10:0] px_h, px_v;
    wire[3:0] RED, GRN, BLU;
    wire HSYNC, VSYNC;

    vga_controller vga(px_clk, rst, px_data, px_h, px_v, RED, GRN, BLU, HSYNC, VSYNC);

    initial begin
        px_clk = 1'b0;
        forever #20 px_clk = !px_clk;
    end

    task color(input[10:0] px_h, px_v);
        begin
            if(px_h < 320 && px_h >= 0) begin
                if(px_v < 240 && px_v >= 0) begin
                    px_data = 12'haaa;
                end else if(px_v < 480) begin
                    px_data = 12'hccc;
                end else begin
                    px_data = 12'hfff;
                end
            end else if(px_h < 640) begin
                if(px_v < 240 && px_v >= 0) begin
                    px_data = 12'hbbb;
                end else if(px_v < 480) begin
                    px_data = 12'hddd;
                end else begin
                    px_data = 12'hfff;
                end
            end else begin
                px_data = 12'hfff;
            end
        end
    endtask

    initial begin
        rst = 1'b1;
        px_data = 12'd0;
        #100 rst = 1'b0;

        forever #40 color(px_h, px_v);
    end
endmodule