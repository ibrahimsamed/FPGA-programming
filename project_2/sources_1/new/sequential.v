`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2022 13:58:46
// Design Name: 
// Module Name: sequential
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

// A=0101, B= 0100

module seq(
input  x,
input reset,clk,
output reg y
    );
    /*
localparam A = 4'b0000;
localparam B = 4'b0001; 
localparam C = 4'b0010; 
localparam D = 4'b0011; 
localparam E = 4'b0100; 
localparam F = 4'b0101;
localparam G = 4'b0110; 
localparam H = 4'b0111; 
localparam I = 4'b1000; 
localparam L = 4'b1001; 
localparam LOCK = 4'b1010; 
reg state ;
*/
reg [3:0] state;
    always @(posedge clk, posedge reset) begin
        if(reset)   begin
        state <=4'b0000;
        y <=0;
        end
        else begin
        case(state)
        4'b0000    : begin 
            if(x) begin
                state<=4'b0001; 
                y<=0;
                end
            else begin
                state<=4'b0000;
                y<=0;
                end
        end
        4'b0001   : begin 
            if(x) begin
                state<=4'b0001; 
                y<=0;
                end
            else begin
                state<=4'b0010; 
                y<=0;
                end
        end
        4'b0010   : begin 
            if(x) begin
                state<=4'b0011; 
                y<=1;
                end
            else begin
                state<=4'b0100; 
                y<=1;
                end
            end
        4'b0011   : begin 
            if(x) begin
                state<=4'b0110; 
                y<=0;
                end
            else begin
                state<=4'b0101; 
                y<=0;
                end
            end
        4'b0100    : begin 
            if(x) begin
                state<=4'b1000; 
                y<=0;
                end
            else begin
                state<=4'b0111; 
                y<=0;
                end
            end
        4'b0101    : begin 
            if(x) begin
                state<= 4'b1010; 
                y<=1;
                end
            else begin
                state<=4'b0111; 
                y<=1;
                end
            end  
        4'b0110    : begin
            if(x) begin
                state<=4'b0001;
                y<=0;
                end
            else begin
                state<=4'b0000; 
                y<=0;
                end
            end
        4'b0111    : begin 
            if(reset) begin
                state<=4'b0001; 
                y<=0;
                end
            else begin
                state<=4'b0000; 
                y<=0;
                end
            end 
        4'b1000    : begin 
            if(reset) begin
                state<=4'b0001; 
                y<=0;
                end
            else begin
                state<=4'b1001; 
                y<=0;
                end
            end 
        4'b1001    : begin 
            if(x) begin
                state<=4'b0011; 
                y<=1;
                end
            else begin
                state<= 4'b1010; 
                y<=1;
                end
            end  
        4'b1010    : begin
            if(reset) begin
                state<=4'b0000;
                y<=0;
                end
            else begin
                state<= 4'b1010; 
                y<=1;
                end
            end
            default   : begin 
                    state<=4'b0000;
                    y<=0;
                    end    
           
        endcase
        end
    end 
endmodule

