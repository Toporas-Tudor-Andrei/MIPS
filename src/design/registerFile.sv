module Registers(input[4:0] Rreg1,
                 input[4:0] Rreg2,
                 input[4:0] Wreg,
                 input[31:0] Wdata,
                 input RegWrite,
                 input clk,
                 output[31:0] Rdata1,
                 output[31:0] Rdata2);
  
  reg[31:0] regBach[0:31];
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1)
      regBach[i] <= 32'h0;
  end
  
  always@(negedge clk)
    if(RegWrite)begin
      regBach[Wreg] <= Wdata;
      regBach[0] <= 0;
    end
  
  assign Rdata1 = regBach[Rreg1];
  assign Rdata2 = regBach[Rreg2];
  
endmodule