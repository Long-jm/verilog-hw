module size_count_tb;

  reg rst_n, clk;
  wire [31:0] size;
  wire size_valid, data_start;
  wire last;

  wire done;
  wire [33:0] stim;

  size_count DUT (
    .clock( clk ),
    .rst_n( rst_n ),
    .size_valid( size_valid ),
    .size( size ),
    .data_start( data_start ),
    .last( last )
  );

  tb_player #(
    .WIDTH( 34 ),
    .PFILE( "size_count.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clk ),
    .done( done ),
    .play( stim )
  );

  assign { size_valid, data_start, size } = stim;

  initial
  begin
        clk   = 0;
        rst_n = 0;
    #10 rst_n = 1;
  end

  always #5 clk = ~clk;

  initial
  begin
        wait( done );
    #15 $stop;
  end

endmodule
