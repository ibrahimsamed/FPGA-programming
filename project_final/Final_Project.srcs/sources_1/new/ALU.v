`timescale 1ns / 1ps
/*
module ALU (
    input [7:0] ALUinA , ALUinB,
    input [1:0] insSel,
    output [7:0] ALUout,
    output CO,Z
);
    wire [7:0] rAND,rXOR,rADD,rLSH,AlUoutwire;
    wire cout,r;

    (* dont_touch="true" *) AND_8 and1(.I1(ALUinA),.I2(ALUinB),.O(rAND));
    (* dont_touch="true" *) XOR_8 xor1(.I1(ALUinA),.I2(ALUinB),.O(rXOR));
    (* dont_touch="true" *) ADD_8 add1(.I1(ALUinA),.I2(ALUinB),.O(rADD),.cout(cout));
    (* dont_touch="true" *) LEFT_SHIFT_8 lsh1(.I(ALUinA),.O(rLSH),.r(r));
    (* dont_touch="true" *) zero_compareter zero1(.I(ALUout),.O(Z));


    (* dont_touch="true" *) MUX4_8 mux1(.a(rAND),.b(rXOR),.c(rADD),.d(rLSH),.InsSel(insSel),.r(ALUout));
    (* dont_touch="true" *) MUX4_1 mux2(.a(1'b0),.b(1'b0),.c(cout),.d(r),.InsSel(insSel),.r(CO));

endmodule




module AND_8 (
    input [7:0] I1,I2,
    output [7:0] O
);
    assign O=I1&I2;
endmodule

module XOR_8 (
    input [7:0] I1,I2,
    output [7:0] O
);
    assign O = I1^I2;
endmodule

module ADD_8 (
    input [7:0] I1,I2,
    output [7:0] O,
    output cout
);
    RCA add1(.X(I1),.Y(I2),.Ci(1'b0),.S(O),.Cout(cout));
endmodule

module LEFT_SHIFT_8 (
    input [7:0] I,
    output [7:0] O,
    output r
);
    assign O = {I[6],I[5],I[4],I[3],I[2],I[1],I[0],I[7]};
    assign r = O[0];
endmodule

module zero_compareter (
    input [7:0] I,
    output O
);
assign O = ~(I[0]|I[1]|I[2]|I[3]|I[4]|I[5]|I[6]|I[7]); 
endmodule
*/

module ALU(
    input [1:0] InsSel,
    output CO,
    output Z,
    input [7:0] ALUinA,
    input [7:0] ALUinB,
    output [7:0] ALUout
    );
    
wire [7:0] rAND;
wire [7:0] rXOR;
wire [7:0] rADD;
wire [7:0] rCLS;
wire cout;
wire [7:0] ALUoutWire; 

 
(* dont_touch="true" *) AND_8 AND(ALUinA, ALUinB, rAND);
(* dont_touch="true" *) XOR_8 XOR(ALUinA, ALUinB, rXOR);
(* dont_touch="true" *) ADD_8 ADD(ALUinA, ALUinB, rADD,cout);
(* dont_touch="true" *) CLS_8 CLS(ALUinA, rCLS);


(* dont_touch="true" *) MUX4_8 MUX1 (InsSel, rAND, rXOR, rADD, rCLS   , ALUoutWire );
(* dont_touch="true" *) MUX4_1 MUX2 (InsSel, 1'b0, 1'b0, cout, rCLS[0], CO );  

assign ALUout = ALUoutWire;

(* dont_touch="true" *) ZeroComp_8 ZC (ALUoutWire, Z);         
    
    
    
    
endmodule


module AND_8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] r
    );
  
assign r = a & b;     
       
endmodule


module XOR_8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] r
    );
  
assign r = a ^ b;     
       
endmodule


module ADD_8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] r,
    output cout
    );
  
assign {cout, r} = a + b;     
       
endmodule


module CLS_8(
    input [7:0] a,
    output [7:0] r
    );
  
assign r[7:1] = a[6:0];     
assign r[0]   = a[7]  ;     
       
endmodule


module MUX4_8(
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
         
endmodule


module MUX4_1(
    input [1:0] InsSel,
    input a,
    input b,
    input c,
    input d,
    output r
    );
  
wire t0;
wire t1; 
    
//assign t0 = (InsSel[1]? c : a);    
//assign t1 = (InsSel[1]? d : b);    
//assign r  = (InsSel[0]? t0 : t1);  

assign r = InsSel[1] ? (InsSel[0] ? d : c) : (InsSel[0] ? b:a);
              
endmodule


module ZeroComp_8(
    input [7:0] a,
    output Z
    );
  
assign Z = ~(a[0]|a[1]|a[2]|a[3]|a[4]|a[5]|a[6]|a[7]);     
       
endmodule
