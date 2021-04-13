module acc2max (
  input rst_n, clock,
  input [1:0] in,
  output reg [3:0] acc
);

  wire [4:0] inpacc;
  wire gt15;

  assign inpacc = in + acc;
  assign gt15   = inpacc[4];

  always @( posedge clock ) begin
    if( !rst_n ) begin
      acc <= 0;
    end

    else begin
      if( gt15 ) begin
        acc <= acc;
      end

      else begin
        acc <= in + acc;
      end
    end
  end

endmodule
