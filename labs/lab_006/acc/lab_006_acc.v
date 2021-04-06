module lab_006_acc (
  input rst_n, clock,
  input [3:0] d_in,
  output reg [7:0] d_out
);

  always @( posedge clock ) begin
    if( !rst_n ) begin
      d_out <= 0;
    end
    
    // fill out the rest

  end

endmodule
