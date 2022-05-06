module HP_SRAM_Based_TCAM_Case1 #(
  parameters
) (
  port_list
);
  
endmodule

module LAYER #(
  parameter L = 2,
  parameter N = 2,
  parameter W = 32,
  parameter K = 256
)(
  input   logic clk,
  input   logic [W-1:0] i_data,

  output  logic [0:K-1] PMA
);

  localparam w = W/N;
  localparam b = w/2;

  logic [w-1:0] sword_1, sword_2;             //input sub word for HP11
  logic [0:2**b-1] data_BPT_1, data_BPT_2;
  logic [w:0] LI_1, LI_2;
  logic [b-1:0] BPI_1, BPI_2;
  logic [1:0] AND_1bit;

  logic [w-1:0] APTA_1, APTA_2;

  logic [0:K-1] K_bit_row_1, K_bit_row_2;
  logic [0:K-1] AND_K_bit;

  logic en_searching;

  assign sword_1 = i_data[W-1:w];
  assign sword_2 = i_data[w-1:0];

  BPT_Case1 BPT_1 (
    .clk(clk), .in_sword(sword_1),
  
    .data(data_BPT_1), .LI(LI_1), .BPI(BPI_1), .in_sw_pre(AND_1bit[1])
  );

  BPT_Case1 BPT_2 (
    .clk(clk), .in_sword(sword_2),
  
    .data(data_BPT_2), .LI(LI_2), .BPI(BPI_2), .in_sw_pre(AND_1bit[0])
  );

  assign en_searching = &AND_1bit;

  APTAG_Case1 APTAG_1(
    .en(en_searching), .LI(LI_1), ,data(data_BPT_1), .IBPI(BPI_1),

    .APTA(APTA_1)
  );

  APTAG_Case1 APTAG_2(
    .en(en_searching), .LI(LI_2), ,data(data_BPT_2), .IBPI(BPI_2),

    .APTA(APTA_2)
  );

  APT_Case1 APT_1 (
    .clk(clk), .APTA(APTA_1),
  
    .K_bit_row(K_bit_row_1)
  );

  APT_Case1 APT_2 (
    .clk(clk), .APTA(APTA_2),
  
    .K_bit_row(K_bit_row_2)
  );

  assign AND_K_bit = K_bit_row_1 & K_bit_row_2;
  
  LPE LPE(
    .MA(AND_K_bit),

    .PMA(PMA)
);

endmodule