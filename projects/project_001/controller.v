
module controller (
  input rst_n, clock, capture,
  output valid
);

  full_count valid_inst (rst_n, clock, capture, valid);

endmodule
