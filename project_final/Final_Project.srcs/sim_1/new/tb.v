`timescale 1ns / 1ps


module tb;
    reg clk,rst,start;
    reg [7:0] InA,InB;
    wire [7:0] out;
    wire busy;

    TOP top(.clk(clk),.rst(rst),.start(start),.InA(InA),.InB(InB),.out(out),.busy(busy));

    initial begin
        clk=1'b0;
        rst=1'b1;
        #5;
    end
    always begin
        clk =~clk;
        #5;
    end

    initial begin
        rst=1'b0;
        #5;
        InA = 8'b11100111;
        InB = 8'b00001111;
        start = 1'b1;
        #1000;
        $finish;
    end
endmodule
