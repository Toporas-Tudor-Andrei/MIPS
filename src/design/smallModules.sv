module signExtend(input[15:0] in, output[31:0] out);
  assign out={{16{in[15]}},in};
endmodule

module shiftLeft2 #(parameter INB = 26, parameter OUTB = 28)(input[INB-1:0] in, output[OUTB-1:0] out);
  assign out = in << 2;
endmodule

module Mux21 #(parameter SIZE = 5)
  (input[SIZE-1:0]in0, input[SIZE-1:0]in1, input sel, output[SIZE-1:0] out);
  assign out = sel ? in1 : in0;
endmodule

module Adder(input[31:0] a, input[31:0] b, output[31:0] out);
  assign out = a + b;
endmodule