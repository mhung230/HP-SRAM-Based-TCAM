module APT_Case1 #(
  parameter w = 16,
  parameter b = 8,
  parameter K = 2**b
)(
  input   logic clk,
  input   logic [w-1:0] APTA,
  
  output  logic [0:K-1] K_bit_row
);

  localparam ENTRIES = 2**w;

  logic [0:K-1] RAM [0:ENTRIES-1];

  initial $readmemb("C:/Users/ADMIN/Desktop/APT_11.txt",RAM);

  always_ff @(posedge clk) begin: Read_Data
    K_bit_row <= RAM[APTA];
  end
endmodule