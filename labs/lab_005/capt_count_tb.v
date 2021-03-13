module capt_count_tb;

  reg rst_n, clock, capture;
  reg [1:0] op;
  wire full;

  initial begin clock = 0; 
end
  always #5 clock = ~clock;

  initial begin
        rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  capt_count DUT (
    rst_n, clock, capture, op, full
  );

  initial begin
    $display( $time, ": op capture | full" );
    $display( $time, ": -----------=>----" );
    $monitor( $time, ": %2b   %1b   =>   %1b", op, capture, full);
  end

  initial begin
        { op, capture } = 3'b00_0;
    #15 { op, capture } = 3'b00_1;
    #10 { op, capture } = 3'b01_1;
    #10 { op, capture } = 3'b10_1;
    #10 { op, capture } = 3'b11_1;
    #10 { op, capture } = 3'b00_0;

    #10 { op, capture } = 3'b10_1;
    #10 { op, capture } = 3'b01_1;
    #10 { op, capture } = 3'b11_1;
    #10 { op, capture } = 3'b00_1;

    #10 { op, capture } = 3'b11_1;
    #10 { op, capture } = 3'b10_1;
    #10 { op, capture } = 3'b11_0;
    #10 { op, capture } = 3'b01_1;
    #10 { op, capture } = 3'b10_0;
    #10 { op, capture } = 3'b00_1;
    #10 { op, capture } = 3'b10_0;

    #10 $stop();
  end

endmodule

