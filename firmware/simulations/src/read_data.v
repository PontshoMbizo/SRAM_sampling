// read addr and data line

module read_data(
    input read,                 // read signal
    input clk,                 //synchronous clock
    input [14:0] address,
    input [7:0] data, 						
    output reg [14:0] R_address, // the output address read
    output reg [7:0] R_data      // the output data read
);

    reg prev_read;

    always @(posedge clk) begin
        prev_read <= read;

        //rising edge detection

        if (read && !prev_read) begin
        R_address <= address;
        R_data <= data;
        end
    end
endmodule
