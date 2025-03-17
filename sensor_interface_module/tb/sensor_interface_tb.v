
`timescale 1ns / 1ps

module sensor_interface_tb;

    // Testbench Signals
    reg clk;
    reg reset;
    reg vehicle_sensor;
    reg ped_sensor;
    wire vehicle_detected;
    wire ped_detected;

    // Instantiate the DUT (Device Under Test)
    sensor_interface uut (
        .clk(clk),
        .reset(reset),
        .vehicle_sensor(vehicle_sensor),
        .ped_sensor(ped_sensor),
        .vehicle_detected(vehicle_detected),
        .ped_detected(ped_detected)
    );

    // Clock Generation
    always #5 clk = ~clk;  // 10 ns clock period

    // Test Sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        vehicle_sensor = 0;
        ped_sensor = 0;
        
        #10 reset = 0;  // Release reset

        // Test Case 1: No detection
        #10 vehicle_sensor = 0; ped_sensor = 0;
        
        // Test Case 2: Vehicle detected
        #10 vehicle_sensor = 1; ped_sensor = 0;
        
        // Test Case 3: Pedestrian detected
        #10 vehicle_sensor = 0; ped_sensor = 1;
        
        // Test Case 4: Both detected
        #10 vehicle_sensor = 1; ped_sensor = 1;
        
        // Test Case 5: Back to no detection
        #10 vehicle_sensor = 0; ped_sensor = 0;

        // End simulation
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Reset=%b | Veh_Sensor=%b | Ped_Sensor=%b | Veh_Detected=%b | Ped_Detected=%b", 
                  $time, reset, vehicle_sensor, ped_sensor, vehicle_detected, ped_detected);
    end

endmodule

