module testbench();
 
  //Complex Ichip1(clk,clk2,clk3,clk4,D);
  signExtend sg(in, out);
  
  
  reg[15:0] in;
  wire[31:0] out;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #10 in = 16'h00ed;
    #10 in = 16'hffed;
    #10 in = 16'h0001;
    #10 in = 16'hff00;
    #10 in = 16'h7fed;
    #10 in = 16'h80ed;
    #10 in = 16'hafed;
    #10 in = 16'hbced;
    #10 in = 16'hceed;
    $finish(1);
  end
  
endmodule