module hw5_q1c;

  reg [3:0] A, B, C, D;
  wire [4:0] result;

  // DUT instantiation
  hw5_q1b DUT (
    .A( A ),
    .B( B ),
    .C( C ),
    .D( D ),
    .result( result )
  );

  initial begin
    $display( $time, ":  A  B  C  D | result" );
    $display( $time, ": ------------+--------" );
    $monitor( $time, ": %2d %2d %2d %2d |   %2d", A, B, C, D, result );
  end

  initial begin
        { A, B, C, D } = 16'h8_4_3_2;
    #10 { A, B, C, D } = 16'ha_4_a_2;
    #10 { A, B, C, D } = 16'hf_f_f_f;
    #10 { A, B, C, D } = 16'h3_1_1_2;
    #10 $stop();
  end

endmodule
