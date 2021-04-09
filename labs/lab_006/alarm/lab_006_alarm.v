module lab_006_alarm (
  input alarm_set, alarm_stay,
  input [1:0] doors,
  input [2:0] windows,
  output reg secure, alarm
);

  always @* begin
    if( alarm_set ) begin
      if ( alarm_stay && (windows || doors) ) begin
        secure = 0;
	alarm = 1;
      end
      else if ( windows ) begin
	secure = 0;
	alarm = 1;
      end
      else begin
	secure = 1;
	alarm = 0;
      end
    end
    else begin
      secure = 0;
      alarm = 0;
    end
  end

endmodule
