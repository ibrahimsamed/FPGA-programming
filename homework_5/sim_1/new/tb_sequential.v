`timescale 1ns / 1ps



module tb_sequential( );
    wire Q,Qn;
    reg R,S;
    SR srnand(S,R,Q,Qn);
    initial begin
    S=0 ;  R = 0;
    #10;  S=1'b0 ;  R = 1'b1;
    #10;  S=1'b1 ;  R = 1'b0;
    #10;  S=1'b1 ;  R = 1'b1;
    $finish;
    end
endmodule

module tb_dlatch( );
    wire Q,Qn;
    reg D,CLK;
    D dlatch(D,CLK,Q,Qn);
    initial CLK <=1; always #5 CLK <= ~CLK;
    initial begin
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    
    end
endmodule


module tb_MSD( );
    wire Q,Qn;
    reg D,CLK;
    MSD msdflipflop(D,CLK,Q,Qn);
    initial CLK <=1; always #5 CLK <= ~CLK;
    initial begin
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    
    end
endmodule

module tb_D_behav( );
    wire Q,Qn;
    reg D,CLK;
    D_behav behav(D,CLK,Q,Qn);
    initial CLK <=1; always #5 CLK <= ~CLK;
    initial begin
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    D=1'b0 ; #10;   D=1'b0;
    #10; D=1'b1; #10;
    
    end
endmodule

module tb_bit() ;
    reg [7:0] IN;
    reg CLK, CLEAR;
    wire [7:0] OUT;
    
    bit reg8(IN,CLK,CLEAR,OUT) ;
    
    initial CLK <= 1 ; always #5 CLK <= ~CLK;
    
    initial begin
    CLEAR=1'b0;#7
    IN=8'd10;#13
    IN=8'd20;#13;
    CLEAR=1'b1;#15
    CLEAR=1'b0;#7
    IN=8'd30;#13
    IN=8'd40;#13; 
    $finish;
    end 
endmodule 


module tb_bram;
    wire [7:0] douta;
    
    reg [3:0] addra = 0;
    reg clka; reg wea = 0;
    integer count = 0;
    
    blk_mem_gen_1 BLK( .clka(clka), .wea(wea), .addra(addra), .douta(douta) );
    
    initial
    begin
    clka = 0;
    forever #5 clka = ~clka;
    end
    initial
    $monitor( $time ,"addra=%b | douta=%b", addra, douta);
    initial
    begin
    while( count<16 )
    begin
    
    addra = count;
    #20 count = count + 1;
    end
    #20 $finish;
    end
endmodule


module tb_sliding_leds;
    wire[15:0] led;
    reg clk;
    reg rst;
    reg [1:0]sw;
    
    sliding_leds leds(.clk(clk),.sw(sw),.rst(rst),.led(led));
endmodule
