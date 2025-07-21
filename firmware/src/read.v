module read(
    input wire E,            // Chip Enable (active low)
    input wire O,            // Output Enable (active low)
    input wire [3:0] counter, // Counter value
    output reg read          // Output signal to indicate read mode
);    
    always @(*) begin
        if (~E && ~O && counter >= 4'd14) begin
            read <= 1;
        end 
		  else begin
            read <= 0;
        end
    end
endmodule
