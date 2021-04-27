module controller (
  input clk, rst_n,
  input start,
  output reg done,

  output reg clr_q,
  output reg inc_q,
  output reg clr_r,
  output reg ld_r,
  output reg dec_r,
  output reg ld_div,
  output reg ld_dsr,
  output reg ld_err,
  output reg clr_err,
  input err,
  input rltdsr
);

  parameter S0   = 3'd0;
  parameter S1   = 3'd1;
  parameter S2   = 3'd2;
  parameter S3   = 3'd3;
  parameter DONE = 3'd4;

  reg [2:0] cstate, nstate;

  // sequential part
  always @( posedge clk )
    if( !rst_n )
      cstate <= S0;
    else
      cstate <= nstate;

  // combinational part
  always @* begin

    // defaults
    done    <= 0;
    clr_q   <= 0;
    inc_q   <= 0;
    clr_r   <= 0;
    ld_r    <= 0;
    dec_r   <= 0;
    ld_div  <= 0;
    ld_dsr  <= 0;
    ld_err  <= 0;
    clr_err <= 0;

    case( cstate )

      S0 : begin
        if( start ) begin
          ld_div  <= 1;
          ld_dsr  <= 1;
          ld_err  <= 1;
          nstate  <= S1;
        end
        else begin
          ld_div  <= 0;
          ld_dsr  <= 0;
          ld_err  <= 0;
          nstate  <= S0;
        end
      end

      S1 : begin
        clr_q  <= 1;
        ld_r   <= 1;

        if( err ) begin
          clr_r  <= 1;
          nstate <= DONE;
        end
        else begin
          clr_r  <= 0;
          nstate <= S2;
        end
      end

      S2 : begin
        if( rltdsr )
          nstate <= DONE;
        else
          nstate <= S3;
      end

      S3 : begin
        if( rltdsr ) begin
          dec_r  <= 0;
          inc_q  <= 0;
          nstate <= DONE;
        end
        else begin
          dec_r  <= 1;
          inc_q  <= 1;
          nstate <= S3;
        end
      end

      DONE : begin
        done    <= 1;
        nstate  <= S0;
      end
      
      default : begin
        nstate <= S0;
      end
    endcase

  end

endmodule
