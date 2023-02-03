`timescale 1ns / 1ps



module testbench;
    reg [15:0] Ax [199:0];
    reg [15:0]A;
    reg [15:0]B;
    wire [31:0]P;
    integer i;
    ARM uut(.A(A),.B(B),.P(P));
    initial
    begin
        
        $readmemb("testbenchvector.mem",Ax);
        for(i=0;i<200;i=i+2)begin
        A=Ax[i];
        B=Ax[i+1];
        $write("Abin=%b,  Adec=%d,  Bbin=%b,  Bdec=%d",Ax[i],Ax[i],Ax[i+1],Ax[i+1]);
        #10;
        $display(",  Pbin=%b,  Pdec=%d",P,P);
        end
//        A=16'b1111111111111111;
//        B=16'b1111111111111111;
//        #10
        $finish;
    end
endmodule