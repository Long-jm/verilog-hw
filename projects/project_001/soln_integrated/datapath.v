module datapath (
  input rst_n, clock,
  input [3:0] d_in,
  input [3:0] en,
  input clear,
  output full,
  output [4:0] result
);

  wire [3:0] A, B, C, D;
  wire [3:0] d_A, d_B, d_C, d_D;

  computation func (
    .A( A ),
    .B( B ),
    .C( C ),
    .D( D ),
    .result( result )
  );

  tracking flags (
    .rst_n( rst_n ),
    .clock( clock ),
    .en( en ),
    .clear( clear ),
    .full( full )
  );

  // register with enable for A
  mux21_4bit mux_A ( en[0], A, d_in, d_A );
  dff4bit dff_A ( rst_n, clock, d_A, A );

  // register with enable for B
  mux21_4bit mux_B ( en[1], B, d_in, d_B );
  dff4bit dff_B ( rst_n, clock, d_B, B );

  // register with enable for C
  mux21_4bit mux_C ( en[2], C, d_in, d_C );
  dff4bit dff_C ( rst_n, clock, d_C, C );

  // register with enable for D
  mux21_4bit mux_D ( en[3], D, d_in, d_D );
  dff4bit dff_D ( rst_n, clock, d_D, D );

endmodule
