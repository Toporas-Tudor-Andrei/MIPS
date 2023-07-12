module instrMem(input[31:0] Raddr,
                output[31:0] instr);
  
  reg [7:0] mem[0:63];
  integer i;
  initial begin
    /*for(i = 0; i < 64; i = i + 1)
      mem[i] <= 8'h0;*/
    $readmemh("instr.txt",mem);
    /*for(i=0;i<16;i=i+1)
      $display ("mem[%d]=%h",i,mem[i]);*/
  end
  assign instr[31:24]=mem[Raddr+3];
  assign instr[23:16]=mem[Raddr+2];
  assign instr[15:8]=mem[Raddr+1];
  assign instr[7:0]=mem[Raddr];
endmodule