module lab_003_partc (
  input A, B, C, D,
  output F
);

  wire g;

  lab_003_parta U1 (
    .A( A ),
    .B( B ),
    .C( C ),
    .G( g )
  );  

  lab_003_partb U2 (
    .G( g ),
    .D( D ),
    .F( F )
  );

endmodule
