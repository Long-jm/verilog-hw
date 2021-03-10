module Sub_tb;

  reg A, B, Bin;
  wire D, Bout;

  Sub DUT (
    A, B, Bin, D, Bout
  );

  initial begin
    $display( $time, ": A B | D Bout" );
    $display( $time, ": ----=-------" );
    $monitor( $time, ": %1b - %1b = %1b, %1b", A, B, D, Bout );
  end

  initial begin
        { Bin, A, B } = 3'b000;
    #10 { Bin, A, B } = 3'b001;
    #10 { Bin, A, B } = 3'b010;
    #10 { Bin, A, B } = 3'b011;
    #10 { Bin, A, B } = 3'b100;
    #10 { Bin, A, B } = 3'b101;
    #10 { Bin, A, B } = 3'b110;
    #10 { Bin, A, B } = 3'b111;
    #10 $stop();
  end

endmodule

