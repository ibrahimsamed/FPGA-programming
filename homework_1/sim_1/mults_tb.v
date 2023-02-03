`timescale 1ns / 1ps


module tb_MULTS(
    );
    reg [7:0]A,X;
    wire [15:0]R;

   // MULTS uut(.A(A),.X(X),.R(R));
   // MULTS_signed uut(.A(A),.X(X),.R(R));
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
        A=8'd174; X=8'd255; #10;
        if(R==16'd44370)
            $display("TRUE",A,X,R);
        else 
            $display("FALSE",A,X,R);
        #10;
        $finish;
    end
endmodule

module tb_MAC();
    reg clk,rst;
    reg [23:0] data,weight;
    wire  [19:0] result;
   
    MAC uut(.clk(clk),.rst(rst),.data(data),.weight(weight),.result(result));
    initial clk <= 0 ; always #5 clk <= ~clk;
    initial begin
        
        data = 24'b1010_1010_1010_1010_1010_1010;
        weight= 24'b1010_1010_1010_1010_1010_1010;
        #40;
        $finish;
    end
endmodule



