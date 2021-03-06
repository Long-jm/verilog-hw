module fa_pg_dly (
  input cin, a, b,
  output cout, sum
);

  wire p, g, w3;

  xor_dly U1 ( p, a, b );
  xor_dly U2 ( sum, p, cin );

  and_dly U3 ( g, a, b );
  and_dly U4 ( w3, cin, p );
  or_dly U5 ( cout, g, w3 );

endmodule

module fa_dly (
  input cin, a, b,
  output cout, sum
);

  wire w1, w2, w3, w4;

  xor_dly U1 ( w1, a, b );
  xor_dly U2 ( sum, w1, cin );

  and_dly U3 ( w2, cin, a );
  and_dly U4 ( w3, cin, b );
  and_dly U5 ( w4, a, b );
  or3_dly U6 ( cout, w2, w3, w4 );

endmodule

module fa_dly_tb;

  reg CIN, A, B;
  wire COUT, SUM;
  wire COUT2, SUM2;

  fa_dly DUT (
    .a( A ),
    .b( B ),
    .cin( CIN ),
    .cout( COUT ),
    .sum( SUM )
  );

  fa_pg_dly DUT2 (
    .a( A ),
    .b( B ),
    .cin( CIN ),
    .cout( COUT2 ),
    .sum( SUM2 )
  );

  initial begin
    $display( $time, ": CIN A B | COUT(2) SUM(2)" );
    $display( $time, ": --------+---------------" );
    $monitor( $time, ":  %b  %b %b |  %b(%b)    %b(%b)",
      CIN, A, B, COUT, COUT2, SUM, SUM2 );
  end

  initial begin
        { CIN, A, B } = 3'b000;
    #10 { CIN, A, B } = 3'b001;
    #10 { CIN, A, B } = 3'b010;
    #10 { CIN, A, B } = 3'b011;
    #10 { CIN, A, B } = 3'b100;
    #10 { CIN, A, B } = 3'b101;
    #10 { CIN, A, B } = 3'b110;
    #10 { CIN, A, B } = 3'b111;
    #30 { CIN, A, B } = 3'b000;

    /* separation here to "clear out" the previous
    * part of the simulation to get ready to replicate
    * what we worked out in class */
    #10 { CIN, A, B } = 3'b000;
     #1 { CIN, A, B } = 3'b010;
     #1 { CIN, A, B } = 3'b011;
     #1 { CIN, A, B } = 3'b111;
     #2 { CIN, A, B } = 3'b101;
     #2 { CIN, A, B } = 3'b100;
    #10 $stop;
  end

endmodule
