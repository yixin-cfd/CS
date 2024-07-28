`ifndef RAM512_V
`define RAM512_V
`include "dmux8way.v"
`include "ram64.v"
`include "mux8way16.v"

module RAM512(input [15:0] in, input clk,load, input [8:0] address, output [15:0] out);
    // your code here
    wire[15:0] o1, o2, o3, o4, o5, o6, o7, o8;
    DMux8Way d1(load, address[8:6], loadA, loadB, loadC, loadD, loadE, loadF, loadG, loadH);

    RAM64 r1(in, clk, loadA, address[5:0], o1);
    RAM64 r2(in, clk, loadB, address[5:0], o2);
    RAM64 r3(in, clk, loadC, address[5:0], o3);
    RAM64 r4(in, clk, loadD, address[5:0], o4);
    RAM64 r5(in, clk, loadE, address[5:0], o5);
    RAM64 r6(in, clk, loadF, address[5:0], o6);
    RAM64 r7(in, clk, loadG, address[5:0], o7);
    RAM64 r8(in, clk, loadH, address[5:0], o8);

    Mux8Way16 m1(o1, o2, o3, o4, o5, o6, o7, o8, address[8:6], out);
endmodule

`endif
