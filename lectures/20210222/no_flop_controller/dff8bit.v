module dff8bit (
  input rst_n, clock,
  input [7:0] D,
  output [7:0] Q
);

  wire [7:0] q_bar;

  dff U0 ( rst_n, clock, D[0], Q[0], q_bar[0] );
  dff U1 ( rst_n, clock, D[1], Q[1], q_bar[1] );
  dff U2 ( rst_n, clock, D[2], Q[2], q_bar[2] );
  dff U3 ( rst_n, clock, D[3], Q[3], q_bar[3] );
  dff U4 ( rst_n, clock, D[4], Q[4], q_bar[4] );
  dff U5 ( rst_n, clock, D[5], Q[5], q_bar[5] );
  dff U6 ( rst_n, clock, D[6], Q[6], q_bar[6] );
  dff U7 ( rst_n, clock, D[7], Q[7], q_bar[7] );

endmodule
