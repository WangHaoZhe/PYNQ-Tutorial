module Add_half (sum, c_out, a, b);
    input a, b;
    output sum, c_out;
    wire c_out_bar;
    xor (sum, a, b);
    nand (c_out_bar, a, b);
    not (c_out, c_out_bar);
endmodule
