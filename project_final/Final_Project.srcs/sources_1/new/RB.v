//`timescale 1ns / 1ps


//module RB(
//    input [7:0] InA,InB,CUconst,ALUout,
//    input [2:0] InMuxAdd,
//    input WE,clk,reset,
//    input [3:0] RegAdd
//    );

//    wire [15:0] Decoderout;
//    wire [7:0] Muxout1;
//    wire [127:0] Registersout;
//    genvar i;
//    generate
//        for(i=0;i<16;i=i+1) begin
//            (* dont_touch="true" *) Register REG(.En(Decoderout[i]),.clk(clk),.reset(reset),.Rin(Muxout1),.Rout(Registersout[(8*i+7):(8*i)]));
//        end
//    endgenerate

//    (* dont_touch="true" *) Decoder4 DEC1(.WE(WE),);
//endmodule



//module Register(
//    input  En,
//    input  clk,
//    input  reset,
//    input [7:0] Rin,   
//    output reg [7:0] Rout
//  ); 
  
//  always @(posedge clk or posedge reset) begin
  
//    if (reset) begin  
//      Rout <= 8'h00;
//    end
    
//    else if (En == 1'b1) begin
//      Rout <= Rin;
//    end 
//  end
  
//endmodule

//module Decoder4(
//    input  WE,
//    input [3:0] RegAdd,
//    output reg [15:0] r
//  ); 

//   always @(*)
//      if (WE == 1'b0) begin
//         r <= 16'h0000;
//      end
//      else
//         case (RegAdd)
//            4'b0000  : r <= 16'b0000000000000001;
//            4'b0001  : r <= 16'b0000000000000010;
//            4'b0010  : r <= 16'b0000000000000100;
//            4'b0011  : r <= 16'b0000000000001000;
//            4'b0100  : r <= 16'b0000000000010000;
//            4'b0101  : r <= 16'b0000000000100000;
//            4'b0110  : r <= 16'b0000000001000000;
//            4'b0111  : r <= 16'b0000000010000000;
//            4'b1000  : r <= 16'b0000000100000000;
//            4'b1001  : r <= 16'b0000001000000000;
//            4'b1010  : r <= 16'b0000010000000000;
//            4'b1011  : r <= 16'b0000100000000000;
//            4'b1100  : r <= 16'b0001000000000000;
//            4'b1101  : r <= 16'b0010000000000000;
//            4'b1110  : r <= 16'b0100000000000000;
//            4'b1111  : r <= 16'b1000000000000000;
//            default  : r <= 16'b0000000000000000;
//         endcase

//endmodule

//module MUX8_8(
//    input [2:0] InsSel,
//    input [7:0] i1,
//    input [7:0] i2,
//    input [7:0] i3,
//    input [7:0] i4,
//    input [7:0] i5,
//    input [7:0] i6,
//    input [7:0] i7,
//    input [7:0] i8,
//    output reg [7:0] r
//  ); 
    
//   always @(*)
//       case (InsSel)
//          3'b000: r = i1;
//          3'b001: r = i2;
//          3'b010: r = i3;
//          3'b011: r = i4;
//          3'b100: r = i5;
//          3'b101: r = i6;
//          3'b110: r = i7;
//          3'b111: r = i8;
//       endcase    
    
//endmodule

//module MUX16_8(
//    input [3:0] InsSel,
//    input [7:0] i1,
//    input [7:0] i2,
//    input [7:0] i3,
//    input [7:0] i4,
//    input [7:0] i5,
//    input [7:0] i6,
//    input [7:0] i7,
//    input [7:0] i8,
//    input [7:0] i9,
//    input [7:0] i10,
//    input [7:0] i11,
//    input [7:0] i12,
//    input [7:0] i13,
//    input [7:0] i14,
//    input [7:0] i15,
//    input [7:0] i16,
//    output reg [7:0] r
//  ); 
    
//   always @(*)
//       case (InsSel)
//          4'b0000: r = i1;
//          4'b0001: r = i2;
//          4'b0010: r = i3;
//          4'b0011: r = i4;
//          4'b0100: r = i5;
//          4'b0101: r = i6;
//          4'b0110: r = i7;
//          4'b0111: r = i8;
//          4'b1000: r = i9;
//          4'b1001: r = i10;
//          4'b1010: r = i11;
//          4'b1011: r = i12;
//          4'b1100: r = i13;
//          4'b1101: r = i14;
//          4'b1110: r = i15;
//          4'b1111: r = i16;
//       endcase    
    
//endmodule


