`timescale 1ns / 1ps

module AsyncFifo_tb;
    reg rd_clk, wr_clk, rst, rd_en, wr_en;
    reg [7:0] din;
    wire empty, full;
    wire [7:0] dout;
    
    parameter tr=4,tw=1;  // tw -- write clock period, tr -- read clock period
    
    AsyncFifo dut (.rd_clk(rd_clk), .wr_clk(wr_clk), .rst(rst), .rd_en(rd_en), .wr_en(wr_en), .din(din), .empty(empty), .full(full), .dout(dout));
    
    // read and write clock generation
    always #tw wr_clk = ~wr_clk;
    always #tr rd_clk = ~rd_clk;
    
    initial begin
        rd_clk = 0;
        wr_clk=0;
        rst = 1;
        wr_en = 0;
        rd_en=0;
        #(2*tw) rst = 0; wr_en = 1; din = 8'b10101010;
        #(2*tw) din = 8'b10101011;
        #(2*tw) din = 8'b00101010;
        #(2*tw) din = 8'b11101010;
        #(2*tw) din = 8'b00000000; wr_en = 0; rd_en = 1;
        #(8*tr) $finish;
    end

endmodule
