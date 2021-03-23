module proj001_proc (
  input rst_n, clock,
  input capture,
  input [1:0] op,
  input [3:0] d_in,
  output [4:0] result,
  output valid
);

  dp_proc dp (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .capture( capture ),
    .op( op ),
    .clear( valid ),
    .result( result )
  );

  ctrl_proc ctrl (
    .rst_n( rst_n ),
    .clock( clock ),
    .capture( capture ),
    .valid( valid )
  );

endmodule
