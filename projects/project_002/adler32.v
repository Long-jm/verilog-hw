module adler32 (
  input rst_n, clock, data_start, size_valid,
  input [7:0] data,
  input [31:0] size,
  output checksum_valid,
  output [31:0] checksum
);

  size_count U1 (
    .rst_n( rst_n ),
    .clock( clock ),
    .data_start( data_start ),
    .size_valid( size_valid ),
    .size( size ),
    .checksum_valid( checksum_valid )
  );

  adler32_acc U2 (
    .rst_n( rst_n ),
    .clock( clock ),
    .data_start( data_start ),
    .data( data ),
    .checksum( checksum )
  );

endmodule