// Dataflow implementation of a single bit full adder
module fa (
  input Cin, A, B,
  output Cout, Sum
);

  assign Sum = Cin ^ A ^ B;
  assign Cout = ( Cin & A ) | ( A & B ) | ( Cin & B );

endmodule

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

  // adds one to ~B for 2's complement
  assign Cin_tied = 1'b1;

  fa U0 ( Cin_tied, A[0], B_n[0], w1, F[0] );
  fa U1 ( w1, A[1], B_n[1], w2, F[1] );
  fa U2 ( w2, A[2], B_n[2], w3, F[2] );
  fa U3 ( w3, A[3], B_n[3], w4, F[3] );
  fa U4 ( w4, A[4], B_n[4], Cout, F[4] );

endmodule
