function object = updateObjectQS(object,stepSize,currentStep)

%static objects do not move (this check maybe should be in the main
%function?
if isfield(object,'static') && object.static
    return
end

%initialize
force = [0;0;0];
torque = [0;0;0];

global world

%compute force and torque from world (eg gravity) (in object frame, centered at cog)
worldForce = computeWorldForce(object);
%TODO: any world torques (gravity does not have one)

if ~isempty(worldForce)
    force = force + worldForce;
end

%compute force and torque from sensors) (in object frame)
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


%compute external force and torque (a.k.a., planned' force) (in object
%frame) (plans are stored in world frame)
%verify step of the plan.
if object.planStep < size(object.plan,1) && currentStep*stepSize >= object.plan(object.planStep+1,1)
    object.planStep = object.planStep+1;
end
%incorporate plan
if object.planStep ~= 0
    force = force + object.orientation'*object.plan(object.planStep,2:4)';
    torque = torque + object.orientation'*object.plan(object.planStep,5:7)';
end

%update velocity
%with Memory
% object.velocity = object.qsForceConstant*object.orientation*force + world.damper*object.velocity;
% object.angularVelocity = object.orientation*object.qsTorqueConstant*torque + world.damper*object.angularVelocity;
%MemoryLess
%object velocity is in world frame
%TODO: Probably should change qsForceConstant to reflect number of taxels
%in contact with the object. (This will 'become' moot if solve all
%components at one time.) (the next line is a possible way to address
%this.)
% object.velocity = 1.7/(size(sensorForce,2)+1)*object.orientation*force;
object.velocity = object.qsForceConstant*object.orientation*force;
% object.angularVelocity = object.orientation*object.qsTorqueConstant*torque;
object.angularVelocity = object.qsTorqueConstant*torque; %in body frame (need to check)
% object.angularVelocity = torque; %in body frame 

%update position
%object position and orientation are in world frame
object.position = object.position + object.velocity*stepSize;
%update orientation
% object.orientation = object.orientation + matcross(object.angularVelocity)*object.orientation*stepSize;
if norm(object.angularVelocity) > 0
    object.orientation = object.orientation * kth2R(object.angularVelocity/norm(object.angularVelocity),...
        norm(object.angularVelocity)*stepSize);
% object.orientation = kth2R(object.angularVelocity/norm(object.angularVelocity),...
%         norm(object.angularVelocity)*stepSize) * object.orientation;
end

% disp('torque:')
% disp(torque);

end