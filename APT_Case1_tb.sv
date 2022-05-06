module APT_Case1_tb #(
  parameter w = 16,
  parameter b = 8,
  parameter K = 2**b
);
  logic clk;
  logic [w-1:0] APTA;
  
  logic [0:K-1] K_bit_row;

  APT_Case1 APT_Case1_tb(.*);

  always #5 clk <= !clk;

  initial begin
    #0  clk = 0;
    #5  APTA = 16'd15;
    #10 APTA = 16'd0;
    #10 APTA = 16'd250;
    #20 $finish;
  end

endmodule