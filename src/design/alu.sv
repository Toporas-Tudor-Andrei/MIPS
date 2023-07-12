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
      3'b011: result = in1 ^ in2;
      3'b100: result = in1 & (~in2);
      3'b101: result = in1 | (~in2);
      3'b110: result = in1 - in2;
      3'b111: result = in1 < in2;
      default: result = 32'hxxxxxxxx;
    endcase
    zero = (result == 32'h00000000);
  end
endmodule