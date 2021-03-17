
module datapath (
  input rst_n, clock, capture,
  input [1:0] op,
  input [3:0] d_in,
  output [4:0] result
);

  wire [3:0] A, B, C, D;

  decoder decode_inst (rst_n, clock, capture, op, d_in, A, B, C, D);
  calculation calc_inst (A, B, C, D, result);

endmodule
