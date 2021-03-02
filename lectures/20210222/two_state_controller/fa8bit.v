module fa8bit (
  input [7:0] A, B,
  output [8:0] F
);

  wire [6:0] Cout;
  wire Cin;

  assign Cin = 1'b0;

  fa U0 ( Cin,     A[0], B[0], Cout[0], F[0] );
  fa U1 ( Cout[0], A[1], B[1], Cout[1], F[1] );
  fa U2 ( Cout[1], A[2], B[2], Cout[2], F[2] );
  fa U3 ( Cout[2], A[3], B[3], Cout[3], F[3] );
  fa U4 ( Cout[3], A[4], B[4], Cout[4], F[4] );
  fa U5 ( Cout[4], A[5], B[5], Cout[5], F[5] );
  fa U6 ( Cout[5], A[6], B[6], Cout[6], F[6] );
  fa U7 ( Cout[6], A[7], B[7], F[8],    F[7] );

endmodule
