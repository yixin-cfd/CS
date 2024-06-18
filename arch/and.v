`include "nand.v"
module And(input a, b, output out);
    Nand n1(a, b, o1);
    Nand n2(o1, o1, out);
endmodule