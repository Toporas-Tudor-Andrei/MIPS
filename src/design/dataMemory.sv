module dataMem(input[31:0] addr,
               input[31:0] Wdata,
               input MemWrite,
               input MemRead,
               input clk,
               output[31:0] Rdata);
  
  reg[7:0] dmem[0:31];
  
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1)
      dmem[i] <= 8'h0;
  end
  
  always@(negedge clk)begin
    if(MemWrite) begin
      dmem[addr] <= Wdata[7:0];
      dmem[addr+1] <= Wdata[15:8];
      dmem[addr+2] <= Wdata[23:16];
      dmem[addr+3] <= Wdata[31:24];
    end
  end
  assign Rdata[31:24]=MemRead? dmem[addr+3]:8'hxx;
  assign Rdata[23:16]=MemRead? dmem[addr+2]:8'hxx;
  assign Rdata[15:8] =MemRead? dmem[addr+1]:8'hxx;
  assign Rdata[7:0]  =MemRead? dmem[addr]  :8'hxx;
endmodule