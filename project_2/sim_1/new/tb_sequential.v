`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2022 13:59:30
// Design Name: 
// Module Name: tb_sequential
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_seq(
    );
    reg reset,clk,x;
    reg [31:0] test=32'b0100_1110_0101_0010_0101_1001_0100_0101;   
    wire y;
    seq seqq(x,reset,clk,y);


    always #5 clk = ~clk;
    integer i=0;
    initial begin                                                
       clk=0;
       reset=0;
       #75 reset = 1; #5; reset=0;
    end     
    always @(posedge clk) begin 
        x=test[31-i];
        i=i+1;
        if(i==32) begin
            $finish;
        end
    end     
endmodule
