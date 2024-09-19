module in2_1bit_or_gate(input a, input b, output c);
    assign c = a | b;
endmodule

module in2_4bit_or_gate(input[3:0] a, b, output[3:0] c);
    assign c = a | b;
endmodule
