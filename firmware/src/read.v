module read(
    input wire E,            // Chip Enable
    input wire O,            // Output Enable
    input wire [3:0] counter, // timing value
    output reg read          // Output signal to indicate read mode
);    
    always @(*) begin
        if (~E && ~O && counter >= 4'd12) begin // Check if chip is enabled and counter is at least 12
            read <= 1;
        end 
		  else begin
            read <= 0;
        end
    end
endmodule
