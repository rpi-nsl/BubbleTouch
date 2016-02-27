function force = computeSensorForce(object,sensor)
%this function will compute the force of the individual taxels of sensor
%applied on the object.

%needs to find taxels in contact with object
%compute applied force per contact (f = xk)
%compute contact location (in object frame)