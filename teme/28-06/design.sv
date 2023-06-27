module SISO(input a, input clk, output reg out);
  reg [3:0]data = 4'b0;
  always@(posedge clk)
    begin
      data <= {data[2:0], a};
      out <= data[3];
    end
endmodule

module SIPO(input a, input clk, output reg [3:0]out);
  always@(posedge clk)
      out <= {out[2:0], a};
endmodule

module PISO(input[3:0] a, input pl, input clk, output reg out);
  reg[3:0] data;
  always@(posedge clk)
    begin
      if(pl)
        data <= a;
      else
        data <= {data[2:0], 1'b0};
      out <= data[3];
    end
endmodule

module PIPO(input[3:0] a, input pl, input clk, output reg [3:0] out);
  always@(posedge clk)
    begin
      if(pl)
        out <= a;
      else
        out <= out;
    end
endmodule