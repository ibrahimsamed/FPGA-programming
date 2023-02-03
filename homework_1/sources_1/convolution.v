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
   cla16bit cla1(PP[0],PP[1], cin, sum1,cout);
   cla16bit cla2(PP[2],PP[3], cin, sum2,cout);
   cla16bit cla3(PP[4],PP[5], cin, sum3,cout);
   cla16bit cla4(PP[6],PP[7], cin, sum4,cout);
   cla16bit cla5(sum1,sum2, cin, sum5,cout);
   cla16bit cla6(sum3,sum4, cin, sum6,cout);
   cla16bit cla7(sum5,sum6, cin, R,cout);

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
    wire [7:0] PP_a[0:7];
    wire [7:0] PP[0:7];
    wire [15:0] PP_shifted[0:7];
    genvar i;
    generate
        for (i=0; i< 8; i=i+1)begin
            assign PP[i] = ({15{X[i]}}&A); 
        end    
    endgenerate 
            assign PP_a[0][7]=~PP[0][7];
            assign PP_a[1][7]=~PP[1][7];
            assign PP_a[2][7]=~PP[2][7];
            assign PP_a[3][7]=~PP[3][7];
            assign PP_a[4][7]=~PP[4][7];
            assign PP_a[5][7]=~PP[5][7];
            assign PP_a[6][7]=~PP[6][7];
            assign PP_a[7][0]=~PP[7][0];
            assign PP_a[7][1]=~PP[7][1];
            assign PP_a[7][2]=~PP[7][2];
            assign PP_a[7][3]=~PP[7][3];
            assign PP_a[7][4]=~PP[7][4];
            assign PP_a[7][5]=~PP[7][5];
            assign PP_a[7][6]=~PP[7][6];
    genvar j;
    generate
        for (j=0; j< 8; j=j+1)begin
            assign PP_shifted[j]=PP_a[j]<<j; 
            
        end    
    endgenerate 

    wire [15:0]sum1,sum2,sum3,sum4,sum5,sum6,sum7;
    cla16bit cla8(PP_shifted[0],PP_shifted[1], cin, sum1,cout);
    cla16bit cla9(PP_shifted[2],PP_shifted[3], cin, sum2,cout);
    cla16bit cla11(PP_shifted[4],PP_shifted[5], cin, sum3,cout);
    cla16bit cla12(PP_shifted[6],PP_shifted[7], cin, sum4,cout);
    cla16bit cla13(sum1,sum2, cin, sum5,cout);
    cla16bit cla14(sum3,sum4, cin, sum6,cout);
    cla16bit cla15(sum5,sum6, cin, R,cout);
endmodule



module MULTB(
    input [7:0] A,X,
    output reg [15:0]R
);
    
    always @(*) begin
         
         R = A * X;
    end
endmodule


module MAC(
    input clk,rst,
    input [23:0]data,//11,data12,data13,data21,data22,data23,data31,data32,data33,
    input [23:0]weight,//11,weight12,weight13,weight21,weight22,weight23,weight31,weight32,weight33,
    output reg [19:0] result
);
    wire [15:0]product0,product1,product2;
    wire [15:0]suma,sumb;
    reg [1:0]count;
    reg [24:0 ] out;
    wire[19:0]R; 
    assign product0 = data[7 : 0] * weight[7 : 0];
    assign product1 = data[15 : 8] * weight[15 : 8];
    assign product2 = data[23 : 16] * weight[23 : 16];
    //MULTB mult1(data[7:0],weight[7:0], product[0]);
    //MULTB mult2(data[15:8],weight[15:8], product[1]);
    //MULTB mult3(data[23:16],weight[23:16], product[2]);
    //assign suma=product[0] + product[1];
    //assign sumb=product[2] + suma;
    //assign result = suma + sumb;
    cla16bit cla16(product0,product1, cin, suma,cout);
    cla16bit cla17(product2,suma, cin, sumb,cout);
    cla16bit cla18(suma,sumb, cin, R,cout);
    always @(posedge clk) begin
        count <= count + 1;
        if (rst) begin
            count <= 0;
            result <=0;
        end
        else begin 
            result<=R;
            out <= result + out;
        end
    
    end


endmodule
/*
module MAC_a (
    input clk,
    input reset,
    input [23:0] data,
    input [23:0] weight,
    output reg [19:0] result
);

    reg [19:0] accumulator;
    reg [1:0] count;
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            result <= 0;
        end else begin
            accumulator <= accumulator + data * weight;
            count <= count + 1;
            result <= accumulator;
        end
    end

endmodule
*/