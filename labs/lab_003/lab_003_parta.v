module lab_003_parta (
  input A, B, C,
  output G
);

  wire A1, A2, A3, A4;

  assign G = (A1 | A2 | A3 | A4);
  assign A1 = ((~A) & C);
  assign A2 = ((~A) & B);
  assign A3 = (B & C);
  assign A4 = (A & (~B) & (~C));

endmodule