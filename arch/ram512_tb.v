`include "ram512.v"

module ram512_tb;
    reg[15:0] in;
    reg clk,load;
    reg [8:0] address;
    wire[15:0] out;
    RAM512 obj(in, clk, load, address, out);

    always #10 clk=~clk;

    initial begin
        in=16'h0000;
        load=1;
        clk=0;
        address=0;
#10
        #10 in=16'h0001;
        address=1;
#10
        #10 in=16'h2008;
        address=8;
#10
        #10 in=16'h300a;
        address=10;
#10
        #10 in=16'h4025;
        address=25;
#10
        #10 in=16'h5037;
        address=37;
#10
        #10 in=16'h6048;
        address=48;
#10
        #10 in=16'h7063;
        address=63;
#10
        #10 in=16'h7163;
        address=163;
#10
        #10 in=16'h7263;
        address=263;
#10
        #10 in=16'h7363;
        address=363;
#10
        #10 in=16'h7511;
        address=511;
#10
 #10       load=0;
        #10  address=0;
        #10 address=1;
        #10 address=8;
        #10 address=10;
        #10 address=25;
        #10 address=37;
        #10 address=48;
        #10 address=63;
        #10 address=163;
        #10 address=263;
        #10 address=363;
        #10 address=511;
        $finish;
    end

    initial begin
        $monitor($time,,,"in=%x clk=%d load=%d address=%d out=%x\n", in, clk, load, address, out);
    end

endmodule
