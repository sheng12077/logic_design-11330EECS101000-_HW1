`timescale 1ns/1ps

module tb_cla_8bit;

    reg  [7:0] a, b;
    reg        c0;
    wire [7:0] s;
    wire       c8;

    cla_8bit dut (
        .a  (a),
        .b  (b),
        .c0 (c0),
        .s  (s),
        .c8 (c8)
    );

    // testcases
    initial begin
        a = 0; b = 0; c0 = 0;

        //1+1=2
        #10 a = 8'b0000_0001; b = 8'b0000_0001; c0 = 0;

        //85+51=136
        #10 a = 8'b0101_0101; b = 8'b0011_0011; c0 = 0;

        //255+1=0 (c8=1)
        #10 a = 8'b1111_1111; b = 8'b0000_0001; c0 = 0;

        //128+128+1=1 (c8=1)
        #10 a = 8'b1000_0000; b = 8'b1000_0000; c0 = 1;

        #10 $finish;
    end

    initial begin
        $monitor("%4t  a=%0d b=%0d cin=%b  ->  sum=%0d c8=%b",
                 $time, a, b, c0, s, c8);
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,        
            tb_cla_8bit.a,
            tb_cla_8bit.b,
            tb_cla_8bit.c0,
            tb_cla_8bit.s,
            tb_cla_8bit.c8
        );
    end

endmodule
