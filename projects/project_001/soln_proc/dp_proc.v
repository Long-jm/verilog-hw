module dp_proc (
  input rst_n, clock,
  input [3:0] d_in,
  input capture,
  input [1:0] op,
  input clear,
  output reg [4:0] result
);

  always @( posedge clock )
    if( !rst_n )
      result <= 0;
    else
      if( clear )
        result <= 0;
      else
        if( capture )
          case( op )
            2'b00 : result <= result + d_in;
            2'b01 : result <= result + d_in;
            2'b10 : result <= result - d_in;
            2'b11 : result <= result - d_in;
            default : result <= result;
          endcase
        else
          result <= result;

endmodule
