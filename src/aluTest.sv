module ALUtest();
  reg[5:0] func;
  reg[1:0]aluop;
  reg[31:0] a,b;
  wire zero;
  wire[2:0] aluctrl;
  wire[31:0] res;
  
  ALU alu(a ,b ,aluctrl, res, zero);
  ALU_control ctrl(func, aluop, aluctrl);
  initial begin
    $dumpfile("aluDump.vcd");
    $dumpvars;
    a = 32'h00000045;
    b = 32'h00000085;
    aluop = 2'b10;
    
    
    func = 6'b100000;
    #10
    func = 6'b100010;
    #10
    func = 6'b100100;
    #10
    func = 6'b100101;
    #10
    func = 6'b101010;
    #10
    func = 6'b111111;
    #10
    aluop = 2'b00;
    #10
    aluop = 2'b01;
    #10
    $finish(1);
  end
endmodule