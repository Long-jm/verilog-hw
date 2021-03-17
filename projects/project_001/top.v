
module proj001 (
  input rst_n, clock, capture,
  input [1:0] op,
  input [3:0] d_in,
  output valid,
  output [4:0] result
  
);

  datapath data_inst (rst_n, clock, capture, op, d_in, result);
  controller control_inst (rst_n, clock, capture, valid);

endmodule
