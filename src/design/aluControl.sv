module ALU_control (input [5:0] funct,
                    input [1:0] aluop,
                    output reg [2:0] ALUctrl);
  
  initial begin
    ALUctrl = 0;
  end
  always @ (*)
    case (aluop)
      2'b00: ALUctrl <= 3'b010; // add
      2'b01: ALUctrl <= 3'b110; // sub
      default: case(funct) // RTYPE
        6'b100000: ALUctrl <= 3'b010; // ADD
        6'b100010: ALUctrl <= 3'b110; // SUB
        6'b100100: ALUctrl <= 3'b000; // AND
        6'b100101: ALUctrl <= 3'b001; // OR
        6'b100110: ALUctrl <= 3'b011; //XOR
        6'b101010: ALUctrl <= 3'b111; // SLT
        default: ALUctrl <= 3'bxxx;
      endcase
    endcase
endmodule