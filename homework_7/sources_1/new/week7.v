`timescale 1ns / 1ps



module MULTS(
    input [7:0]A,
    input [7:0]X,
    output [15:0]result
    );
    wire [15:0] PP0,PP1,PP2,PP3,PP4,PP5,PP6,PP7;
    wire [15:0] sum1,sum2,sum3,sum4,sum5,sum6,sum7;

    assign PP0 = {X[0],X[0],X[0],X[0],X[0],X[0],X[0],X[0]} & A;
    assign PP1 = ({X[1],X[1],X[1],X[1],X[1],X[1],X[1],X[1]} & A)<<1;
    assign PP2 = ({X[2],X[2],X[2],X[2],X[2],X[2],X[2],X[2]} & A)<<2;
    assign PP3 = ({X[3],X[3],X[3],X[3],X[3],X[3],X[3],X[3]} & A)<<3;
    assign PP4 = ({X[4],X[4],X[4],X[4],X[4],X[4],X[4],X[4]} & A)<<4;
    assign PP5 = ({X[5],X[5],X[5],X[5],X[5],X[5],X[5],X[5]} & A)<<5;
    assign PP6 = ({X[6],X[6],X[6],X[6],X[6],X[6],X[6],X[6]} & A)<<6;
    assign PP7 = ({X[7],X[7],X[7],X[7],X[7],X[7],X[7],X[7]} & A)<<7;


    //1st stage
    CLA16 cla1 (.a(PP0),.b(PP1),.cin(1'b0),.sum(sum1));
    CLA16 cla2 (.a(PP2),.b(PP3),.cin(1'b0),.sum(sum2));

    CLA16 cla3(.a(PP4),.b(PP5),.cin(1'b0),.sum(sum3));
    CLA16 cla4(.a(PP6),.b(PP7),.cin(1'b0),.sum(sum4));


    //2nd stage
    CLA16 cla5(.a(sum1),.b(sum2),.cin(1'b0),.sum(sum5));
    CLA16 cla6(.a(sum3),.b(sum4),.cin(1'b0),.sum(sum6));


    //3rd stage
    CLA16 cla7(.a(sum6),.b(sum5),.cin(1'b0),.sum(sum7));

    assign result = sum7;
    
endmodule

module CLA16(a,b, cin, sum,cout);
input [15:0] a,b;
input cin;
output [15:0] sum;
output cout;
wire c1,c2,c3;

CLA cla1 (.X(a[3:0]), .Y(b[3:0]), .c0(cin), .S(sum[3:0]), .cout(c1));
CLA cla2 (.X(a[7:4]), .Y(b[7:4]), .c0(c1), .S(sum[7:4]), .cout(c2));
CLA cla3(.X(a[11:8]), .Y(b[11:8]), .c0(c2), .S(sum[11:8]), .cout(c3));
CLA cla4(.X(a[15:12]), .Y(b[15:12]), .c0(c3), .S(sum[15:12]), .cout(cout));

endmodule

module MULTS_signed(
    input [7:0]A,
    input [7:0]X,
    output [15:0]result
    );
    reg Y=16'b1000000100000000;
    wire [15:0]PP00;
    wire [15:0] PP0,PP1,PP2,PP3,PP4,PP5,PP6,PP7;
    wire [15:0] sum1,sum2,sum3,sum4,sum5,sum6,sum7;
    wire [15:0] PPshift0,PPshift1,PPshift2,PPshift3,PPshift4,PPshift5,PPshift6,PPshift7;

    
        assign PP0[6:0]= {X[0],X[0],X[0],X[0],X[0],X[0],X[0]} & A[6:0];
        assign PP0[7]= ~(X[0]&A[7]);
        
        assign PP1[6:0]= {X[1],X[1],X[1],X[1],X[1],X[1],X[1]} & A[6:0];
        assign PP1[7]= ~(X[1]&A[7]);

        assign PP2[6:0] = {X[2],X[2],X[2],X[2],X[2],X[2],X[2]} & A[6:0];
        assign PP2[7] = ~(X[2]&A[7]);
        
        assign PP3[6:0] = {X[3],X[3],X[3],X[3],X[3],X[3],X[3]} & A[6:0];
        assign PP3[7] = ~(X[3]&A[7]);

        assign PP4[6:0] = {X[4],X[4],X[4],X[4],X[4],X[4],X[4]} & A[6:0];
        assign PP4[7] = ~(X[4]&A[7]);

        
        assign PP5[6:0] = {X[5],X[5],X[5],X[5],X[5],X[5],X[5]} & A[6:0];
        assign PP5[7] = ~(X[5]&A[7]);
        
        assign PP6[6:0] = ~({X[6],X[6],X[6],X[6],X[6],X[6],X[6]} & A[6:0]);
        assign PP6[7] = (X[6]&A[7]);
        
        assign PPshift0[15:0] = {8'b00000000,PP0[15:0]};
        assign PPshift1[15:0] = {7'b0000000,PP1[15:0] <<1};
        assign PPshift2[15:0] = {6'b000000 ,PP2[15:0] <<2};
        assign PPshift3[15:0] = {5'b00000,PP3[15:0] <<3};
        assign PPshift4[15:0] = {4'b0000,PP4[15:0] <<4};
        assign PPshift5[15:0] = {3'b000,PP5[15:0] <<5};
        assign PPshift6[15:0] = {2'b00,PP6[15:0] <<6};
        assign PPshift7[15:0] = {1'b0,PP7[15:0] <<7};
        


    //additional step
    CLA16 clai(.a(PPshift0),.b(Y),.cin(1'b0),.sum(PP00));

    //1st stage
    CLA16 cla1 (.a(PP00),.b(PPshift1),.cin(1'b0),.sum(sum1));
    CLA16 cla2 (.a(PPshift2),.b(PPshift3),.cin(1'b0),.sum(sum2));

    CLA16 cla3(.a(PPshift4),.b(PPshift5),.cin(1'b0),.sum(sum3));
    CLA16 cla4(.a(PPshift6),.b(PPshift7),.cin(1'b0),.sum(sum4));


    //2nd stage
    CLA16 cla5(.a(sum1),.b(sum2),.cin(1'b0),.sum(sum5));
    CLA16 cla6(.a(sum3),.b(sum4),.cin(1'b0),.sum(sum6));


    //3rd stage
    CLA16 cla7(.a(sum6),.b(sum5),.cin(1'b0),.sum(sum7));

    assign result = sum7;
    
endmodule


module MULTB(
    input signed [7:0]A,
    input signed [7:0]B,
    output reg signed [15:0]result
);
    always @(*) begin
        result=A*B;
    end
endmodule

module MAC(
    input clk,
    input reset,
    input signed [23:0]data,weight,
    output reg signed [19:0]result
);
    initial
    begin
    result = 20'b00000000000000000000;
    end
    wire signed [15:0]product0,product1,product2;
    wire signed [15:0] sum0,sum1;
    reg [1:0]count=2'b00;
        MULTB u1(.A(data[7:0]),.B(weight[7:0]),.result(product0));
        MULTB u2(.A(data[15:8]),.B(weight[15:8]),.result(product1));
        MULTB u3(.A(data[23:16]),.B(weight[23:16]),.result(product2));
        BA u4(.A(product0),.B(product1),.result(sum0));
        BA u5(.A(product2),.B(sum0),.result(sum1));
        always @(posedge clk )begin
            if (reset == 1'b1)begin
                result <= 20'b00000000000000000000;
                count <= 2'b00;
            end
            else if(count == 2'b11)begin
                count <=2'b00;
                result <= 20'b00000000000000000000;
            end 
            else begin
                result <= result + sum1;
                count <= count +1'b1;
            end
        end


endmodule

module BA(
    input signed [15:0]A,
    input signed [15:0]B,
    output reg signed [15:0]result
);
    always @(*)begin
    result = A+B;
    end

endmodule 
module D2C(
    input [199:0]f,
    input [71:0]w,
    input clk,
    output [179:0]result
);
    wire rst=1'b0;
    wire [19:0] result99,result1,result2,result3,result4,result5,result6,result7,result8,result9,result10,result11,result12,result13,result14,result15,result16,result17,result18,result19,result20,result21,result22,result23,result24,result25,result26;
    
   
    MAC mac1(.clk(clk),.reset(rst),.data({f[7:0],f[15:8],f[23:16]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result99));
    MAC mac2(.clk(clk),.reset(rst),.data({f[47:40],f[55:48],f[63:56]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result1));
    MAC maci(.clk(clk),.reset(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result2));
  
    assign result[19:0]= result99+result1+result2;

    MAC mac3(.clk(clk),.reset(rst),.data({f[15:8],f[23:16],f[31:24]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result3));
    MAC mac4(.clk(clk),.reset(rst),.data({f[55:48],f[63:56],f[71:64]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result4));
    MAC mac5(.clk(clk),.reset(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result5));
    
    assign result[39:20]= result3+result4+result5;

    MAC mac6(.clk(clk),.reset(rst),.data({f[23:16],f[31:24],f[39:32]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result6));
    MAC mac7(.clk(clk),.reset(rst),.data({f[63:56],f[71:64],f[79:72]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result7));
    MAC mac8(.clk(clk),.reset(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result8));
    
    assign result[59:40]= result8+result6+result7;

    MAC mac9(.clk(clk),.reset(rst),.data({f[47:40],f[55:48],f[63:56]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result9));
    MAC mac10(.clk(clk),.reset(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result10));
    MAC mac11(.clk(clk),.reset(rst),.data({f[127:120],f[135:128],f[143:136]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result11));

    assign result[79:60]= result9+result10+result11;

    MAC mac12(.clk(clk),.reset(rst),.data({f[55:48],f[63:56],f[71:64]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result12));
    MAC mac13(.clk(clk),.reset(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result13));
    MAC mac14(.clk(clk),.reset(rst),.data({f[135:128],f[143:136],f[151:144]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result14));

    assign result[99:80]= result12+result13+result14;

    MAC mac15(.clk(clk),.reset(rst),.data({f[63:56],f[71:64],f[79:72]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result15));
    MAC mac26(.clk(clk),.reset(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result16));
    MAC maci7(.clk(clk),.reset(rst),.data({f[143:136],f[151:144],f[159:152]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result17));

    assign result[119:100]= result15+result16+result17;

    MAC mac111(.clk(clk),.reset(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result18));
    MAC mac2a(.clk(clk),.reset(rst),.data({f[127:120],f[135:128],f[143:136]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result19));
    MAC maciv(.clk(clk),.reset(rst),.data({f[167:160],f[175:168],f[183:176]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result20));

   assign result[139:120]= result18+result19+result20;

    MAC mac1f(.clk(clk),.reset(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result21));
    MAC mac2e(.clk(clk),.reset(rst),.data({f[135:128],f[143:136],f[151:144]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result22));
    MAC mactt(.clk(clk),.reset(rst),.data({f[175:168],f[183:176],f[191:184]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result23));

    assign result[159:140]= result21+result22+result23;

    MAC mac1a(.clk(clk),.reset(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result24));
    MAC mac2g(.clk(clk),.reset(rst),.data({f[143:136],f[151:144],f[159:152]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result25));
    MAC macff(.clk(clk),.reset(rst),.data({f[183:176],f[191:184],f[199:192]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result26));

    assign result[179:160]= result24+result25+result26;


endmodule 