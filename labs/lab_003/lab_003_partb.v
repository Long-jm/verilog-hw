module lab_003_partb (
  input G, D,
  output F
);

  assign F = ((~G) | D);

endmodule