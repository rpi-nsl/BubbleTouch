function robot = convertToGPURobot(robot)

robot.position = gpuArray(robot.position);
robot.orientation = gpuArray(robot.orientation);
robot.velocity = gpuArray(robot.velocity);
robot.angularVelocity = gpuArray(robot.angularVelocity);

for sensor_id = 1:length(robot.sensors)
    robot.sensors{sensor_id} = convertToGPUSensor(robot.sensors{sensor_id});
    robot.sensorsPosition{sensor_id} = gpuArray(robot.sensorsPosition{sensor_id});
    robot.sensorsOrientation{sensor_id} = gpuArray(robot.sensorsOrientation{sensor_id});
end

end