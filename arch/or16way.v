`ifndef OR16WAY_V
`define OR16WAY_V
`include "or.v"
/**
 * 16-way Or: 
 * out = (in[0] or in[1] or ... or in[15])
 */

module Or16Way(input[15:0] in,output out);
    // your code here
     // 中间信号线
    wire a0, a1, a2, a3, a4, a5, a6, a7;
    Or ga1(in[0], in[1], a0);
    Or ga2(in[2], in[3], a1);
    Or ga3(in[4], in[5], a2);
    Or ga4(in[6], in[7], a3);
    Or ga5(in[8], in[9], a4);
    Or ga6(in[10], in[11], a5);
    Or ga7(in[12], in[13], a6);
    Or ga8(in[14], in[15], a7);
    wire b0, b1, b2, b3;
    Or gb1(a0, a1, b0);
    Or gb2(a2, a3, b1);
    Or gb3(a4, a5, b2);
    Or gb4(a6, a7, b3);
     wire c0, c1;
    Or gc1(b0, b1, c0);
    Or gc2(b2, b3, c1);

    Or gout(c0, c1, out);
endmodule

`endif
