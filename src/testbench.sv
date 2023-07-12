module testbench();
  mips chip(clk);
  
  reg clk;
  
  integer i;
  
  initial begin
    clk = 1'bz;
    #5 clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  initial begin 
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    for(i = 0; i < 32; i = i + 1)
      $dumpvars(0,chip.registers.regBach[i]);
    for(i = 0; i < 32; i = i + 1)
      $dumpvars(0,chip.memoryData.dmem[i]);
    #120
    $finish;
  end
endmodule