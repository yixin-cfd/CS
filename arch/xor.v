`ifndef XOR_V
`define XOR_V

`include "or.v"
`include "nand.v"
`include "and.v"

module Xor(input a, b, output out);
    Or gate1(a, b, o1);
    Nand gate2(a, b, o2);
    And gate3(o1, o2, out);
endmodule

`endif 