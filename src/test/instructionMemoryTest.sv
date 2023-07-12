module testbench();
  instrMem imem(addr, clk, instr);
  
  reg clk;
  reg[31:0] addr;
  wire[31:0] instr;
  
  initial begin
    clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  task dumpMem;
    integer i;
    for(i = 0; i < 16; i = i + 1)
      $dumpvars(0,imem.mem[i]);
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    dumpMem();
    $dumpvars;
    #5 addr = 0;
    #10 addr = 1;
    #10 addr = 2;
    #10 addr = 3;
    #10 addr = 4;
    #50
    $finish;
  end
endmodule
