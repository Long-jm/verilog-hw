module division_tb;

  reg rst_n, clock;
  wire start, divby0, done;
  wire [31:0] dividend, divisor;
  wire [31:0] quotient, remainder;

  wire [64:0] stim;
  wire tb_done;

  divider DUT (
    .clk( clock ),
    .rst_n( rst_n ),
    .start( start ),
    .div( dividend ),
    .dsr( divisor ),
    .q( quotient ),
    .r( remainder ),
    .err( divby0 ),
    .done( done )
  );

  tb_player #(
    .WIDTH( 65 ),
    .PFILE( "division.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( tb_done ),
    .play( stim )
  );

  assign { start, dividend, divisor } = stim;

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        wait( tb_done );
    #20 $stop;
  end

endmodule
