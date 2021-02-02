module mux21_tb ();

  reg stim_a;
  reg stim_b;
  reg stim_s;
  wire observe_f;

  mux21 DUT (
    .S( stim_s ),
    .A( stim_a ),
    .B( stim_b ),
    .F( observe_f )
  );

  initial
  begin
    $display( $time, ": S A B | F" );
    $display( $time, ": ------+--" );
    $monitor( $time, ": %b %b %b | %b", stim_s, stim_a, stim_b, observe_f );
  end

  initial
  begin
        { stim_s, stim_a, stim_b } = 3'b000;
    #10 { stim_s, stim_a, stim_b } = 3'b001;
    #10 { stim_s, stim_a, stim_b } = 3'b010;
    #10 { stim_s, stim_a, stim_b } = 3'b011;
    #10 { stim_s, stim_a, stim_b } = 3'b100;
    #10 { stim_s, stim_a, stim_b } = 3'b101;
    #10 { stim_s, stim_a, stim_b } = 3'b110;
    #10 { stim_s, stim_a, stim_b } = 3'b111;
    #10 $stop();
  end

endmodule
