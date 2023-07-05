module signExtend(input[15:0] in, output[31:0] out);
  assign out[31:16] = {16{in[15]}};
  assign out[15:0] = in[15:0];
endmodule

module shiftLeft2(input[25:0] in, output[27:0] out);
  assign out = {in, 2'b0};
endmodule

module Mux21 #(parameter SIZE = 5)
  (input[SIZE-1:0]in0, input[SIZE-1:0]in1, input sel, output[SIZE-1:0] out);
  assign out = sel ? in1 : in0;
endmodule

module Adder4(input[31:0] pc, output[31:0] out);
  assign out = pc + 4;
endmodule

module ALU(input[31:0] in1,
           input[31:0] in2,
           input[2:0] ALUctrl,
           output reg[31:0] result,
           output reg zero);
  
  initial begin
    zero = 0;
    result = 0;
  end
  always @(*) begin
    case (ALUctrl)
      3'b000: result = in1 & in2;
      3'b001: result = in1 | in2;
      3'b010: result = in1 + in2;
      //3'b011: out = ; //not used
      3'b100: result = in1 & (~in2);
      3'b101: result = in1 | (~in2);
      3'b110: result = in1 - in2;
      3'b111: result = in1 < in2;
      default: result = 32'hxxxxxxxx;
    endcase
    zero = (result == 32'h00000000);
  end
endmodule

module ALU_control (input [5:0] funct,
                    input [1:0] aluop,
                    output reg [2:0] ALUctrl);
  
  always @ (*)
    case (aluop)
      2'b00: ALUctrl <= 3'b010; // add
      2'b01: ALUctrl <= 3'b110; // sub
      default: case(funct) // RTYPE
        6'b100000: ALUctrl <= 3'b010; // ADD
        6'b100010: ALUctrl <= 3'b110; // SUB
        6'b100100: ALUctrl <= 3'b000; // AND
        6'b100101: ALUctrl <= 3'b001; // OR
        6'b101010: ALUctrl <= 3'b111; // SLT
        default: ALUctrl <= 3'bxxx;
      endcase
    endcase
endmodule

module PC(input[31:0] pc_in,
          input clk,
          output reg[31:0] pc_out);
  
  initial begin
    pc_out = 32'h0;
  end
  
  always@(posedge clk)
      pc_out <= pc_in;
endmodule

module RegMem(input[4:0] Rreg1,
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
      regBach[i] = 32'h0;
  end
  
  always@(posedge clk)
    if(RegWrite)begin
      regBach[Wreg] = Wdata;
      regBach[0] = 0;
    end
  
  assign Rdata1 = regBach[Rreg1];
  assign Rdata2 = regBach[Rreg2];
  
endmodule

module instrMem(input[31:0] Raddr,
                input clk,
                output reg[31:0] instr);
  
  reg [7:0] mem[0:31];
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1)
      mem[i] = 8'h0;
    $readmemh("instr.txt",mem);
  end
  always@(posedge clk)begin
    instr = mem[Raddr];
  end
endmodule

module dataMem(input[31:0] addr,
               input[31:0] Wdata,
               input MemWrite,
               input MemRead,
               input clk,
               output reg[31:0] Rdata);
  
  reg[7:0] dmem[0:31];
  
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1)
      dmem[i] = 8'h0;
  end
  
  always@(posedge clk)begin
    if(MemWrite) begin
      dmem[addr] = Wdata[7:0];
      dmem[addr+1] = Wdata[15:8];
      dmem[addr+2] = Wdata[23:16];
      dmem[addr+3] = Wdata[31:24];
    end
    if(MemRead)begin
      Rdata = {dmem[addr+3],dmem[addr+2],dmem[addr+1],dmem[addr]};
    end
  end
endmodule

module control(input[5:0] opcode,
               input clk,
               output reg RegDst,
               output reg Jump,
               output reg Branch,
               output reg MemRead,
               output reg MemtoReg,
               output reg[1:0] ALUOp,
               output reg MemWrite,
               output reg ALUSrc,
               output reg RegWrite);
  
  reg [9:0] controls;
  
  initial begin
    controls = 10'b0000000000;
  end
  
  assign {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite} = controls;
  
  always@(posedge clk)begin
    case(opcode)//TODO: implement more instructions
      6'b000000: controls <= 10'b1_0_0_0_0_10_0_0_1;//R Type
      6'b100011: controls <= 10'b0_0_0_0_1_00_0_1_1;//LW
      6'b101011: controls <= 10'b0_0_0_0_0_00_1_1_0;//SW
    endcase
  end
endmodule

/*module mips();
  wire[31:0] pc_in, pc_out, instr_out, imm, reg1, reg2, ALU_out, Mem_out, regWdata, 
endmodule*/