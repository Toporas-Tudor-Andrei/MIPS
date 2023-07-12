module PC(input[31:0] pc_in,
          input clk,
          output reg[31:0] pc_out);
  
  initial begin
    pc_out <= 32'h0;
  end
  
  always@(posedge clk)
      pc_out <= pc_in;
endmodule