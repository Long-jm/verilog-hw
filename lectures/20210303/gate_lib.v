module and_dly #(
  parameter DELAY = 1
) (
  output f,
  input a, b
);

  assign #(DELAY) f = a & b;

endmodule

module or_dly #(
  parameter DELAY = 1
) (
  output f,
  input a, b
);

  assign #(DELAY) f = a | b;

endmodule

module or3_dly #(
  parameter DELAY = 1
) (
  output f,
  input a, b, c
);

  assign #(DELAY) f = a | b | c;

endmodule

module xor_dly #(
  parameter DELAY = 1
) (
  output f,
  input a, b
);

  assign #(DELAY) f = a ^ b;

endmodule

