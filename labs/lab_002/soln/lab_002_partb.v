module lab_002_partb_soln (
  input A,
  input B,
  input C,
  output F
);

  /* put your variable declarations here */
  wire w1, w2, w3;

  /* put your gate instances here */
  not U1 ( w1, A );
  and U2 ( w2, w1, B );
  and U3 ( w3, B, C );
  or U4 ( F, w2, w3 );

endmodule
