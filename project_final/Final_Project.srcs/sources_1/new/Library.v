`timescale 1ns / 1ps
module AND( output O,
input I1,I2);

assign O = I1&I2;
endmodule

module OR (output O,
           input I1,I2);
           
           assign O = I1|I2;
           endmodule


module EXOR(output O,
            input I1,I2);
            LUT2 #(
                .INIT ( 4'b0110 ) 
            ) EXOR
            (
    .I0( I1 ),
    .I1( I2 ),
    .O ( O )
 );
 endmodule

 /*module MUX4_8(
    input [1:0] InsSel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] r
    );

wire [7:0] t0;
wire [7:0] t1; 

assign t0 = (InsSel[1]? c : a);    
assign t1 = (InsSel[1]? d : b);    
assign r  = (InsSel[0]? t1 : t0);    
         
endmodule */


 /*module MUX4_8 (INP,S,O);
        input [31:0]INP;
        input [1:0]S;
        output O;
        wire [7:0]IN[3:0];
        assign IN[0] = INP[7:0];
        assign IN[1] = INP[15:8];
        assign IN[2] = INP[23:16];
        assign IN[3] = INP[31:24];

        assign O= (IN[0] & ~S[1] & ~S[0]) |
                (IN[1] & ~S[1] & S[0]) |
                (IN[2] & S[1] & ~S[0]) |
                (IN[3] & S[1] & S[0]);
endmodule*/

/*module MUX4_1(
    input [1:0] InsSel,
    input a,
    input b,
    input c,
    input d,
    output r
    );
   
assign r = InsSel[1] ? (InsSel[0] ? d : c) : (InsSel[0] ? b:a); 
              
endmodule */


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
    input [7:0]X,[7:0]Y,
    input Ci,
    output [7:0]S,
    output Cout
);
    wire Ci;
    wire [6:0]OX;
    FA fa1(.X(X[0]),.Y(Y[0]),.Ci(Ci),.Cout(OX[0]),.S(S[0]));
    FA fa2(.X(X[1]),.Y(Y[1]),.Ci(OX[0]),.Cout(OX[1]),.S(S[1]));
    FA fa3(.X(X[2]),.Y(Y[2]),.Ci(OX[1]),.Cout(OX[2]),.S(S[2]));
    FA fa4(.X(X[3]),.Y(Y[3]),.Ci(OX[2]),.Cout(OX[3]),.S(S[3]));
    FA fa5(.X(X[4]),.Y(Y[4]),.Ci(OX[3]),.Cout(OX[4]),.S(S[4]));
    FA fa6(.X(X[5]),.Y(Y[5]),.Ci(OX[4]),.Cout(OX[5]),.S(S[5]));
    FA fa7(.X(X[6]),.Y(Y[6]),.Ci(OX[5]),.Cout(OX[6]),.S(S[6]));
    FA fa8(.X(X[7]),.Y(Y[7]),.Ci(OX[6]),.Cout(Cout),.S(S[7]));
endmodule
