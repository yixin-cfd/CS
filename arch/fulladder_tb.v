`include "fulladder.v"

module fulladder_tb;
    reg a, b, c;
    wire sum, carry;
    FullAdder gate(a, b, c, sum, carry);
    
    initial begin
        a = 0;
        b = 0;
        c = 0;
        #10 c = 1;
        #10 b = 1;
            c = 0;
        #10 c = 1;
        #10 a = 1;
            b = 0;
            c = 0;
        #10 c = 1;
        #10 b = 1;
            c = 0;
        #10 c = 1;
    end

    initial begin
        $monitor("a=%d, b=%d, c=%d, sum=%d, carry=%d\n", a, b, c, sum, carry);
    end
endmodule