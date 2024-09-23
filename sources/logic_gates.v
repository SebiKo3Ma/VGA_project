module or2_1b(input a, input b, output c);
    assign c = a | b;
endmodule

module or2_4b(input[3:0] a, b, output[3:0] c);
    assign c = a | b;
endmodule

module or3_1b(input a, b, c, output d);
    assign d = a | b | c;
endmodule

module or3_4b(input[3:0] a, b, c, output[3:0] d);
    assign d = a | b | c;
endmodule
