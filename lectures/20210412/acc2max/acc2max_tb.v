module acc2max_tb;

  reg rst_n, clock;
  wire [1:0] in;
  wire [3:0] acc;

  wire done;

  acc2max DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .in( in ),
    .acc( acc )
  );

  tb_player #(
    .WIDTH( 2 ),
    .PFILE( "acc2max.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( in )
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        wait( done );
    #15 $stop();
  end

endmodule
