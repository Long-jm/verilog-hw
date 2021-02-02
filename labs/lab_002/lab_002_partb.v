module lab_002_partb (
  input A,
  input B,
  input C,
  output F
);

  wire A_not;
  wire A_not_B;
  wire B_C;  

  not N1 ( A_not, A );

  and A1 ( A_not_B, A_not, B );
  and A2 ( B_C, B, C );

  or O1 ( F, A_not_B, B_C );

endmodule
