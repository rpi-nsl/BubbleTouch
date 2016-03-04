function object = updateObjectQS(object,stepSize,currentStep)

%initialize
force = [0;0;0];
torque = [0;0;0];

global world

%compute force and torque from world (eg gravity)
worldForce = computeWorldForce(object);
%TODO: any world torques (gravity does not have one)

if ~isempty(worldForce)
    force = force + worldForce;
end

%compute force and torque from sensors)
for sen = 1:length(world.sensors)
    %compute from sensor
    [sensorForce,locations] = computeSensorForce(object,world.sensors{sen});
    %make sure there is some force
    if isempty(sensorForce)
        continue;
    end
    %add to total force
    force = force + sum(sensorForce,2);
    
    %TODO: torque
    torqueRadii = locations-kron(object.cog,ones(1,size(locations,2)));
    sensorTorque = cross(torqueRadii,sensorForce);
    torque = torque + sum(sensorTorque,2);
end

%compute force and torque from other objects
%TODO: force
%TODO: torque


%compute external force and torque
%TODO: force
%TODO: torque

%update velocity
%with Memory
object.velocity = object.qsForceConstant*object.orientation*force + world.damper*object.velocity;
object.angularVelocity = object.orientation*object.qsTorqueConstant*torque + world.damper*object.angularVelocity;
%MemoryLess
%object.velocity = object.qsForceConstant*object.orientation*force;
%object.angularVelocity = object.orientation*object.qsTorqueConstant*torque;

%update position
object.position = object.position + object.velocity*stepSize;
%update orientation
object.orientation = object.orientation + matcross(object.angularVelocity)*object.orientation*stepSize;

% disp('torque:')
% disp(torque);

end