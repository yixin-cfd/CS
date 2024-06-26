`ifndef NOR_V
`define NOR_V
`include "or.v"
`include "not.v"

module Nor(input a, b, output out);
    Or g1(a, b, o1);
    Not g2(o1, out);
endmodule
`endif 