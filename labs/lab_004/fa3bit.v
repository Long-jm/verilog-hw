// Structural 3-bit adder
module fa3bit (
  input [2:0] A, B,
  output [3:0] F
);

  wire w1, w2;
  wire Cin_tied;

  assign Cin_tied = 1'b0;

  fa U1 ( Cin_tied, A[0], B[0], w1, F[0] );
  fa U2 ( w1, A[1], B[1], w2, F[1] );
  fa U3 ( w2, A[2], B[2], F[3], F[2] );

endmodule
