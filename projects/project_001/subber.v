
module subber (
  input A, B, Bin,
  output D, Bout
);

  wire AxorB;
  
  assign AxorB = A ^ B;

  assign D = AxorB ^ Bin;
  assign Bout = ((~A) & B) | (Bin & (~AxorB));

endmodule
