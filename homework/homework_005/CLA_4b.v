
module CLA_4b (
  input [3:0] A, B,
  output [4:0] S
);

  wire [3:0] P, G, C;
  
  assign P = A ^ B;
  assign G = A & B;

  assign C[0] = 1'b0;
  assign C[1] = G[0];
  assign C[2] = G[1] | (P[1] & G[0]);
  assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]);
  assign S[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | 
               (P[3] & P[2] & P[1] & G[0]);

  assign S[3:0] = P ^ C;

endmodule
