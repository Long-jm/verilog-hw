
module capt_count (
  input rst_n, clock, capture,
  input [1:0] op,
  output full
);

  wire [2:0] Q, Qbar, Qx;

  assign Qx[2] = (Q[2] & Q[0]) | (Q[1] & Q[0] & capture);
  assign Qx[1] = (Q[0] & capture) | (Q[1] & Q[0]);
  assign Qx[0] = (Qbar[2] & capture) | (Q[0] & (~capture)) | (Qbar[0] & capture);
  
  dff Q0 ( rst_n, clock, Qx[0], Q[0], Qbar[0] );
  dff Q1 ( rst_n, clock, Qx[1], Q[1], Qbar[1] );
  dff Q2 ( rst_n, clock, Qx[2], Q[2], Qbar[2] );

  assign full = Q[2] & Q[1] * Qbar[0];

endmodule
