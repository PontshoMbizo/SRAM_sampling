//4-bit counter block

module timer_5ns(

	input clk,
	input reset,
	output reg [3:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 0;
    else if (count == 4'b1111)
        count <= 0;
    else
        count <= count + 1;
end
endmodule