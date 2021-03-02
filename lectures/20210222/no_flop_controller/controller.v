module controller (
  input capture, fgt127,
  output [1:0] sel,
  output valid
);

  assign sel[1] = ~fgt127;
  assign sel[0] = ~( capture ^ fgt127 );
  assign valid = fgt127;

endmodule
