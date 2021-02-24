module fa_tb;

  reg Cin, A, B;
  wire Cout, Sum;
	
  fa DUT (
    Cin, A, B, Cout, Sum
  );

  initial begin
    $display( $time, ": Cin A B | Cout Sum" );
    $display( $time, ": ------+----" );
    $monitor( $time, ": %b %b %b | %b %b", Cin, A, B, Cout, Sum );
  end

  initial begin 
        { Cin, A, B } = 3'b000;
    #10 { Cin, A, B } = 3'b001;
    #10 { Cin, A, B } = 3'b010;
    #10 { Cin, A, B } = 3'b011;
    #10 { Cin, A, B } = 3'b100;
    #10 { Cin, A, B } = 3'b101;
    #10 { Cin, A, B } = 3'b110;
    #10 { Cin, A, B } = 3'b111;
    #10 $stop();
  end

endmodule
