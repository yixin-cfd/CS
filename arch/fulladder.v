`ifndef FULLADDER_V
`define FULLADDER_V
`include "xor.v"
`include "and.v"
`include "or.v"

module FullAdder(input a, b, c, output sum, carry);
    Xor gate1(a, b, s1);
    Xor gate2(s1, c, sum);
    And gate3(a, b, c1);
    And gate4(s1, c, c2);
    Or gate5(c1, c2, carry);
endmodule

`endif