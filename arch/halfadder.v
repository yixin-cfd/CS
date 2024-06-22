`ifndef HALFADDER_V
`define HALFADDER_V
`include "xor.v"
`include "and.v"
module HalfAdder(input a, b, output sum, carry);
    Xor gate1(a, b, sum);
    And gate2(a, b, carry);
endmodule
`endif 