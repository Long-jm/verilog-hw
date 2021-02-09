module lab_003_parta_tb;

  reg A, B, C;
  wire G;

  lab_003_parta DUT (
    A, B, C, G
  );

  initial begin
    $display( $time, ": A B C | G" );
    $display( $time, ": ------+--" );
    $monitor( $time, ": %b %b %b | %b", A, B, C, G );
  end

  initial begin
        { A, B, C } = 3'b000;
    #10 { A, B, C } = 3'b001;
    #10 { A, B, C } = 3'b010;
    #10 { A, B, C } = 3'b011;
    #10 { A, B, C } = 3'b100;
    #10 { A, B, C } = 3'b101;
    #10 { A, B, C } = 3'b110;
    #10 { A, B, C } = 3'b111;
    #10 $stop();
  end

endmodule

module lab_003_partb_tb;

  reg G, D;
  wire F;

  lab_003_partb DUT (
    G, D, F
  );

  initial begin
    $display( $time, ": G D | F" );
    $display( $time, ": ----+--" );
    $monitor( $time, ": %b %b | %b", G, D, F );
  end

  initial begin
        { G, D } = 2'b00;
    #10 { G, D } = 2'b01;
    #10 { G, D } = 2'b10;
    #10 { G, D } = 2'b11;
    #10 $stop();
  end

endmodule

module lab_003_partc_tb;

  reg A, B, C, D;
  wire F;

  lab_003_partc DUT (
    A, B, C, D, F
  );

  initial begin
    $display( $time, ": A B C D | F" );
    $display( $time, ": --------+--" );
    $monitor( $time, ": %b %b %b %b | %b", A, B, C, D, F );
  end

  initial begin
        { A, B, C, D } = 4'b0000;
    #10 { A, B, C, D } = 4'b0001;
    #10 { A, B, C, D } = 4'b0010;
    #10 { A, B, C, D } = 4'b0011;
    #10 { A, B, C, D } = 4'b0100;
    #10 { A, B, C, D } = 4'b0101;
    #10 { A, B, C, D } = 4'b0110;
    #10 { A, B, C, D } = 4'b0111;
    #10 { A, B, C, D } = 4'b1000;
    #10 { A, B, C, D } = 4'b1001;
    #10 { A, B, C, D } = 4'b1010;
    #10 { A, B, C, D } = 4'b1011;
    #10 { A, B, C, D } = 4'b1100;
    #10 { A, B, C, D } = 4'b1101;
    #10 { A, B, C, D } = 4'b1110;
    #10 { A, B, C, D } = 4'b1111;
    #10 $stop();
  end

endmodule

