module mux21 (
  input sel, in_0, in_1,
  output f
);

  assign f = sel ? in_1 : in_0;

endmodule

module mux21_4bit (
  input sel,
  input [3:0] in_0, in_1,
  output [3:0] f
);

  mux21 U0 ( sel, in_0[0], in_1[0], f[0] );
  mux21 U1 ( sel, in_0[1], in_1[1], f[1] );
  mux21 U2 ( sel, in_0[2], in_1[2], f[2] );
  mux21 U3 ( sel, in_0[3], in_1[3], f[3] );

endmodule
