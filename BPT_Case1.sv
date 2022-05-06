module BPT_Case1 #(
  parameter w = 16,                    //bit width of sub-word
  parameter b = 8                      
)(
  input   logic clk,
  input   logic [w-1:0]     in_sword,  //in_sword: sub-word input

  output  logic [0:2**b-1]  data,
  output  logic [w:0]       LI,        //LI: Last Index
  output  logic [b-1:0]     BPI,       //BPI: Bit Position Indicator
  output  logic             in_sw_pre  //in_sw_pre: input subword is present 
);
  localparam WIDTH   = 2**b + (w+1);
  localparam ENTRIES = 2**(w-b);

  logic [w-b-1:0] BPTA;                 //BPTA: Bit Position Table Address
  
  logic [0:WIDTH-1] RAM [0:ENTRIES-1];

  assign BPTA = in_sword[w-1:w-b];
  assign BPI  = in_sword[w-b-1:0];

  initial $readmemb("C:/Users/ADMIN/Desktop/Hex_data.txt",RAM);

  always_ff @(posedge clk ) begin : Read_Data
    data  <=  RAM[BPTA][0:2**b-1];
    LI    <=  RAM[BPTA][2**b:WIDTH-1];
    
    if (RAM[BPTA][BPI] == 1'b1) begin
      in_sw_pre <= 1'b1;
    end else begin
      in_sw_pre <= 1'b0;
    end
  end

endmodule