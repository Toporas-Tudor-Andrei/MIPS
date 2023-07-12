`include "smallModules.sv"
`include "alu.sv"
`include "aluControl.sv"
`include "pc.sv"
`include "registerFile.sv"
`include "instructionMemory.sv"
`include "dataMemory.sv"
`include "control.sv"

module mips(input clk);
  
  wire[31:0] pc_in, pc_out, instr_out, imm_extd, reg1, reg2, ALU_out, Mem_out, regWdata, ALUin2, branchIn2, nextIaddr, branchADDR, nextORbranch;
  wire[27:0] jumpAddr;
  wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALU_zero;
  wire[1:0] ALUOp;
  wire[2:0] aluctrl;
  wire[4:0] writeReg;
  
  signExtend extend(instr_out[15:0], imm_extd);
  Mux21 #(.SIZE(5)) WriteRegMux(instr_out[20:16], instr_out[15:11], RegDst, writeReg);
  Mux21 #(.SIZE(32)) aluIn2(reg2, imm_extd, ALUSrc, ALUin2);
  Mux21 #(.SIZE(32)) WriteRegData(ALU_out, Mem_out, MemtoReg, regWdata);
  
  Mux21 #(.SIZE(32)) nextVbranch_mux(nextIaddr, branchADDR, ALU_zero & Branch, nextORbranch);
  Mux21 #(.SIZE(32)) nextorbranchVjump_mux(nextORbranch, {nextIaddr[31:28], jumpAddr}, Jump, pc_in);
  
  shiftLeft2 #(.INB(26), .OUTB(28)) shiftJumpAddr(instr_out[25:0], jumpAddr);
  Adder nextInstrAdder(pc_out, 32'h4, nextIaddr);
  Adder branchAddrAdder(nextIaddr, branchIn2, branchADDR);
  shiftLeft2 #(.INB(32), .OUTB(32)) shiftLeft_branch(imm_extd, branchIn2);
  
  control ctrl(instr_out[31:26], clk, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
  dataMem memoryData(ALU_out, reg2, MemWrite, MemRead, clk, Mem_out);
  instrMem memoryInstruction(pc_out, instr_out);
  Registers registers(instr_out[25:21], instr_out[20:16], writeReg, regWdata, RegWrite, clk, reg1, reg2);
  PC programCounter(pc_in, clk, pc_out);
  ALU alu(reg1, ALUin2, aluctrl, ALU_out, ALU_zero);
  ALU_control alu_ctrl(instr_out[5:0], ALUOp, aluctrl);
  
endmodule