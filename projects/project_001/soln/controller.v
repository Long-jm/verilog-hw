module controller (
  input rst_n, clock,
  input capture,
  input [1:0] op,
  input full,
  output clear,
  output [3:0] en,
  output valid
);

  wire nstate, cstate, cstate_n;

  /* state vector */
  dff state ( rst_n, clock, nstate, cstate, cstate_n );

  /* next state equation */
  assign nstate = cstate_n & full;

  /* valid only in S1 */
  assign valid = cstate;

  /* clear tracking in S1 */
  assign clear = cstate;

  /* one hot enables */
  assign common = cstate_n & ~full & capture;
  assign en[0] = common & ~op[1] & ~op[0];
  assign en[1] = common & ~op[1] &  op[0];
  assign en[2] = common &  op[1] & ~op[0];
  assign en[3] = common &  op[1] &  op[0];

endmodule
