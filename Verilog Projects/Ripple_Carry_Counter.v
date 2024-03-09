`timescale 1ns / 1ps

module Ripple_Carry_Counter(q,clk,rst);
    input clk, rst;
    output [3:0] q;
    
    T_FF tff0( q[0], clk, rst);
    T_FF tff1( q[1], q[0], rst);
    T_FF tff2(q[2], q[1], rst);
    T_FF tff3( q[3], q[2], rst);
endmodule

module T_FF(Q,clk,rst);
    input clk, rst;
    output Q;
    wire I;
    
    D_FF dff(Q,I,clk,rst);
    not NOT(I,Q);
endmodule

module D_FF(q,d,clk,rst);
    input d,clk,rst;
    output reg q;
    
    always @(posedge rst or negedge clk)
        if (rst) q<=0;
        else q<=d;
    
endmodule
