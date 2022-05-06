module LPE_tb #(
  parameter K = 256
);
  logic [0:K-1] MA;     //MA: Matching Location

  logic [0:K-1] PMA;    //PMA: Potential Matching Address

  LPE LPE_tb (.*);

  initial begin
    #0 MA = 256'd172;
    //#10 $finish;

    for(int i = 0; i < K; i++) begin
      $display("MA[%0d] = %0d", i, MA[i]);
    end
    #10 $finish;
  end
  
endmodule