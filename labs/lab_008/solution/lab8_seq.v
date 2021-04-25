module dff (
  input clock, rst_n,
  input d,
  output reg q,
  output q_n
);

  always @( posedge clock )
    if( !rst_n )
      q <= 0;
    else
      q <= d;

  assign q_n = ~q;

endmodule

module lab8_seq_1101 (
  input clock, rst_n,
  input d_in,
  output found
);

  wire [3:0] q, q_n;

  dff d0 ( .rst_n( rst_n ), .clock( clock ), .d( d_in ), .q( q[0] ), .q_n( q_n[0] ) );
  dff d1 ( .rst_n( rst_n ), .clock( clock ), .d( q[0] ), .q( q[1] ), .q_n( q_n[1] ) );
  dff d2 ( .rst_n( rst_n ), .clock( clock ), .d( q[1] ), .q( q[2] ), .q_n( q_n[2] ) );
  dff d3 ( .rst_n( rst_n ), .clock( clock ), .d( q[2] ), .q( q[3] ), .q_n( q_n[3] ) );

  assign found = q[3] & q[2] & q_n[1] & q[0];

endmodule

module lab8_seq_101 (
  input clock, rst_n,
  input d_in,
  output found
);

  wire [1:0] q, q_n;
  wire [1:0] mux_in;

  // mux for the input to the regs
  assign mux_in[1] = found ? 0 : q[0];
  assign mux_in[0] = found ? 0 : d_in;

  dff d0 ( .rst_n( rst_n ), .clock( clock ), .d( mux_in[0] ), .q( q[0] ), .q_n( q_n[0] ) );
  dff d1 ( .rst_n( rst_n ), .clock( clock ), .d( mux_in[1] ), .q( q[1] ), .q_n( q_n[1] ) );

  assign found = q[1] & q_n[0] & d_in;

endmodule
