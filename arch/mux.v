`ifndef MUX_V
`define MUX_V
`include "not.v"
`include "and.v"
`include "or.v"
module Mux(input a, b, sel, output out);
    Not g1(sel, nsel);
    And g2(a, nsel, o1);
    And g3(b, sel, o2);
    Or g4(o1, o2, out);
endmodule
`endif