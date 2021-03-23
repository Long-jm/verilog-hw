module tracking (
  input rst_n, clock,
  input [3:0] en,
  input clear,
  output full
);

  wire [3:0] q, qb, next, w;

  // operand zero
  mux21 MUX0 ( en[0], q[0], 1'b1, w[0] );
  mux21 MUX0_c ( clear, w[0], 1'b0, next[0] );
  dff DFF0 ( rst_n, clock, next[0], q[0], qb[0] );

  // operand one
  mux21 MUX1 ( en[1], q[1], 1'b1, w[1] );
  mux21 MUX1_c ( clear, w[1], 1'b0, next[1] );
  dff DFF1 ( rst_n, clock, next[1], q[1], qb[1] );

  // operand two
  mux21 MUX2 ( en[2], q[2], 1'b1, w[2] );
  mux21 MUX2_c ( clear, w[2], 1'b0, next[2] );
  dff DFF2 ( rst_n, clock, next[2], q[2], qb[2] );

  // operand three
  mux21 MUX3 ( en[3], q[3], 1'b1, w[3] );
  mux21 MUX3_c ( clear, w[3], 1'b0, next[3] );
  dff DFF3 ( rst_n, clock, next[3], q[3], qb[3] );

  // full when all are set
  and TRACK ( full, q[3], q[2], q[1], q[0] );

endmodule
