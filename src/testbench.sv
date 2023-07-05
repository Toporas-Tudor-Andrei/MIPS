module testbench();
 
  //Complex Ichip1(clk,clk2,clk3,clk4,D);
  signExtend sg(in, out);
  Mux21 #(8) mux (a,b,sel,mOut);
  shiftLeft2 sl2(shiftInp, sOut);
  
  instrMem imem(addr, instr);
  
  reg sel;
  reg[7:0] a,b;
  reg[15:0] in;
  reg[25:0] shiftInp;
  reg[31:0] addr;
  wire[7:0] mOut;
  wire[27:0] sOut;
  wire[31:0] out, instr;
  
  initial begin
    $dumpfile("dump.vcd");
    addr = 0;
    $dumpvars(imem.mem[3]);
    #10 in = 16'h00ed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'hffed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'h0001;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'hff00;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'h7fed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'h80ed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'hafed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'hbced;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    #10 in = 16'hceed;
    {a,b} = in;
    sel = 1'b1;
    #10sel = 1'b0;
    $finish(1);
  end
  
endmodule