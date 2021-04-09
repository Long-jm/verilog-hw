module lab_006_acc (
  input rst_n, clock,
  input [3:0] d_in,
  output reg [7:0] d_out
);

  always @( posedge clock ) begin
    if( !rst_n )
      d_out <= 0;
    else if( d_in > 4'b0110 )
      d_out <= d_out + d_in;
    else
      d_out <= d_out;
  end

endmodule
