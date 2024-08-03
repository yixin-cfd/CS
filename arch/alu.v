`ifndef ALU_V
`define ALU_V
`include "mux16.v"
`include "not16.v"
`include "and16.v"
`include "add16.v"
`include "or16way.v"
`include "not.v"
`include "isneg.v"
/**
 * The ALU (Arithmetic Logic Unit).
 * Computes one of the following functions:
 * x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,
 * x+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs, 
 * according to 6 input bits denoted zx,nx,zy,ny,f,no.
 * In addition, the ALU computes two 1-bit outputs:
 * if the ALU output == 0, zr is set to 1; otherwise zr is set to 0;
 * if the ALU output < 0, ng is set to 1; otherwise ng is set to 0.
 */

// Implementation: the ALU logic manipulates the x and y inputs
// and operates on the resulting values, as follows:
// if (zx == 1) set x = 0        // 16-bit constant
// if (nx == 1) set x = !x       // bitwise not
// if (zy == 1) set y = 0        // 16-bit constant
// if (ny == 1) set y = !y       // bitwise not
// if (f == 1)  set out = x + y  // integer 2's complement addition
// if (f == 0)  set out = x & y  // bitwise and
// if (no == 1) set out = !out   // bitwise not
// if (out == 0) set zr = 1
// if (out < 0) set ng = 1


module ALU(input[15:0] x, y, input zx,nx,zy,ny,f,no, output[15:0] out, output zr, ng);
  wire[15:0] x1, notx1, x2, y1, noty1, y2, andxy, addxy, o1, noto1;
  wire notzr;
  // your code here, use Mux16,Not16,Add16,And16,Or16Way,IsNeg to implement
  // if (zx == 1) set x = 0  
  Mux16 g1(x, 16'b0, zx, x1);
  // if (nx == 1) set x = !x
  Not16 g2(x1, notx1);
  Mux16 g3(x1, notx1, nx, x2);

  // if (zy == 1) set y = 0
  Mux16 g4(y, 16'b0, zy, y1);
  // if (ny == 1) set y = !y
  Not16 g5(y1, noty1);
  Mux16 g6(y1, noty1, ny, y2);

  // addxy = x + y
  Add16 g7(x2, y2, addxy);
  // andxy = x & y
  And16 g8(x2, y2, andxy);
  // if (f == 1)  set out = x + y else set out = x & y
  Mux16 g9(andxy, addxy, f, o1);
  // if (no == 1) set out = !out
  Not16 g10(o1, noto1);
  Mux16 g11(o1, noto1, no, out);


  // zr
  Or16Way g12(out, notzr);
  Not g13(notzr, zr);
  // ng
  IsNeg g14(out, ng);
  
endmodule

`endif