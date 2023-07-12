module control(input[5:0] opcode,
               input clk,
               output RegDst,
               output Jump,
               output Branch,
               output MemRead,
               output MemtoReg,
               output[1:0] ALUOp,
               output MemWrite,
               output ALUSrc,
               output RegWrite);
  
  reg [9:0] controls;
  
  initial begin
    controls = 10'b0000000000;
  end
  
  assign {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite} = controls;
  
  always@(opcode)begin
    case(opcode)//TODO: implement more instructions
      6'b111111: controls <= 10'b0_0_0_0_0_00_0_0_0;//NOP
      6'b000000: controls <= 10'b1_0_0_0_0_10_0_0_1;//R Type
      6'b001000: controls <= 10'b0_0_0_0_0_00_0_1_1;//ADDI
      6'b100011: controls <= 10'b0_0_0_1_1_00_0_1_1;//LW
      6'b101011: controls <= 10'b0_0_0_0_0_00_1_1_0;//SW
      6'b000100: controls <= 10'b0_0_1_0_0_01_0_0_0;//BEQ
      6'b000010: controls <= 10'b0_1_0_0_0_00_0_0_0;//JUMP
      default: controls <= 10'bx_x_x_x_x_xx_x_x_x;
    endcase
  end
endmodule