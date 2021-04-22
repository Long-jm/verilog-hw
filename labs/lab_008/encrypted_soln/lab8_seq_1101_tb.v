module lab8_seq_1101_tb;

  reg rst_n, clock;
  wire d_in;
  wire found;

  wire done;

  lab8_seq_1101 DUT_1101 (
    .clock( clock ),
    .rst_n( rst_n ),
    .d_in( d_in ),
    .found( found )
  );

  tb_player #(
    .WIDTH( 1 ),
    .PFILE( "lab8_seq.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .clock( clock ),
    .rst_n( rst_n ),
    .done( done ),
    .play( d_in )
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        wait( done );
    #10 $stop();
  end

endmodule
