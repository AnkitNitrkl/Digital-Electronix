`timescale 1ns / 1ps

module AsyncFifo(
    input [7:0] din,
    input wr_en,rd_en,rst,wr_clk, rd_clk,
    output reg full, empty,
    output reg [7:0] dout);
    parameter data_width = 8, fifo_depth=4;
    integer rd_ptr,wr_ptr,fifoLine;
    reg [data_width-1:0] mem [fifo_depth-1:0];
    integer i=0;
    
    // Reset
    always @(rst) begin
        rd_ptr <= 0;
        wr_ptr <= 0;
        full <= 0;
        empty <= 1;
        fifoLine<=0;
        dout <= 8'h00;
        for (i=0;i<fifo_depth;i=i+1) begin
            mem[i] <= 8'h00;
            end
        end
        
        
    // Write data
    always @(posedge wr_clk) begin
        if (wr_en & ~full) begin
            mem[wr_ptr]<=din;
            fifoLine<= fifoLine+1;
            empty<=0;
            if (wr_ptr == fifo_depth-1) wr_ptr<=0;
            else wr_ptr<= wr_ptr+1;   
            end
        end
    
    // Read data
    always @(posedge rd_clk) begin
        if (rd_en & ~empty) begin
            dout<=mem[rd_ptr];
            if (rd_ptr == fifo_depth-1) rd_ptr<=0;
            else rd_ptr<= rd_ptr+1;   
            fifoLine<= fifoLine-1;
            full<=0;
            end
        end
    
    // full and empty flag
    always @(fifoLine) begin
        if (fifoLine == fifo_depth) full<=1;
        else if (fifoLine == 0) empty<=1;
        end
endmodule
