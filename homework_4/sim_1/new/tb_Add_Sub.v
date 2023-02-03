`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2022 06:14:41
// Design Name: 
// Module Name: tb_Add_Sub
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Add_Sub();
    reg[3:0]A,B;
    reg ci;
    wire cout;
    wire [3:0]s;
    wire V;
    Add_Sub UUT(.A(A),.B(B),.ci(ci),.cout(cout),.s(s),.V(V) );    
    
    initial begin
    A=4'd0; B=4'd0; ci=1'b0; 
    #10;
    A=4'd10; B=4'd1;  
    #10;
    A=4'd7;  B=4'd14;  
    #10;
    A=4'd6;  B=4'd5;   
    #10;
    A=4'd2;  B=4'd8;    
     #10;
    A=4'd11; B=4'd11;  
     #10;
    A=4'd3;  B=4'd9;    
     #10;
    A=4'd15; B=4'd15;  
     #10;
    A=4'd0; B=4'd0; ci=1'b1; 
    
    #10;
    A=4'd7;  B=4'd14;  
    #10;
    A=4'd6;  B=4'd5;   
    #10;
    A=4'd2;  B=4'd8;    
     #10;
    A=4'd11; B=4'd11;  
     #10;
    A=4'd3;  B=4'd9;    
     #10;
    A=4'd15; B=4'd15;  
     #10;
    
    $finish;
    end
endmodule
