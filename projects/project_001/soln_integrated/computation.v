module computation (
  input [3:0] A, B, C, D,
  output [4:0] result
);

  wire [4:0] apb, cpd;

  // Need adder for apb = A+B
  fa4bit APB_ADDER ( A, B, apb );

  // Need adder for cpd = C+D
  fa4bit CPD_ADDER ( C, D, cpd );

  // Need subtractor for (A+B)-(C+D), result = apb - cpd
  sub5bit SUBTRACTOR ( apb, cpd, result );

endmodule
