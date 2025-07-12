// 4-bit Carry-Lookahead Adder
// a[3:0] + b[3:0] + c0 → s[3:0], c4
module cla_4bit (
    input  [3:0] a,
    input  [3:0] b,
    input        c0,
    output [3:0] s,
    output       c4
);
    // 1. Generate 與 Propagate
    wire [3:0] g;   // g[i] = a[i] & b[i]
    wire [3:0] p;   // p[i] = a[i] ^ b[i]
    assign g = a & b;
    assign p = a ^ b;

    // 2. Carry Lookahead Logic
    wire c1, c2, c3;
    assign c1 = g[0] | (p[0] & c0);
    assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c0);
    assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c0);
    assign c4 = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) |
                (p[3] & p[2] & p[1] & p[0] & c0);

    // 3. Sum Output
    assign s[0] = p[0] ^ c0;
    assign s[1] = p[1] ^ c1;
    assign s[2] = p[2] ^ c2;
    assign s[3] = p[3] ^ c3;
endmodule

// 8-bit Carry Lookahead Adder
// a[7:0] + b[7:0] + c0 → s[7:0], c8
module cla_8bit (
    input  [7:0] a,
    input  [7:0] b,
    input        c0,
    output [7:0] s,
    output       c8
);
    wire c4;

    // 低位元
    cla_4bit cla_low (
        .a  (a[3:0]),
        .b  (b[3:0]),
        .c0 (c0),
        .s  (s[3:0]),
        .c4 (c4)
    );

    // 高為元(@w.johnkao)
    cla_4bit cla_high (
        .a  (a[7:4]),
        .b  (b[7:4]),
        .c0 (c4),
        .s  (s[7:4]),
        .c4 (c8)
    );
endmodule
