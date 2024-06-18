`include "nand.v"
module Not(input a, output out);
    Nand gate(a, a, out);
endmodule