module lab_002_partb_tb ();

  reg stim_a;
  reg stim_b;
  reg stim_c;
  wire observe_f;

  reg err;

  lab_002_partb DUT (
    .A( stim_a ),
    .B( stim_b ),
    .C( stim_c ),
    .F( observe_f )
  );

  initial
  begin
    $display( $time, ": A B C | F" );
    $display( $time, ": ------+--" );
    $monitor( $time, ": %b %b %b | %b", stim_a, stim_b, stim_c, observe_f );
  end

  initial
  begin
        { stim_a, stim_b, stim_c } = 3'b000;
    #10 { stim_a, stim_b, stim_c } = 3'b001;
    #10 { stim_a, stim_b, stim_c } = 3'b010;
    #10 { stim_a, stim_b, stim_c } = 3'b011;
    #10 { stim_a, stim_b, stim_c } = 3'b100;
    #10 { stim_a, stim_b, stim_c } = 3'b101;
    #10 { stim_a, stim_b, stim_c } = 3'b110;
    #10 { stim_a, stim_b, stim_c } = 3'b111;

    #10 if( err ) $display( "ERROR in one or more vectors" );
        $stop();
  end

  assign soln = ( ~stim_a & stim_b ) | ( stim_b & stim_c );

  initial begin err = 1'b0; end
  always @( soln ) begin
    if( soln != observe_f )
      err = 1'b1;
    else
      err = err;
  end

endmodule
