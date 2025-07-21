// read addr and data line

module read_data(
    input [14:0] address,
    input [7:0] data,
    input read, 						// read signal
    output reg [14:0] R_address, // the address read
    output reg [7:0] R_data      // the data read
);

    always @(posedge read) begin
        R_address <= address;
        R_data <= data;
    end

endmodule