/*`timescale 1ns / 1ps
module RB(

    input clk,reset,WE, 
	input [7:0]InA,InB,CUconst,ALUout,
	input [2:0]InMuxAdd, 
	input [3:0]RegAdd,OutMuxAdd,  
	output [7:0]Out,ALUinA,ALUinB 
    );
	
	wire [15:0]decoder_out;          
	wire [7:0]RegOut;              
	wire [7:0]RegIn;               
	wire [7:0]Reg_mux [15:0];    

	
	DECODER decoder1(RegAdd,WE,decoder_out);		
	MUX8  mux_8(InA ,InB, CUconst ,ALUout ,RegOut ,RegOut ,RegOut ,RegOut ,InMuxAdd ,RegIn );																
	MUX16  mux_16(Reg_mux[0],Reg_mux[1],Reg_mux[2],Reg_mux[3],Reg_mux[4],Reg_mux[5],Reg_mux[6],Reg_mux[7],Reg_mux[8],Reg_mux[9],Reg_mux[10],Reg_mux[11],Reg_mux[12],Reg_mux[13],Reg_mux[14],Reg_mux[15],OutMuxAdd ,RegOut );
	                           
    genvar i;
    generate 
        for (i=0;i<16;i=i+1) begin    
        REGISTER register(clk,reset,decoder_out[i],RegIn,Reg_mux[i]);
    end 
    endgenerate										


	assign Out = Reg_mux[0]; 
	assign ALUinA = Reg_mux[1];
	assign ALUinB = Reg_mux[2];

endmodule

module DECODER(
	input [3:0]RegAdd,
	input WE,
	output reg [15:0]Out
    );

    always @(*) begin
        if(WE == 0)
            Out = 0; 
        else begin
            case(RegAdd)
                4'b0000: Out = 16'b0000000000000001;
                4'b0001: Out = 16'b0000000000000010;
                4'b0010: Out = 16'b0000000000000100;
                4'b0011: Out = 16'b0000000000001000;
                4'b0100: Out = 16'b0000000000010000;
                4'b0101: Out = 16'b0000000000100000;
                4'b0110: Out = 16'b0000000001000000;
                4'b0111: Out = 16'b0000000010000000;
                4'b1000: Out = 16'b0000000100000000;
                4'b1001: Out = 16'b0000001000000000;
                4'b1010: Out = 16'b0000010000000000;
                4'b1011: Out = 16'b0000100000000000;
                4'b1100: Out = 16'b0001000000000000;
                4'b1101: Out = 16'b0010000000000000;
                4'b1110: Out = 16'b0100000000000000;
                4'b1111: Out = 16'b1000000000000000;
            endcase
        end
    end
endmodule



module MUX8 (
   
	input [7:0]I0,
	input [7:0]I1,
	input [7:0]I2,
	input [7:0]I3,
	input [7:0]I4,
	input [7:0]I5,
	input [7:0]I6,
	input [7:0]I7,
	input [2:0]S,
	output reg [7:0]O
    );

    always @(*) begin
        case(S)
            3'b000: O = I0;
            3'b001: O = I1;
            3'b010: O = I2;
            3'b011: O = I3;
            3'b100: O = I4;
            3'b101: O = I5;
            3'b110: O = I6;
            3'b111: O = I7;
        endcase
    end
endmodule


module MUX16 (
   
	input [15:0]I0,
	input [15:0]I1,
	input [15:0]I2,
	input [15:0]I3,
	input [15:0]I4,
	input [15:0]I5,
	input [15:0]I6,
	input [15:0]I7,
	input [15:0]I8,
	input [15:0]I9,
	input [15:0]I10,
	input [15:0]I11,
	input [15:0]I12,
	input [15:0]I13,
	input [15:0]I14,
	input [15:0]I15,
	input [3:0]S,
	output reg [15:0]O
    );
    always @(*) begin
        case(S)
            4'b0000: O = I0;
            4'b0001: O = I1;
            4'b0010: O = I2;
            4'b0011: O = I3;
            4'b0100: O = I4;
            4'b0101: O = I5;
            4'b0110: O = I6;
            4'b0111: O = I7;
            4'b1000: O = I8;
            4'b1001: O = I9;
            4'b1010: O = I10;
            4'b1011: O = I11;
            4'b1100: O = I12;
            4'b1101: O = I13;
            4'b1110: O = I14;
            4'b1111: O = I15;
        endcase
    end

endmodule


module REGISTER(
	input clk,
	input reset,
	input En,
	input [7:0] Rin,
	output reg [7:0] Rout
    );

    reg [7:0]reg_next;
    reg [7:0]reg_out;
    always @(posedge clk, posedge reset) begin
        if(reset==1)
            reg_out <= 0;
        else
            reg_out <= reg_next;
    end
    always @(*) begin
        if(En)
            reg_next = Rin;
        else
            reg_next = reg_out;
    end
    
    always @(*) begin
        Rout = reg_out;
    end
    
endmodule

*/


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2018 14:56:44
// Design Name: 
// Module Name: RB
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


module RB(
    input clk,
    input reset,
    input [7:0] InA,
    input [7:0] InB,
    input [7:0] CUconst,
    input [2:0] InMuxAdd,
    input [3:0] OutMuxAdd,
    input [3:0] RegAdd,
    input WE,
    output [7:0] ALUinA,
    output [7:0] ALUinB,
    input [7:0] ALUout,
    output [7:0] Out
    );
    
