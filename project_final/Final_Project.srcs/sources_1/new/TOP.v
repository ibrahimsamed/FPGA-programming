`timescale 1ns / 1ps


module TOP(
    input clk,rst,start,
    input [7:0] InA,InB,
    output [7:0] out,
    output busy
    );
    wire CO,Z,WE;
    wire [1:0] InsSel;
    wire [7:0] CUconst,ALUinA,ALUinB,ALUout;
    wire [2:0] InMuxAdd;
    wire [3:0] OutMuxAdd,RegAdd;
    CU cu(.clk(clk),.reset(rst),.Z(Z),.CO(CO),.start(start),.InsSel(InsSel),.WE(WE),.busy(busy),.InMuxAdd(InMuxAdd),.CUconst(CUconst),.OutMuxAdd(OutMuxAdd),.RegAdd(RegAdd));
    ALU alu(.ALUinA(ALUinA),.ALUinB(ALUinB),.InsSel(InsSel),.ALUout(ALUout),.CO(CO),.Z(Z));
    RB rb(.clk(clk),.reset(rst),.WE(WE),.InA(InA),.InB(InB),.CUconst(CUconst),.ALUout(ALUout),.InMuxAdd(InMuxAdd),.RegAdd(RegAdd),.OutMuxAdd(OutMuxAdd),.Out(out),.ALUinA(ALUinA),.ALUinB(ALUinB));

endmodule
