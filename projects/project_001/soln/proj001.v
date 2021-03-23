module proj001 (
  input rst_n, clock,
  input [3:0] d_in,
  input [1:0] op,
  input capture,
  output [4:0] result,
  output valid
);

  wire [3:0] en;
  wire clear;
  wire full;

  datapath dp (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .en( en ),
    .clear( clear ),
    .full( full ),
    .result( result )
  );

  controller ctrl (
    .rst_n( rst_n ),
    .clock( clock ),
    .capture( capture ),
    .op( op ),
    .full( full ),
    .clear( clear ),
    .en( en ),
    .valid( valid )
  );

endmodule
