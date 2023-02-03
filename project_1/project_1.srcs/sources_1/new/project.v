`timescale 1ns / 1ps

(* DONT_TOUCH = "TRUE"*)
module ARM(
        input [15:0]A,
        input [15:0]B,
        output [31:0]P
    );
    wire zero;
    wire one;
    assign one=1'b1;
    assign zero = 1'b0;
    AND and1(.I1(A[0]),.I2(B[0]),.O(P[0]));
    
    genvar i;
    genvar k;
    wire [239:0]Cs;
    wire [239:0]Ss;
    generate
        for(i=0; i<16 ; i=i+1) begin
            for(k=0; k<15; k=k+1 ) begin
                if(i == 0) begin
                    block b(.I1(A[k+1]),.I2(B[i]),.I3(A[k]),.I4(B[i+1]),.Ci(zero),.S(Ss[k]),.C(Cs[k]));
                end
                else if(i == 15 & k == 0)begin
                    block blockj(.I1(Cs[15*(i-1)+k]),.I2(one),.I3(Ss[15*(i-1)+k+1]),.I4(one),.Ci(zero),.S(Ss[15*i+k]),.C(Cs[15*i+k]));
                end
                else if(i==15 & k != 0 & k != 14)begin
                    block blockj(.I1(Cs[15*(i-1)+k]),.I2(one),.I3(Ss[15*(i-1)+k+1]),.I4(one),.Ci(Cs[15*i+k-1]),.S(Ss[15*i+k]),.C(Cs[15*i+k]));
                end
                else if(k == 14 & i != 0 & i != 15)begin
                    block blockj(.I1(A[k+1]),.I2(B[i]),.I3(A[k]),.I4(B[i+1]),.Ci(Cs[15*(i-1)+k]),.S(Ss[15*i+k]),.C(Cs[15*i+k]));
                end
                else if(k == 14 & i ==15)begin
                    block blockj(.I1(A[k+1]),.I2(B[i]),.I3(Cs[15*i+k-1]),.I4(one),.Ci(Cs[15*(i-1)+k]),.S(Ss[15*i+k]),.C(Cs[15*i+k]));
                end
                else begin
                    block blockk(.I1(Ss[15*(i-1)+k+1]),.I2(one),.I3(A[k]),.I4(B[i+1]),.Ci(Cs[15*(i-1)+k]),.S(Ss[15*i+k]),.C(Cs[15*i+k]));
                end
            end
        end
        for(i=0;i<16;i=i+1)begin
            for(k=0;k<15;k=k+1)begin
                if (k == 0)begin
                    assign P[i+k+1]=Ss[15*i+k];
                end
                else if(i == 15 & k != 0 )begin
                    assign P[i+k+1]=Ss[15*i+k];
                end
            end
        end
        assign P[31] = Cs[239];
    endgenerate
endmodule

module block(
    input I1,I2,I3,I4,Ci,
    output S,C
);
    wire I11,I22;
    AND andi(.I1(I1),.I2(I2),.O(I11));
    AND andj(.I1(I3),.I2(I4),.O(I22));
    FA fa1(.X(I11),.Y(I22),.Ci(Ci),.S(S),.Cout(C));
endmodule
