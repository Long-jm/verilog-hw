
module hw5_q1b (
  input [3:0] A, B, C, D,
  output [4:0] F
);

  wire [4:0] sum1, sum2;
  wire [5:0] Bin;

  assign Bin[0] = 1'b0;

  CLA_4b A1 (
    .A( A ),
    .B( B ),
    .S( sum1 )
  );
  
  CLA_4b A2 (
    .A( C ),
    .B( D ),
    .S( sum2 )
  );

  Sub S1 (
    .A( sum1[0] ),
    .B( sum2[0] ),
    .Bin( Bin[0] ),
    .D( F[0] ),
    .Bout( Bin[1] )
  );

  Sub S2 (
    .A( sum1[1] ),
    .B( sum2[1] ),
    .Bin( Bin[1] ),
    .D( F[1] ),
    .Bout( Bin[2] )
  );

  Sub S3 (
    .A( sum1[2] ),
    .B( sum2[2] ),
    .Bin( Bin[2] ),
    .D( F[2] ),
    .Bout( Bin[3] )
  );

  Sub S4 (
    .A( sum1[3] ),
    .B( sum2[3] ),
    .Bin( Bin[3] ),
    .D( F[3] ),
    .Bout( Bin[4] )
  );

  Sub S5 (
    .A( sum1[4] ),
    .B( sum2[4] ),
    .Bin( Bin[4] ),
    .D( F[4] ),
    .Bout( Bin[5] )
  );

endmodule
