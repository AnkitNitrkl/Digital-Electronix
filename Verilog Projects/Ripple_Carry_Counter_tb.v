`timescale 1ns / 1ps

module ripple_carry_counter_tb;
    reg clk,rst;
    wire [3:0]q;
    
    // Ripple_Carry_Counter module instantiation
    Ripple_Carry_Counter uut(q,clk,rst);
    
    //clock generation
    initial 
        clk = 1'b0;
    always 
        #5 clk = ~clk;
    
    initial begin
        rst = 1'b1;
        #15 rst = 1'b0;
        #180 rst = 1'b1;
        #10 rst = 1'b0;
        #20 $finish;
    end
    
    // display output
    initial
        $monitor($time,"clock = %d, reset = %d, output=%d",clk,rst,q);
endmodule
