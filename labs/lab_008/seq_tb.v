module seq_tb;

  reg rst_n, clock, d_in;
  wire found;

  initial begin clock = 0; 
end
  always #5 clock = ~clock;

  initial begin
        rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  lab8_seq_101 DUT (
    rst_n, clock, d_in, found
  );

  initial begin
    $display( $time, ": d_in | found" );
    $display( $time, ": -----------=>----" );
    $monitor( $time, ":  %1b | %1b", d_in, found);
  end

  initial begin
        { d_in } = 1'b0;
    #15 { d_in } = 1'b0;

    #10 { d_in } = 1'b1;
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b1;
    #10 { d_in } = 1'b1;
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b1;
    
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b0;

    #10 { d_in } = 1'b1;
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b1;
    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b1;

    #10 { d_in } = 1'b0;
    #10 { d_in } = 1'b0;
    #10 $stop();
  end

endmodule

