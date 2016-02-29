function [force, contactLocations] = computeSensorForce(object,sensor)
%this function will compute the force of the individual taxels of sensor
%applied on the object.

%needs to find taxels in contact with object
taxelsInd = find(sensor.taxelsContact(:,1) == object.id);

if isempty(taxelsInd)
    force = [];
    contactLocations = [];
    return
end

%compute applied force per contact (f = xk)
force = zeros(3,length(taxelsInd));
force(3,:) = (sensor.MAXZ - sensor.taxels(taxelsInd,3)')*sensor.springConstant;
%convert force to object frame
%first convert from sensor frame to world frame
force = sensor.orientation*force;
%then convert from world frame to object frame
force = object.orientation'*force;

%compute contact location (in object frame)
%get taxels
cTaxels = sensor.taxels(taxelsInd,:);
%convert to world frame
cTaxels = sensor.orientation*(cTaxels)'+kron(sensor.position,ones(1,size(cTaxels,1)));
%convert to object frame
cTaxels = object.orientation'*(cTaxels-kron(object.position,ones(1,size(cTaxels,2))));
%get direction 
contactLocations = cTaxels - object.shape(sensor.taxelsContact(taxelsInd,2),1:3)';
%get location
contactLocations = contactLocations.*(sensor.RADIUS-kron(object.shape(sensor.taxelsContact(taxelsInd,2),4)',ones(3,1)))/sensor.RADIUS + cTaxels;