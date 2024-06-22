`include "halfadder.v"

module halfadder_tb;
    reg a, b;
    wire sum, carry;
    HalfAdder gate1(a, b, sum, carry);

    initial begin
        a = 0;
        b = 0;
        #10 b = 1;
        #10 a = 1;
            b = 0;
        #10 a = 1;
            b = 1;
    end

    initial begin
        $monitor("a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);
    end

endmodule