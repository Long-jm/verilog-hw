module hw5_q1c;

  reg [3:0] A, B, C, D;
  wire [4:0] F;

  hw5_q1b DUT (
    .A( A ),
    .B( B ),
    .C( C ),
    .D( D ),
    .F( F )
  );

  initial begin
    $display( $time, ":   A   B       C   D   | F " );
    $display( $time, ": (---+---) - (---+---)-=---" );
    $monitor( $time, ": (%2d + %2d) - (%2d + %2d) = %2d", A, B, C, D, F );
  end

  initial begin
        { A, B, C, D } = 16'b0000_0000_0000_0000;
    #10 { A, B, C, D } = 16'b1000_0101_0111_0100;
    #10 { A, B, C, D } = 16'b1000_1001_0011_1000;
    #10 { A, B, C, D } = 16'b1111_1111_0000_0000;
    #10 { A, B, C, D } = 16'b1111_1111_1111_1111;
    #10 $stop();
  end

endmodule

