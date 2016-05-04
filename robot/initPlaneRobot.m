function robot = initPlaneRobot(sizeX,sizeY,elementRadius,minZ,maxZ)
%a robot is just a collection of rigidily linked sensors and the ability to
%move (aka a plan).  technically joints/links should be added to allow
%robots to have multiple joints or links

%id is a way of distinguishing different robots
robot.id = 0; %zero indicates not added to world

%
robot.position = [0;0;0];
robot.orientation = [1,0,0;
                     0,1,0;
                     0,0,1];
robot.velocity = [0;0;0];
robot.angularVelocity = [0;0;0];

%plan is a set of times (timestep t) when the velocity changes and the new
%velocities (v) (may change to force)
robot.plan = [];
%The current step of the plan being executed
robot.planStep = 0;

%sensors and relative positions and orientations
%a robot has S sensors.
robot.sensors{1} = initRectangularSensor(sizeX,sizeY,elementRadius,minZ,maxZ);
robot.sensorsID = zeros(size(robot.sensors));
robot.sensorsIndex = zeros(size(robot.sensors));
%sensorsPosition is a cell array of position vectors of the sensors in the
%robot's frame
robot.sensorsPosition{1} = [0;0;0];
%sensorsOrientation is a cell array of orienation matrices of the sensors
%in the robot's frame (thus in a vector v in sensor frame is R*v to
%transfer to robot frame).
robot.sensorsOrientation{1} = eye(3);