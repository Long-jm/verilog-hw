
module decoder (
  input rst_n, clock, capture,
  input [1:0] op,
  input [3:0] d_in,
  output reg [3:0] A, B, C, D
);
  
  wire [3:0] Ap, Bp, Cp, Dp;  

  always @(capture) begin
    case(op)
      2'b00: begin  A = (capture) ? d_in: Ap;  end
      2'b01: begin  B = (capture) ? d_in: Bp;  end
      2'b10: begin  C = (capture) ? d_in: Cp;  end
      2'b11: begin  D = (capture) ? d_in: Dp;  end
    endcase
  end

  dff4bit A_inst ( rst_n, clock, A, Ap );
  dff4bit B_sint ( rst_n, clock, B, Bp );
  dff4bit C_inst ( rst_n, clock, C, Cp );
  dff4bit D_inst ( rst_n, clock, D, Dp );

endmodule