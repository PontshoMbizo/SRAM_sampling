//

module timer_5ns(

	input clk_200,
	input reset,
	output reg [3:0] count
);

//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================

always @(posedge clk_200) begin
    if (reset)
        count <= 0;
    else if (count == 4'b1111)
        count <= 0;
    else
        count <= count + 1;
end
endmodule