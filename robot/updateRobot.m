function robot = updateRobot(robot,stepSize,currentStep)

global world

%update position
robot.position = robot.velocity*stepSize+robot.position;

for sensor = 1:length(robot.sensorsID)
    world.sensors{robot.sensorsIndex(sensor)}.position = robot.position + ...
        robot.orientation*robot.sensorsPosition{robot.sensorsIndex(sensor)};
end

%future update orientation and sensors orientation
% %update orientation
% robot.orientation = robot.orientation + matcross(robot.angularVelocity)*...
%     robot.orientation*stepSize;
% 
% %update sensor positions
% for sensor = 1:length(robot.sensorsID)
%     world.sensors{robot.sensorsID(sensor)}.orientation = ...
%         robot.orientation*robot.sensorsOrientation{robot.sensorsID(sensor)};
% end

if robot.planStep < size(robot.plan,1) && ...
        currentStep*stepSize >= robot.plan(robot.planStep+1,1)
    robot.planStep = robot.planStep+1;
    robot.velocity = robot.plan(robot.planStep,2:4)';
end

end