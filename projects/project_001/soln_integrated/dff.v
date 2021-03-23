module dff (
  input rst_n, clock,
  input d,
  output reg q,
  output q_n
);

  always @(posedge clock )
    if( !rst_n )
      q <= 0;
    else
      q <= d;

  assign q_n = ~q;

endmodule

module dff4bit (
  input rst_n, clock,
  input [3:0] d,
  output [3:0] q
);

  wire [3:0] qb;

  dff bit_0 ( rst_n, clock, d[0], q[0], qb[0] );
  dff bit_1 ( rst_n, clock, d[1], q[1], qb[1] );
  dff bit_2 ( rst_n, clock, d[2], q[2], qb[2] );
  dff bit_3 ( rst_n, clock, d[3], q[3], qb[3] );

endmodule
