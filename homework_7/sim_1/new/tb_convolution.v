`timescale 1ns / 1ps


module tb_MULTS(
    );
    reg [7:0]A,X;
    wire [15:0]R;

   // MULTS uut(.A(A),.X(X),.R(R));
   //MULTS_signed uut(.A(A),.X(X),.R(R));
    //MULTB uut(.A(A),.X(X),.R(R));
    initial begin
  
        A=8'b0000_0000; X=8'b0000_0000; #10;
        if(R==16'd0)
            $display("TRUE",A,X,R);
            else 
            $display("FALSE",A,X,R);
        A=8'd4; X=8'd5; #10;
        if(R==16'd5)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        A=8'd11; X=8'd8; #10;
        if(R==16'd88)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        
        A=8'd62; X=8'd23; #10;
        if(R==16'd1426)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        A=8'd174; X=8'd255; #10;
        if(R==16'd44370)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        #10;
        $finish;
    end
endmodule


module tb_MULTB();
    reg[7:0]A,X;
    wire [15:0] R;
   // MULTB uut(.A(A),.X(X),.R(R));
    MULTS_signed uut(.A(A),.X(X),.R(R));
    initial begin
        A=8'b0000_0000; X=8'b0000_0000; #10;
        if(R==16'b0000_0000)
            $display("TRUE",A,X,R);
            else 
            $display("FALSE",A,X,R);
        A=8'b0001_0001; X=8'b0001_0001; #10;
        A=8'b1010_1010; X=8'b1010_1010; #10;
        A=8'b0001_0101; X=8'b0101_1001; #10;
        A=8'b0000_0000; X=8'b0000_0000; #10;
        if(R==16'd0)
            $display("TRUE",A,X,R);
            else 
            $display("FALSE",A,X,R);
        A=8'd4; X=8'd5; #10;
        if(R==16'd20)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        A=8'd11; X=8'd8; #10;
        if(R==16'd88)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);      
        A=8'd62; X=8'd23; #10;
        if(R==16'd1426)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        #10;
        $finish;
    end
endmodule



module MULTS_Signed_tb();
    reg [7:0] A;
    reg [7:0] X;
    wire [15:0] R;
    //MULTS_signed DUT(A,X,R);
            initial
                begin
    A = 8'hAA; X = 8'hAA; #50; 
    A = 8'h01; X = 8'hAA; #50; 
    A = 8'h00; X = 8'hAA; #50;
    A = 8'hFF; X = 8'hFF; #50;
    A = 8'h12; X = 8'h43; #50; 
     A = 8'hBA; X = 8'h1D; #50; 
     A = 8'h00; X = 8'h00; #50;
     A = 8'hB0; X  = 8'h6A; #50;
     A = 8'hFC; X  = 8'hFF; #50;
     A = 8'h02; X  = 8'h43; #50; 
     A = 8'h7F; X = 8'h7F; #50;
     A = 8'h80; X  = 8'h80; #50;
     A = 8'h80; X  = 8'h7F; #50;
     $finish;


    end
endmodule



module tb_MAC();
    reg clk,rst;
    wire  [19:0] result;
    reg [23:0] weight;
    reg [23:0] data;
    MAC uut(.clk(clk),.rst(rst),.data(data),.weight(weight),.result(result));
 
    initial 
    begin
        rst=1'b0;
        clk=1'b0;
        data=24'd0;
        weight=-24'd1;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd4;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd0;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd1;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd8;
        weight=24'd8;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd0;
        weight=-24'd1;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd0;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd5;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        data=24'd5;
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        
        
        $finish;
    end

endmodule




module tb_D2C();
    reg clk;
    wire  [179:0] result;
    reg [71:0] w;
    reg [199:0] f;
    D2C uut(.clk(clk),.f(f),.w(w),.result(result));
 
    initial 
    begin
        
        clk=1'b0;
        f[7:0]=8'd128;f[15:8]=8'd128;f[23:16]=8'd128;f[31:24]=8'd128;f[39:32]=8'd128;
        f[47:40]=8'd255;f[55:48]=8'd255;f[63:56]=8'd128;f[71:64]=8'd255;f[79:72]=8'd255;
        f[87:80]=8'd255;f[95:88]=8'd255;f[103:96]=8'd128;f[111:104]=8'd255;f[119:112]=8'd255;
        f[127:120]=8'd255;f[135:128]=8'd255;f[143:136]=8'd128;f[151:144]=8'd255;f[159:152]=8'd255;
        f[167:160]=8'd255;f[175:168]=8'd255;f[183:176]=8'd128;f[191:184]=8'd255;f[199:192]=8'd255;
        w[7:0]=-8'd1;w[15:8]=-8'd1;w[23:16]=-8'd1;w[31:24]=-8'd1;w[39:32]=8'd8;
        w[47:40]=-8'd1;w[55:48]=-8'd1;w[63:56]=-8'd1;w[71:64]=-8'd1;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        clk=1'b0;
        #10
        clk=1'b1;
        #10
        
        clk=1'b0;
        #10
        if(result[19:0]==20'd635)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
         if(result[39:20]==-20'd508)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
        if(result[59:40]==20'd635)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
        if(result[79:60]==20'd381)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
        if(result[99:80]==-20'd762)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
            if(result[119:100]==20'd381)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
            if(result[139:120]==20'd381)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
            if(result[159:140]==-20'd762)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
            if(result[179:160]==20'd381)
            $display("TRUE",f,w,result);
        else 
            $display("FALSE",f,w,result);
        $finish;
     end

endmodule



