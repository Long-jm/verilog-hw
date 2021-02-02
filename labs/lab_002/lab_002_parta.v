module mux21 (
  input S,
  input A,
  input B,
  output F
);

  wire S_not;
  wire A_S_not;
  wire B_S;

  not U1 ( S_not, S );

  and U2 ( A_S_not, A, S_not );
  and U3 ( B_S, B, S );

  or U4 ( F, A_S_not, B_S );

endmodule
