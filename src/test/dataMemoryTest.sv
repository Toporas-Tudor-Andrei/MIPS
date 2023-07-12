module testbench();
  dataMem dmem(adr, write, w, r, clk, read);
  
  reg[31:0] adr, write;
  reg w, r, clk;
  wire[31:0] read;
  
  initial begin
    clk = 1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  task dumpMem;
    integer i;
    for(i = 0; i < 16; i = i + 1)
      $dumpvars(0,dmem.dmem[i]);
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    dumpMem();
    $dumpvars;
    $finish;
  end
endmodule