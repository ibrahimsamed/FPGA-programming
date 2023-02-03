`timescale 1ns / 1ps

module HA(
    input X,Y,
    output Cout,S
);
    EXOR exor1(.I1(X),.I2(Y),.O(S));
    AND and2(.I1(X),.I2(Y),.O(Cout));
endmodule

module FA(
    input X,Y,Ci,
    output Cout,S
);
    wire [2:0]OX;
    HA ha1(.X(X),.Y(Y),.Cout(OX[0]),.S(OX[1]));
    HA ha2(.X(OX[1]),.Y(Ci),.S(S),.Cout(OX[2]));
    OR or1(.I1(OX[0]),.I2(OX[2]),.O(Cout));

endmodule

module RCA(
    input [3:0]X,[3:0]Y,
    input Ci,
    output [3:0]S,
    output Cout
);
    wire Ci;
    wire [2:0]OX;
    FA fa1(.X(X[0]),.Y(Y[0]),.Ci(Ci),.Cout(OX[0]),.S(S[0]));
    FA fa2(.X(X[1]),.Y(Y[1]),.Ci(OX[0]),.Cout(OX[1]),.S(S[1]));
    FA fa3(.X(X[2]),.Y(Y[2]),.Ci(OX[1]),.Cout(OX[2]),.S(S[2]));
    FA fa4(.X(X[3]),.Y(Y[3]),.Ci(OX[2]),.Cout(Cout),.S(S[3]));
endmodule


module parametric_RCA(X,Y,Ci,S,Cout);
parameter SIZE=8;

input [SIZE-1:0]X;
input [SIZE-1:0]Y;
input Ci;
output [SIZE-1:0]S;
output Cout;
wire OX[SIZE:0];
assign OX[0]=Ci;

genvar i;
generate
    for(i=0;i<SIZE;i=i+1)
    begin
        FA fai(.X(X[i]),.Y(Y[i]),.Ci(OX[i]),.Cout(OX[i+1]),.S(S[i]));
    end
    assign Cout=OX[SIZE];
endgenerate
    
endmodule

module CLA(
    input [3:0]X,
    input [3:0]Y,
    input c0,
    output cout,
    output [3:0]S
);
wire [3:1]C;
wire [3:0]g;
wire [3:0]p;

assign S[0]=X[0]^Y[0]^c0;
assign g[0]=X[0]&Y[0];
assign p[0]=X[0]|Y[0];
assign C[1]=(p[0]&c0)|g[0];

assign S[1]=X[1]^Y[1]^C[1];
assign g[1]=X[1]&Y[1];
assign p[1]=X[1]|Y[1];
assign C[2]=(p[1]&C[1])|g[1];

assign S[2]=X[2]^Y[2]^C[2];
assign g[2]=X[2]&Y[2];
assign p[2]=X[2]|Y[2];
assign C[3]=(p[2]&C[2])|g[2];

assign S[3]=X[3]^Y[3]^C[3];
assign g[3]=X[3]&Y[3];
assign p[3]=X[3]|Y[3];
assign cout=(p[3]&C[3])|g[3];



endmodule

module ASV(
    input [3:0]X,
    input [3:0]Y,
    input Ci,
    output V,
    output [3:0]S,
    output Cout,
    output C3,C4
);
wire [4:0]C;
wire [3:0]B;

assign C[0]=Ci;
genvar i;
generate
    for(i=0;i<4;i=i+1)
    begin
        EXOR exori(.I1(Y[i]),.I2(Ci),.O(B[i]));
        FA fai(.X(B[i]),.Y(X[i]),.Ci(C[i]),.S(S[i]),.Cout(C[i+1]));
    end
endgenerate
EXOR exorv(.I1(C[3]),.I2(C[4]),.O(V));
assign Cout=C[4];
assign C4=C[4];
assign C3=C[3];
endmodule