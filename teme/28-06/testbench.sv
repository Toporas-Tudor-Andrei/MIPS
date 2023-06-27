module testbench();
 
  //Complex Ichip1(clk,clk2,clk3,clk4,D);
  SISO siso(in, clk, out1);
  SIPO sipo(in, clk, out2);
  PISO piso(in2, pl1, clk, out3);
  PIPO pipo(in3, pl2, clk, out4);
  
  
  reg in;
  reg[3:0] in2;
  reg[3:0] in3;
  reg clk;
  reg pl1;
  reg pl2;
  wire out1;
  wire [3:0] out2;
  wire out3;
  wire[3:0] out4;
  
  initial clk = 1'b0;
  initial in = 1'b0;
  initial in2 = 4'b1010;
  initial in3 = 4'b1100;
  initial pl1 = 1'b1;
  initial pl2 = 1'b1;
  
  initial forever #5 clk = ~clk;
  initial forever #30 in = ~in;
  initial forever #40 in2 = {in2[2:0], ~in2[3]};
  initial forever #50 in3 = {~in3[2], ~in3[3:1]};
  initial forever begin
    #40 pl1 = ~pl1;
    #10 pl1 = ~pl1;
  end
  initial forever #30 pl2 = ~pl2;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #10 pl1 = ~pl1;
    #200;
    $finish(1);
  end
  
endmodule