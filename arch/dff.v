`ifndef DFF_V
`define DFF_V
`include "mux.v"
`include "not.v"
`include "srff.v"
module DFF(input in, clock, load, output out);

Mux m1(out, in, load, in1);
Not n1(in1, inNot);
Not n2(clock, clockNot);
SRFF s1(in1, clockNot, inNot, Q1, Q_dot1);
SRFF s2(Q1, clock, Q_dot1, out, Q_dot);
endmodule
`endif