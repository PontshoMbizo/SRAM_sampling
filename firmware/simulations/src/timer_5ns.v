//4-bit counter block

module timer_5ns(

	input clk, //200MHz clock
	input reset, //reset signal
	output reg [3:0] count // 4-bit counter output (timer value)
);

initial count = 0; //for simulation purposes

always @(posedge clk) begin
    if (reset)
        count <= 0;
    else if (count == 4'b1111)
        count <= 0;
    else
        count <= count + 1;
end
endmodule