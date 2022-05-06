module BPT_tb #(
  parameter w = 16,
  parameter b = 8
);
  logic clk;
  logic [w-1:0] in_sword;

  logic [2**b-1:0] data;
  logic [b-1:0]    BPI;
  logic [w:0]      LI;   
  logic            in_sw_pre;

  BPT_Case1 U1 (.*);

  always #5 clk <= !clk;

  initial begin
    #0 clk = 1'b0; in_sword = 16'h0010;
    #10 in_sword = 16'h008a;
    #10 in_sword = 16'h00fb;
    #10 in_sword = 16'h00f1;
    #10 $finish;
  end
endmodule