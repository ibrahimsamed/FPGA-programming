`timescale 1ns / 1ps


 

 module sliding_leds
 (
 
    input clk,
    input rst,
    input [1:0]SW,
    output reg [15:0]LED
       
 );
    reg clk2=1;
    parameter  MAX_CNT_DEST = 5000000;
    reg [$clog2(MAX_CNT_DEST)-1:0]counter=0;
    always@(SW)
    begin
        case(SW)
        2'b00,2'b01: counter <= MAX_CNT_DEST;
        2'b10: counter <= MAX_CNT_DEST/2;
        2'b11: counter <= MAX_CNT_DEST/5;
        endcase
    end
    reg [$clog2(MAX_CNT_DEST)-1:0]counter2=0;

    always@(posedge clk)
    begin
        if(counter2 == counter)
        begin
            clk2 <= ~clk2;
            counter2 <= 0;
        end
        else begin
            counter2 <= counter2 +1;
        end
    end

    reg[3:0]cntr=0;
    always@(posedge clk2 or posedge rst)
    begin
        if(rst)begin
            LED <= 16'b0000000000000001;
        end
        else if(SW==0) begin
            LED <= LED;
        end
        else begin
            if(cntr == 15) begin
                LED <= LED + LED;
                LED <= 16'b0000000000000001;
                cntr <= 0;
            end
            else begin
            LED <= LED+LED;
            cntr <= cntr+1;
            end
        end

    end











 endmodule