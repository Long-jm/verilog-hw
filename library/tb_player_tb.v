module tb_player_tb;

  reg rst_n, clock;
  wire [3:0] play;

  tb_player DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .play( play )
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #50 rst_n = 1;
  end

  initial
    #5000 $stop();

endmodule
