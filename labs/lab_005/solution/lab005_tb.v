module lab005_tb;

  // tb player output
  wire [2:0] stim;

  // stimulus for the DUT
  wire capture;
  wire [1:0] op;

  // testbench signals
  reg rst_n, clock;

  // DUT outputs
  wire full;

  // free-running clock
  initial clock = 0;
  always #5 clock = ~clock;

  // global initial reset
  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  lab005 DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .op( op ),
    .capture( capture ),
    .full( full )
  );

  tb_player #(
    .WIDTH( 3 ),
    .PFILE( "single_op.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .play( stim )
  );

  // extract inputs from stimulus
  assign { capture, op } = stim;

  // allow simulation to run
  initial
    #280 $stop;

endmodule
