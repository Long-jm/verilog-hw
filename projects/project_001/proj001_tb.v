module proj001_tb;

  // tb player output
  wire [6:0] stim;

  // stimulus for the DUT
  wire capture;
  wire [3:0] d_in;
  wire [1:0] op;

  // testbench signals
  reg rst_n, clock;

  // DUT outputs
  wire [4:0] result;
  wire valid;

  // free-running clock
  initial clock = 0;
  always #5 clock = ~clock;

  // global initial reset
  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  proj001 DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .op( op ),
    .capture( capture ),
    .result( result ),
    .valid( valid )
  );

  tb_player #(
    .WIDTH( 7 ),
    .PFILE( "single_op.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .play( stim )
  );

  // extract inputs from stimulus
  assign { capture, op, d_in } = stim;

  // allow simulation to run
  initial begin
    $display( $time, ": capture op d_in | valid result" );
    $display( $time, ": ----------=>-----" );
    $monitor( $time, ": %1b %2b %2d => %1b %2d", capture, op, d_in, valid, result);
  end

  initial
    #800 $stop;

endmodule
