`timescale 1ns / 1ps



module MULTS
(
    input [7:0]A,
    input [7:0]X,
    output [15:0]R
    );
    wire [15:0] PP[0:7];
    
    genvar i;
    generate
        for (i=0; i< 8; i=i+1)begin
            assign PP[i] = ({15{X[i]}}&A)<<i;     
        end    
    endgenerate 
    
   wire [15:0]sum1,sum2,sum3,sum4,sum5,sum6;
   wire [6:0]carry=0;
   cla16bit cla1(PP[0],PP[1],0, sum1,carry[0]);
   cla16bit cla2(PP[2],PP[3], 0, sum2,carry[1]);
   cla16bit cla3(PP[4],PP[5], 0, sum3,carry[2]);
   cla16bit cla4(PP[6],PP[7], 0, sum4,carry[3]);
   cla16bit cla5(sum1,sum2, 0, sum5,carry[4]);
   cla16bit cla6(sum3,sum4, 0, sum6,carry[5]);
   cla16bit cla7(sum5,sum6, 0, R,carry[6]);

endmodule


module cla16bit(a,b, cin, sum,cout);
input [15:0] a,b;
input cin;
output [15:0] sum;
output cout;
wire c1,c2,c3;

carry_look_ahead_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1));
carry_look_ahead_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2));
carry_look_ahead_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3));
carry_look_ahead_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout));

endmodule


module carry_look_ahead_4bit(a,b, cin, sum,cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;

wire [3:0] p,g,c;

assign p=a^b;//propagate
assign g=a&b; //generate

//carry=gi + Pi.ci

assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;

endmodule

module MULTS_signed (
    input [7:0] A,X,
    output [15:0] R);
    wire [7:0] PP[7:0];
    wire [15:0] PP_shifted[7:0];
    wire [15:0]sum[6:0];
    
    genvar i;
    generate
        for (i=0; i< 7; i=i+1)begin
            assign PP[i][6:0]= (X[i]*A[6:0]); 
            assign PP[i][7] = ~(X[i] * A[7]);
        end 
        assign PP[7][6:0] = ~(X[7] * A[6:0]); 
        assign PP[7][7] = X[7]*A[7];   
    endgenerate 
    
    generate
        for(i=0; i<=7; i=i+1)
        begin
        if(i==0)   begin
        assign PP_shifted[i][7:0] = PP[i][7:0];
        assign PP_shifted[i][8]=1'b1;
        assign PP_shifted[i][15:9] = 7'd0;
            end
        else
        assign PP_shifted[i] = PP[i] << i;
        end
    endgenerate
    wire cout[6:0]; 
    genvar j; 
    generate
        for(j=0; j<4; j = j+1) 
        begin
        cla16bit cla0(.a(PP_shifted[j]), .b(PP_shifted[j+4]), .cin(1'b0), .sum(sum[j]), .cout(cout[j]));
        end
    endgenerate
    cla16bit cl1(.a(sum[0]), .b(sum[1]), .cin(1'b0),  .sum(sum[4]),.cout(cout[4])); 
    cla16bit cl2(.a(sum[2]), .b(sum[3]), .cin(1'b0), .sum(sum[5]),.cout(cout[5])); 
    cla16bit cl3(.a(sum[4]), .b(sum[5]), .cin(1'b0),  .sum(sum[6]),.cout(cout[6])); 
    assign R[14:0] = sum[6][14:0] ;
    assign R[15] = ~sum[6][15]; 
endmodule




module MULTB(
    input signed [7:0] A,
    input signed X,
    output  reg signed [15:0]R
);
    
    always @(*) begin
         
         R = A * X;
    end
endmodule


module MAC(
    input clk,rst,
    input signed [23:0]data,
    input signed [23:0]weight,
    output reg signed [19:0] result
);
    wire signed [15:0]product0,product1,product2;
    wire signed[15:0]suma,sumb;
    reg [1:0]count=2'd0;
    
    initial
    begin
    result = 20'd0;
    end

    MULTB mult1(data[7:0],weight[7:0], product0);
    MULTB mult2(data[15:8],weight[15:8], product1);
    MULTB mult3(data[23:16],weight[23:16], product2);
    AS as1(product0,product1,suma);
    AS as2(suma,product2,sumb);
 
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)begin
                result <= 20'd0;
                count <= 2'd0;
            end
            else if(count == 2'b11)begin
                count <=2'b00;
                result <= 20'd0;
            end 
            else begin
                result <= result + sumb;
                count <= count +1'b1;
            end
    end
endmodule
module AS(
    input signed [15:0]A,B,
    output  signed [15:0]result
);
    assign result = A+B;
endmodule

module D2C(
    input [199:0]f,
    input [71:0]w,
    input clk,
    
    output [179:0]result
);
    wire rst=1'b0;
    wire [19:0] result99,result1,result2,result3,result4,result5,result6,result7,result8,result9,result10,result11,result12,result13,result14,result15,result16,result17,result18,result19,result20,result21,result22,result23,result24,result25,result26;
    
   
    MAC mac1(.clk(clk),.rst(rst),.data({f[7:0],f[15:8],f[23:16]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result99));
    MAC mac2(.clk(clk),.rst(rst),.data({f[47:40],f[55:48],f[63:56]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result1));
    MAC maci(.clk(clk),.rst(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result2));
  
    assign result[19:0]= result99+result1+result2;

    MAC mac3(.clk(clk),.rst(rst),.data({f[15:8],f[23:16],f[31:24]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result3));
    MAC mac4(.clk(clk),.rst(rst),.data({f[55:48],f[63:56],f[71:64]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result4));
    MAC mac5(.clk(clk),.rst(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result5));
    
    assign result[39:20]= result3+result4+result5;

    MAC mac6(.clk(clk),.rst(rst),.data({f[23:16],f[31:24],f[39:32]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result6));
    MAC mac7(.clk(clk),.rst(rst),.data({f[63:56],f[71:64],f[79:72]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result7));
    MAC mac8(.clk(clk),.rst(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result8));
    
    assign result[59:40]= result8+result6+result7;

    MAC mac9(.clk(clk),.rst(rst),.data({f[47:40],f[55:48],f[63:56]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result9));
    MAC mac10(.clk(clk),.rst(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result10));
    MAC mac11(.clk(clk),.rst(rst),.data({f[127:120],f[135:128],f[143:136]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result11));

    assign result[79:60]= result9+result10+result11;

    MAC mac12(.clk(clk),.rst(rst),.data({f[55:48],f[63:56],f[71:64]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result12));
    MAC mac13(.clk(clk),.rst(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result13));
    MAC mac14(.clk(clk),.rst(rst),.data({f[135:128],f[143:136],f[151:144]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result14));

    assign result[99:80]= result12+result13+result14;

    MAC mac15(.clk(clk),.rst(rst),.data({f[63:56],f[71:64],f[79:72]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result15));
    MAC mac26(.clk(clk),.rst(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result16));
    MAC maci7(.clk(clk),.rst(rst),.data({f[143:136],f[151:144],f[159:152]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result17));

    assign result[119:100]= result15+result16+result17;

    MAC mac111(.clk(clk),.rst(rst),.data({f[87:80],f[95:88],f[103:96]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result18));
    MAC mac2a(.clk(clk),.rst(rst),.data({f[127:120],f[135:128],f[143:136]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result19));
    MAC maciv(.clk(clk),.rst(rst),.data({f[167:160],f[175:168],f[183:176]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result20));

   assign result[139:120]= result18+result19+result20;

    MAC mac1f(.clk(clk),.rst(rst),.data({f[95:88],f[103:96],f[111:104]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result21));
    MAC mac2e(.clk(clk),.rst(rst),.data({f[135:128],f[143:136],f[151:144]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result22));
    MAC mactt(.clk(clk),.rst(rst),.data({f[175:168],f[183:176],f[191:184]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result23));

    assign result[159:140]= result21+result22+result23;

    MAC mac1a(.clk(clk),.rst(rst),.data({f[103:96],f[111:104],f[119:112]}),.weight({w[71:64],w[63:56],w[55:48]}),.result(result24));
    MAC mac2g(.clk(clk),.rst(rst),.data({f[143:136],f[151:144],f[159:152]}),.weight({w[47:40],w[39:32],w[31:24]}),.result(result25));
    MAC macff(.clk(clk),.rst(rst),.data({f[183:176],f[191:184],f[199:192]}),.weight({w[23:16],w[15:8],w[7:0]}),.result(result26));

    assign result[179:160]= result24+result25+result26;


endmodule 