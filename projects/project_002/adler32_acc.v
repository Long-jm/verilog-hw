module adler32_acc (
  input rst_n, clock, data_start,
  input [7:0] data,
  output [31:0] checksum
);

  reg [15:0] Aold, Bold;
  wire [15:0] Anew, Bnew;
  
  localparam Mod = 16'd65521;

  assign Anew = ((Aold + data) > Mod) ? ((Aold + data) - Mod) : (Aold + data);
  assign Bnew = ((Anew + Bold) > Mod) ? ((Anew + Bold) - Mod) : (Anew + Bold);
  assign checksum = {Bold, Aold};

  always @( posedge clock ) begin
    if( !rst_n || data_start)
      Aold <= 16'h0001;
    else
      Aold <= Anew;
  end
  
  always @( posedge clock ) begin
    if( !rst_n || data_start)
      Bold <= 16'h0000;
    else
      Bold <= Bnew;
  end
   
endmodule
