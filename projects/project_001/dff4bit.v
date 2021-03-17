
module dff4bit (
  input rst_n, clock,
  input [3:0] D,
  output [3:0] Q
);

  wire [3:0] q_bar;

  dff U0 ( rst_n, clock, D[0], Q[0], q_bar[0] );
  dff U1 ( rst_n, clock, D[1], Q[1], q_bar[1] );
  dff U2 ( rst_n, clock, D[2], Q[2], q_bar[2] );
  dff U3 ( rst_n, clock, D[3], Q[3], q_bar[3] );

endmodule
