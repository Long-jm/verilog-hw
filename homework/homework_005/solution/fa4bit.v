// Structural 4-bit adder
module fa4bit (
  input [3:0] A, B,
  output [4:0] F
);

  wire w1, w2, w3;
  wire Cin_tied;

  assign Cin_tied = 1'b0;

  fa U0 ( Cin_tied, A[0], B[0], w1, F[0] );
  fa U1 ( w1, A[1], B[1], w2, F[1] );
  fa U2 ( w2, A[2], B[2], w3, F[2] );
  fa U3 ( w3, A[3], B[3], F[4], F[3] );

endmodule
