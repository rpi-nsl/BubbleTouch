
%% Initialize World
clearWorld;
numSteps = 20;%total number of simulation steps
timestep = 0.05;%time interval for each step
sampleRate = 0.05;%sampling rate
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5); %resolution for display


%% Specify the Object
object = defaultDrill;%the drill model is preprocessed as a pointcloud
RObj = getObjOrientation(object);%get object's initial orientation
rotationMatrix = kth2R([0;0;1],rotationAngle*pi/180);%define a desired rotation matrix
object = setObjOrientation(object,rotationMatrix*RObj); %rotate the object
object = setObjPosition(object,[0.001*translationX;0.001*translationY;0.027]); %translate the object
%object = setObjMass(object,masses(comb_iter)); %object mass is not required in kinematic simmulation
object = setObjectStatic(object);
addObject(object);

%% Setup Sensor and Robot
objShape = object.orientation*(object.shape(:,1:3))';
maxObjHeight = max(objShape(3,:)+object.shape(:,4)')+object.position(3);
%Initialize a 64 by 64 sensor array attached to the robot.
%Function arguments are sizeX, sizeY, elementRadius, minZ, maxZ
%These variables define a sensor array.
%sizeX and sizeY specify the dimension of the sensor.
%elementRadius defines the sphere model of the contact point.
%minZ and maxZ set the minimum/maximum deformation of all texals.
robot = initPlaneRobot(64,64,.002,0,.02); 
robot = setRobotPosition(robot,[0;0;maxObjHeight+.022]);
robot = setRobotOrientation(robot,kth2R([1;0;0],pi));  
%critical times to change velocities
times = [0,0.35,0.65]';
%velocities: rows - spatial and rotational velocities at each critical time; 
%columns - vx,vy,vz,wx,wy,wz
velocities = [0,0,-.02,0,0,0; %translate down on z-axis
              0,0.1,-.02,0,0,0;%translate down on z-axis, translate up on y axis
              0,-0.1,-.02,0,0,0];%translate down on z-axis, translate down on y axis
robot = addRobotPlan(robot,times,velocities);
addRobot(robot);

%% Start Experiment
% setRecordOff;
setRecordOn('example');%video will be saved as "example.avi" in the "data" folder
data = simStart(true);
