`timescale 1ns / 1ps

module testbench;
  reg clk;
  reg reset;
  reg conv_run;
  reg [71:0] kernel;

  wire conv_done;
  wire [1023:0] data_out;
 
  TOP top_unit (
    .clk(clk),
    .reset(reset),
    .conv_run(conv_run),
    .kernel(kernel),
    .conv_done(conv_done),
    .data_out(data_out)
  );

  initial begin
    clk=1'b0;
    kernel[7:0] = -8'd1;kernel[15:8] = -8'd1;kernel[23:16] = -8'd1;kernel[31:24] = -8'd1;kernel[39:32] = 8'd8;kernel[47:40] = -8'd1;kernel[55:48] = -8'd1;kernel[63:56] = -8'd1;kernel[71:64] = -8'd1;
    $fwrite("input_image.txt", kernel);
    #10 reset = 1;
    #10 reset = 0;
    #10 conv_run = 1;
    #10 conv_run = 0;
    #10 conv_run = 1;
  end

  always #5 clk = ~clk;

  initial begin
    $dumpfile("output_image1.txt");
    $dumpvars(0, testbench);
  end
endmodule