wire [15:0] DecoderOut;    
wire [127:0] RegistersOut;    
wire [7:0] MUXOut1;    
wire [7:0] MUXOut2;    
    
   genvar i;
    generate
       for (i=0; i < 16; i=i+1)
       begin: Registers
          (* dont_touch="true" *) Register REG( DecoderOut[i], clk, reset, MUXOut1,RegistersOut[(8*i+7):(8*i)]);
       end
    endgenerate    
    
(* dont_touch="true" *)    Decoder4 DEC1 (WE, RegAdd, DecoderOut);
(* dont_touch="true" *)    MUX8_8 MUX1  (InMuxAdd, InA, InB, CUconst, ALUout, MUXOut2, MUXOut2, MUXOut2, MUXOut2, MUXOut1);
(* dont_touch="true" *)    MUX16_8 MUX2 (OutMuxAdd,RegistersOut[7:0]
                                                  ,RegistersOut[15:8] 
                                                  ,RegistersOut[23:16] 
                                                  ,RegistersOut[31:24] 
                                                  ,RegistersOut[39:32] 
                                                  ,RegistersOut[47:40] 
                                                  ,RegistersOut[55:48] 
                                                  ,RegistersOut[63:56] 
                                                  ,RegistersOut[71:64] 
                                                  ,RegistersOut[79:72] 
                                                  ,RegistersOut[87:80] 
                                                  ,RegistersOut[95:88] 
                                                  ,RegistersOut[103:96] 
                                                  ,RegistersOut[111:104] 
                                                  ,RegistersOut[119:112] 
                                                  ,RegistersOut[127:120], MUXOut2);
     
    assign Out = RegistersOut[7:0];
    assign ALUinA = RegistersOut[15:8];
    assign ALUinB = RegistersOut[23:16];
    
    
endmodule



module MUX8_8(
    input [2:0] InsSel,
    input [7:0] i1,
    input [7:0] i2,
    input [7:0] i3,
    input [7:0] i4,
    input [7:0] i5,
    input [7:0] i6,
    input [7:0] i7,
    input [7:0] i8,
    output reg [7:0] r
  ); 
    
   always @(*)
       case (InsSel)
          3'b000: r = i1;
          3'b001: r = i2;
          3'b010: r = i3;
          3'b011: r = i4;
          3'b100: r = i5;
          3'b101: r = i6;
          3'b110: r = i7;
          3'b111: r = i8;
       endcase    
    
endmodule

module MUX16_8(
    input [3:0] InsSel,
    input [7:0] i1,
    input [7:0] i2,
    input [7:0] i3,
    input [7:0] i4,
    input [7:0] i5,
    input [7:0] i6,
    input [7:0] i7,
    input [7:0] i8,
    input [7:0] i9,
    input [7:0] i10,
    input [7:0] i11,
    input [7:0] i12,
    input [7:0] i13,
    input [7:0] i14,
    input [7:0] i15,
    input [7:0] i16,
    output reg [7:0] r
  ); 
    
   always @(*)
       case (InsSel)
          4'b0000: r = i1;
          4'b0001: r = i2;
          4'b0010: r = i3;
          4'b0011: r = i4;
          4'b0100: r = i5;
          4'b0101: r = i6;
          4'b0110: r = i7;
          4'b0111: r = i8;
          4'b1000: r = i9;
          4'b1001: r = i10;
          4'b1010: r = i11;
          4'b1011: r = i12;
          4'b1100: r = i13;
          4'b1101: r = i14;
          4'b1110: r = i15;
          4'b1111: r = i16;
       endcase    
    
endmodule



module Decoder4(
    input  WE,
    input [3:0] RegAdd,
    output reg [15:0] r
  ); 

   always @(*)
      if (WE == 1'b0) begin
         r <= 16'h0000;
      end
      else
         case (RegAdd)
            4'b0000  : r <= 16'b0000000000000001;
            4'b0001  : r <= 16'b0000000000000010;
            4'b0010  : r <= 16'b0000000000000100;
            4'b0011  : r <= 16'b0000000000001000;
            4'b0100  : r <= 16'b0000000000010000;
            4'b0101  : r <= 16'b0000000000100000;
            4'b0110  : r <= 16'b0000000001000000;
            4'b0111  : r <= 16'b0000000010000000;
            4'b1000  : r <= 16'b0000000100000000;
            4'b1001  : r <= 16'b0000001000000000;
            4'b1010  : r <= 16'b0000010000000000;
            4'b1011  : r <= 16'b0000100000000000;
            4'b1100  : r <= 16'b0001000000000000;
            4'b1101  : r <= 16'b0010000000000000;
            4'b1110  : r <= 16'b0100000000000000;
            4'b1111  : r <= 16'b1000000000000000;
            default  : r <= 16'b0000000000000000;
         endcase

endmodule



module Register(
    input  En,
    input  clk,
    input  reset,
    input [7:0] Rin,   
    output reg [7:0] Rout
  ); 
  
  always @(posedge clk or posedge reset) begin
  
    if (reset) begin  
      Rout <= 8'h00;
    end
    
    else if (En == 1'b1) begin
      Rout <= Rin;
    end 
  end
  
endmodule

