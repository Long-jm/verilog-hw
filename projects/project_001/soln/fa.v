module fa (
  input Cin, A, B,
  output Cout, Sum
);

  assign Sum = Cin ^ A ^ B;
  assign Cout = ( Cin & A ) | ( A & B ) | ( Cin & B );

endmodule

module fa4bit (
  input Cin,
  input [3:0] A, B,
  output [4:0] F
);

  wire [2:0] Cout;

  fa U0 ( Cin,     A[0], B[0], Cout[0], F[0] );
  fa U1 ( Cout[0], A[1], B[1], Cout[1], F[1] );
  fa U2 ( Cout[1], A[2], B[2], Cout[2], F[2] );
  fa U3 ( Cout[2], A[3], B[3],    F[4], F[3] );

endmodule

module fa5bit (
  input Cin,
  input [4:0] A, B,
  output [5:0] F
);

  wire [3:0] Cout;

  fa U0 ( Cin,     A[0], B[0], Cout[0], F[0] );
  fa U1 ( Cout[0], A[1], B[1], Cout[1], F[1] );
  fa U2 ( Cout[1], A[2], B[2], Cout[2], F[2] );
  fa U3 ( Cout[2], A[3], B[3], Cout[3], F[3] );
  fa U4 ( Cout[3], A[4], B[4],    F[5], F[4] );

endmodule
