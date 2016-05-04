function id = addRobot(robot)

global world

%determine where to add robot
id = length(world.robots)+1;

%add all sensors to world
for sensor = 1:length(robot.sensors)
    robot.sensors{sensor}.position = robot.position + ...
        robot.orientation*robot.sensorsPosition{sensor};
    robot.sensors{sensor}.orientation = robot.orientation*robot.sensorsOrientation{sensor};
    robot.sensorsID(sensor) = addSensor(robot.sensors{sensor});
end

%add robot
world.robots{id} = robot;

%update robot's id
if id > 1
    world.robots{id}.id = world.robots{id-1}.id+1;
else
    world.robots{id}.id = id;
end

id = world.robots{id}.id;

end