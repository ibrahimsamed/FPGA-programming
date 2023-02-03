`timescale 1ns / 1ps

module  HA(cout,s,x,y);
    input x,y;
    output cout,s;
    xor xor1(s, x,y); 
    and and2(cout, x,y);

endmodule

module  FA(cout,s,x,y,ci);
    input x,y,ci;
    output cout,s;
    wire sum_1,carry_1,carry_2; 
    HA HA1(carry_1,sum_1,x,y);
    HA HA2(carry_2,s,sum_1,ci);
    or or1(cout,carry_2,carry_1);

endmodule


module  RCA(cout,s,x,y,ci);
    input [3:0]x;
    input [3:0]y;
    input ci;
    output cout;
    output [3:0]s;
    wire cout_rca_1,cout_rca_2,cout_rca_3;
    
    FA FA1 (cout_rca_1,s[0],x[0],y[0],ci);
    FA FA2 (cout_rca_2,s[1],x[1],y[1],cout_rca_1);
    FA FA3 (cout_rca_3,s[2],x[2],y[2],cout_rca_2);
    FA FA4 (cout,s[3],x[3],y[3],cout_rca_3);
endmodule



module parametric_RCA(cout,s,x,y,ci);
    parameter SIZE=4;
    input [SIZE-1:0] x, y;
    input ci;
    output cout;
    output [SIZE-1:0]s;
    wire [SIZE-1:1] cout_rca_;
    FA FAa (cout_rca_[1],s[0],x[0],y[0],ci);
    genvar i;
    generate for (i=2;i<SIZE;i=i+1) 
    begin
   
   
    FA FAb (cout_rca_[i],s[i-1],x[i-1],y[i-1],cout_rca_[i-1]);
    end 
    endgenerate 
    FA FAc (cout,s[SIZE-1],x[SIZE-1],y[SIZE-1],cout_rca_[SIZE-1]);
    
    
endmodule


module CLA (cout,s,x,y,ci);
    input [15:0] x,y;
    input ci;
    output cout;
    output [15:0]s;
    wire [15:0] G,P;
    wire [15:0] C;
    assign G[0] = x[0] & y[0];
    assign G[1] = x[1] & y[1];
    assign G[2] = x[2] & y[2];
    assign G[3] = x[3] & y[3];


    assign P[0] = x[0] ^ y[0];
    assign P[1] = x[1] ^ y[1];
    assign P[2] = x[2] ^ y[2];
    assign P[3] = x[3] ^ y[3];
   
    
    assign C[0] = G[0] | (P[0] & ci);
    assign C[1] = G[1] | (P[1] & C[0]);
    assign C[2] = G[2] | (P[2] & C[1]);
    assign C[3] = G[3] | (P[3] & C[2]);
    
    
    
    assign s[0]= P[0] ^ ci;
    assign s[1]= P[1] ^ C[0];
    assign s[2]= P[2] ^ C[1];
    assign s[3]= P[3] ^ C[2];
    assign cout=C[3];
    // EXOR Es_cla(P[0],c0,s_cla[0])
endmodule


module Add_Sub (
    input [3:0]x,
    input [3:0]y,
    input ci,
    output [3:0]s,
    output cout,
    output V     
    );
    wire [3:0] c_fa;
    wire [3:0] i_fa;
    assign i_fa[0]=y[0] ^ ci ;
    assign i_fa[1]=y[1] ^ ci ;
    assign i_fa[2]=y[2] ^ ci ;
    assign i_fa[3]=y[3] ^ ci ;
    FA FA5 (c_fa[0],s[0],x[0],i_fa[0],ci);
    FA FA6 (c_fa[1],s[1],x[1],i_fa[1],c_fa[0]);    
    FA FA7 (c_fa[2],s[2],x[2],i_fa[2],c_fa[1]);
    FA FA8 (c_fa[3],s[3],x[3],i_fa[3],c_fa[2]);
    assign cout= c_fa[3];
    assign V= c_fa[2] ^ c_fa[3];
   
endmodule









