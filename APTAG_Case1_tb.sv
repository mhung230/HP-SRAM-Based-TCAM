module APTAG_Case1_tb #(
  parameter w = 16,         // bit width of sub-word
  parameter b = 8
);
  logic en, clk;            // enable signal to generate address data
  logic [w:0]       LI;
  logic [0:2**b-1]  data;
  logic [b-1:0]     IBPI;   // IBPI: Indicated Bit Position Inclusive

  logic [w-1:0]     APTA;   // APTA: address of APT

  APTAG_Case1 APTAG_tb (.*);

  always #5 clk <= !clk;

  initial begin
    #0 clk = 0; en = 1'b1; data = 256'd15; IBPI = 8'd255; LI = 17'd15;
    #10 $finish;
  end

endmodule