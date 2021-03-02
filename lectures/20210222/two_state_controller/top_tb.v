module top_tb;

  reg rst_n, clock;
  reg [3:0] A;
  reg capture;
  wire [7:0] F;
  wire valid;
  wire [4:0] stim;

  /* free-running clock */
  initial begin clock = 0; end
  always #5 clock = ~clock;

  /* active low reset */
  initial begin
        rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  /* instantiate the DUT */
  top DUT (
    .rst_n  ( rst_n   ),
    .clock  ( clock   ),
    .capture( capture ),
    .A      ( A       ),
    .F      ( F       ),
    .valid  ( valid   )
  );

  tb_player #(
    .WIDTH      ( 5            ),
    .PFILE      ( "top_tb.dat" ),
    .RAND_DELAY ( 0            ),
    .RAND_MIN   ( 0            ),
    .RAND_MAX   ( 10           )
  ) player (
    .rst_n ( rst_n ),
    .clock ( clock ),
    .play  ( stim  )
  );

  always @*
    { capture, A } <= stim;

  initial begin
    #500 $stop();
  end

endmodule
