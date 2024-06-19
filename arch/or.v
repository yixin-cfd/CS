`include "nand.v"
module  Or (
    input a, b,
    output out
);
    Nand gate1(a, a, o1);
    Nand gate2(b, b, o2);
    Nand gate3(o1, o2, out);
endmodule