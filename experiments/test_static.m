%% World
numSteps = 200; timestep = 0.01;
initWorld(numSteps,timestep);

%% Object
%object
object = defaultDrill; 
object = setObjectStatic(object);
addObject(object);

%% Robot
objShape = object.orientation*(object.shape(:,1:3))';
maxObjHeight = max(objShape(3,:)+object.shape(:,4)')+object.position(3);
robot = initPlaneRobot(64,64,.002,0,.02);
robot = setRobotPosition(robot,[0;0;maxObjHeight+.022 - .01*.01*rand]);
robot = setRobotOrientation(robot,kth2R([1;0;0],pi));
times = [0];
velocities = [0,0,-.01];
robot = addRobotPlan(robot,times,velocities);
addRobot(robot);

%start experiment
data = simStart(false);

        
