module lab_003_partc (
  input A, B, C, D,
  output F
);

  wire g;

  lab_003_parta U1 (
    A, B, C, g
  );

  lab_003_partb U2 (
    g, D, F
  );

  endmodule
