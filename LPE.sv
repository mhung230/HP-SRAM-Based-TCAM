module LPE #(
  parameter K = 256
)(
  input   logic [0:K-1] MA,     //MA: Matching Location

  output  logic [0:K-1] PMA     //PMA: Potential Matching Address
);

  logic found;                  //PMA is found
  always_comb begin
    found = 1'b0;
    for(int i = 0; i < K; i++) begin
      if((MA[i] == 1'b1) && !found) begin
        PMA = i;
        found = 1'b1;
      end
    end
  end

endmodule