module adler32_acc (
  input clk, rst_n,
  input [7:0] data,
  output [31:0] checksum
);

  reg [15:0] Aold, Bold;
  wire [15:0] Anew, Bnew;
  
  localparam Mod = 16'd65521;

  assign Anew = ((Aold + data) > Mod) ? ((Aold + data) - Mod) : (Aold + data);
  assign Bnew = ((Anew + Bold) > Mod) ? ((Anew + Bold) - Mod) : (Anew + Bold);
  assign checksum = {Bold, Aold};

  always @( posedge clk ) begin
    if( !rst_n )
      Aold <= 16'h0001;
    else
      Aold <= Anew;
  end
  
  always @( posedge clk ) begin
    if( !rst_n )
      Bold <= 16'h0000;
    else
      Bold <= Bnew;
  end
   
endmodule
