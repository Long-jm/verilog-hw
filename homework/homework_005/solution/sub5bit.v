// Structural 5-bit subtractor
module sub5bit (
  input [4:0] A, B,
  output [4:0] F
);

  wire [4:0] B_n;
  wire w1, w2, w3, w4;
  wire Cout, Cin_tied;

  // Invert the bits of B
  assign B_n = ~B;

  /*
  assign B_n[0] = ~B[0];
  assign B_n[1] = ~B[1];
  assign B_n[2] = ~B[2];
  assign B_n[3] = ~B[3];
  assign B_n[4] = ~B[4];
  */
 
  /*
  not inv0 ( B_n[0], B[0] );
  not inv1 ( B_n[1], B[1] );
  not inv2 ( B_n[2], B[2] );
  not inv3 ( B_n[3], B[3] );
  not inv4 ( B_n[4], B[4] );
  */

  // adds one to ~B for 2's complement
  assign Cin_tied = 1'b1;

  fa U0 ( Cin_tied, A[0], B_n[0], w1, F[0] );
  fa U1 ( w1, A[1], B_n[1], w2, F[1] );
  fa U2 ( w2, A[2], B_n[2], w3, F[2] );
  fa U3 ( w3, A[3], B_n[3], w4, F[3] );
  fa U4 ( w4, A[4], B_n[4], Cout, F[4] );

endmodule
