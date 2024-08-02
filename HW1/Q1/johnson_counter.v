`include "sr_latch.v"

module johnson_counter(
    input CLK, SET, CLR,
    output [3:0] q
);

    wire q_not3;
    
    sr_latch sr0(
        .CLK(CLK),
        .SET(SET),
        .CLR(CLR),
        .S(q_not3),
        .R(~q_not3),
        .Q(q[0])
        
    );
    sr_latch sr1(
        .CLK(CLK),
        .SET(SET),
        .CLR(CLR),
        .S(q[0]),
        .R(~q[0]),
        .Q(q[1])
    );
    sr_latch sr2(
        .CLK(CLK),
        .SET(SET),
        .CLR(CLR),
        .S(q[1]),
        .R(~q[1]),
        .Q(q[2])
    );
    sr_latch sr3(
        .CLK(CLK),
        .SET(SET),
        .CLR(CLR),
        .S(q[2]),
        .R(~q[2]),
        .Q(q[3]),
        .Q_not(q_not3)
    );

endmodule