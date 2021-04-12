module adler32_acc_hello_tb();

  reg rst_n, clk;
  reg [7:0] data;
  wire [31:0] checksum;

  wire done;
  wire [7:0] stim;

  always #5 clk = ~clk;

  adler32_acc DUT (
    .rst_n( rst_n ),
    .clk( clk ),
    .data( data ),
    .checksum( checksum )
  );

  tb_player #(
    .WIDTH( 8 ),
    .PFILE( "hello.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clk ),
    .done( done ),
    .play( stim )
  );

  assign data = stim;

  initial
  begin
        clk   = 0;
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial
  begin
    $monitor( $time, ": checksum is 32'h%08x", checksum );
    wait( done );
    #15 $stop;
  end

  always @( posedge clk )
    if( done )
      if( checksum == 32'h058c01f5 )
        $display( "SUCCESS: checksum matches" );
      else
        $display( "ERROR: checksums don't match" );

endmodule
