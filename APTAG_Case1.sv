/* TOP MODULE APTAG_CASE1 */
module APTAG_Case1 #(
  parameter w = 16,               // bit width of sub-word
  parameter b = 8
)(
  input   logic en,               // enable signal to generate address data
  input   logic [w:0]       LI,
  input   logic [0:2**b-1]  data,
  input   logic [b-1:0]     IBPI, // IBPI: Indicated Bit Position Inclusive

  output  logic [w-1:0]     APTA  // APTA: address of APT
);

  logic [b-1:0] counter_result;
  logic [w:0]   zex_counter_result;  //zex_counter_result: zero extend of counter result 
  logic [w:0]   adder_result;

  counter_bit_set CBS (
    .data_count_bit_set(data),
    .IBPI(IBPI),

    .number_bit_set(counter_result)
  );

  assign zex_counter_result = {{(w-b+1){1'b0}},counter_result};   //{(w-b+1){1'b0},counter_result}: Mo rong bit

  CLA_Adder Adder (
    .i_add1(LI),
    .i_add2(zex_counter_result),
    //.i_add2({{(w-b+1){1'b0}},counter_result}),

    .o_add(adder_result),
    .o_carry()
  );

  always_comb begin
    if(en == 1'b1) begin
      APTA = adder_result[w-1:0];
    end
  end

endmodule

/* COUNTER */
module counter_bit_set #(
  parameter b = 8
)(

  input   logic [0:2**b-1]  data_count_bit_set,
  input   logic [b-1:0]     IBPI,                 //IPB: Indicated Bit Position Inclusive

  output  logic [b-1:0]     number_bit_set
);

  logic [b-1:0] temp;

  always_comb begin :Counter
    temp = {b{1'b0}};
    for (int i = 0; i <= IBPI; i++) begin
      if (data_count_bit_set[i] == 1'b1) begin
        temp = temp + 1'b1;                       // add usigned
      end
    end
    number_bit_set = temp;
  end
endmodule

/* CARRY LOOK ADDER */
module CLA_Adder #(
  parameter w = 16
)(
  input   logic [w:0] i_add1, i_add2,

  output  logic [w:0] o_add,
  output  logic       o_carry

);

  logic [w:0]   P, G, Sum;
  logic [w+1:0] C;

  always_comb begin
    for (int i = 0; i < w+1; i++) begin
      C[0] =1'b0;
      P[i] = i_add1[i] ^ i_add2[i];   // Carry Propagate
      G[i] = i_add1[i] & i_add2[i];   // Carry Generate
      Sum[i] = P[i] ^ C[i];           // Sum
      C[i+1] = G[i] | (P[i] & C[i]);  // Carry
    end
  end

  assign o_add = Sum;
  assign o_carry = C[w+1];

endmodule