module fa (
  input Cin, A, B,
  output Cout, Sum
);

  assign Sum = Cin ^ A ^ B;
  assign Cout = ( Cin & A ) | ( A & B ) | ( Cin & B );

endmodule
