module lab005 (
  input rst_n, clock,
  input capture,
  input [1:0] op,
  output full
);

  wire [3:0] en;
  wire clear;

  datapath dp (
    .rst_n( rst_n ),
    .clock( clock ),
    .en( en ),
    .clear( clear ),
    .full( full )
  );

  controller ctrl (
    .rst_n( rst_n ),
    .clock( clock ),
    .capture( capture ),
    .op( op ),
    .full( full ),
    .clear( clear ),
    .en( en )
  );

endmodule
