`ifndef CPU_V
`define CPU_V
`include "not.v"
`include "register.v"
`include "and.v"
`include "Or.v"
`include "alu.v"
`include "pc.v"
module CPU(
    input[15:0]  inM,         // M value input  (M = contents of RAM[A])
                 instruction, // Instruction for execution
    input clock, reset,       // Signals whether to re-start the current
                              // program (reset==1) or continue executing
                              // the current program (reset==0).

    output[15:0] outM,        // M value output
    output       writeM,      // Write to M? 
    output[14:0] addressM,    // Address in data memory (of M)
                 pc          // address of next instruction
    );
    wire[15:0] inAR, outAR, outALU, pcOut, outAM, outDR;
    // your code here
    // if (instruction[15]==1) set isC=1, else set isA=1
    wire isA, isC;
    assign isC = instruction[15];   // 是否是C指令
    Not g1(isC, isA);               // 是否是A指令

    // instruction[5:3] is dest domin
    //instruction[5]=1 set AR=outALU,instruction[4]=1 set DR=outALU,instruction[3]=1 set M[A]=outALU
    // if (isC&instruction[4]) set isWriteDR=1,outDR=outALU
    wire isWriteDR;
    And g2(instruction[4], isC, isWriteDR);         // d2 为 1，并且是 C指令写入
    Register D(outALU, clock, isWriteDR, outDR);
    // if (isA) set inAR=instruction, or set inAR=outALU
    // if (isA|instruction[5]) set isWriteAR=1
    wire isWriteAR;
    Mux16 g3(outALU, instruction, isA, inAR);       // A寄存器的输入为outALU 或者 A指令
    Or    g4(isA, instruction[5], isWriteAR);        // d1 为 1或者 A指令需要写入 A寄存器
    Register A(inAR, clock, isWriteAR, outAR);
    // check use A or M from instruction[12](a bit)
    Mux16 g5(outAR, inM, instruction[12], outAM);
    // set alu input from instruction[6]/7/8/9/10/11,outDR,outAM
    wire zx, nx, zy, ny, f, no, zr, ng;
    And g6(instruction[11], isC, zx);
    And g7(instruction[10], isC, nx);
    And g8(instruction[9], isC, zy);
    And g9(instruction[8], isC, ny);
    And g10(instruction[7], isC, f);
    And g11(instruction[6], isC, no);

    ALU alu(outDR, outAM, zx, nx, zy, ny, f, no, outALU, zr, ng);
    // if (isC&instruction[3]) set writeM=1, then set outM=outALU
    //assign addressM = outAR[14:0];
    assign outM = outALU;
    assign addressM = outAR[14:0];
    And g12(instruction[3], isC, writeM);


    // isLT=instruction[2], if(isLT&&ng) set isLtJump=1
    wire isLT, isLtJump;
    And g13(instruction[2], isC, isLT);
    And g14(isLT, ng, isLtJump);

    // isEQ=instruction[1], if(isEQ&&zr) set isEqJump=1
    wire isEQ, isEqJump;
    And g15(instruction[1], isC, isEQ);
    And g16(isEQ, zr, isEqJump);

    // if out>0,set isOutGt=1
    wire notng, notzr, isOutGt;
    Not g17(ng, notng);
    Not g18(zr, notzr);
    And g19(notng, notzr, isOutGt);


    // isGT=instruction[0], if(isGT&&isOutGt) set isGtJump=1
    wire isGT, isGtJump;
    And g20(instruction[0], isC, isGT);
    And g21(isGT, isOutGt, isGtJump);


    // if(isLtJump|isEqJump|isGtJump) set jump=1
    wire isjump, jump;
    Or g22(isLtJump, isEqJump, isjump);
    Or g23(isjump, isGtJump, jump);

    // set pcOut according to jump,reset,outAR. use PC module
    PC pcm(outAR, !clock, jump, 1'b1, reset, pcOut);
    //assign pc = pcOut[14:0];
    assign pc = pcOut[14:0];

endmodule
`endif