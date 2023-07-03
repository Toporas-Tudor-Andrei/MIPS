module signExtend(input[15:0] in, output[31:0] out);
  assign out[31:16] = {16{in[15]}};
  assign out[15:0] = in[15:0];
endmodule

module shiftLeft2(input[25:0] in, output[27:0] out);
  assign out = {in, 2'b0};
endmodule

module Mux21 #(parameter SIZE = 5)
  (input[SIZE-1:0]in0, input[SIZE-1:0]in1, input sel, output[SIZE-1:0] out);
  assign out = sel ? in1, in0;
endmodule

module Adder4(input[31:0] pc, output[31:0] out);
  assign out = pc + 4;
endmodule

module ALU(input[31:0] in1, input[31:0] in2, input[3:0] ALUop, output[31:0] result, output zero);
  initial begin
    zero = 0;
    result = 0;
  end
  always @(*) begin
    case (ALUop)
      4'b0000: out = in1 & in2;
      4'b0001: out = in1 | in2;
      4'b0010: out = in1 + in2;
      4'b0110: out = in1 - in2;
      4'b0111: out = in1 < in2;
      default: out = 32'bxxxxxxxx;
    endcase
    zero = (out == 32'h0000);
  end
endmodule

/*module ALU_control (input [1:0] ALUop,
                    input [5:0] func,
                    input rtype,
                    output reg [3:0] aluop_out);
  always @(*) begin
    if (ALUop[1]) begin
      case(functioncode)
        6'h20: aluop_out = 4'b0000;//and
        6'h20: aluop_out = 4'b0001;//or
        6'h20: aluop_out = 4'b0001;//ori
        6'h20: aluop_out = 4'b0010;//add
        6'h20: aluop_out = 4'b0010;//addi
        6'h20: aluop_out = 4'b0010;//addu
        6'h20: aluop_out = 4'b0010;//lw
        6'h20: aluop_out = 4'b0010;//sw
        6'h20: aluop_out = 4'b0110;//sub
        6'h20: aluop_out = 4'b0110;//beq
        6'h20: aluop_out = 4'b0110;//bne
        6'h20: aluop_out = 4'b0111;//slt
        default: aluop_out = 4'bxxxx;
      endcase
    end
    else begin
      aluop_out = ALUop[0] ? 4'b0110 : 4'b0010;//minus: add
    end
  end
endmodule
*/