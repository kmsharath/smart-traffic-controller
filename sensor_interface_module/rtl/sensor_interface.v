module sensor_interface (
    input wire clk,            // System clock
    input wire reset,          // Reset signal
    input wire vehicle_sensor, // Sensor detects vehicle
    input wire ped_sensor,     // Sensor detects pedestrian
    output reg vehicle_detected,
    output reg ped_detected
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            vehicle_detected <= 0;
            ped_detected <= 0;
        end else begin
            vehicle_detected <= vehicle_sensor;
            ped_detected <= ped_sensor;
        end
    end

endmodule

