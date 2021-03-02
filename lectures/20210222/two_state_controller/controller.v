module controller (
  input rst_n, clock,
  input capture, fgt127,
  output [1:0] sel,
  output valid
);

  wire nstate;
  wire q, q_bar;

  and U1 ( nstate, capture, fgt127, q_bar );
  dff U3 ( rst_n, clock, nstate, q, q_bar );
  xnor U2 ( sel[0], q, capture );

  assign valid = q;
  assign sel[1] = q_bar;

endmodule
