initWorld(1500,.01);

%object = initSphereObject(5);
%object = initBoxObject(10,5,2,.5);
%object = initSmartBoxObject(10,5,2,10);
object = initPLYMeshObject('drill.ply');
object = setObjPosition(object,[0;0;.5]);
object = setObjOrientationAxisAngle(object,[1,0,0],pi/2);
%object = setObjVelocity(object,[0;0;-1]);
times = [0;5;10;10.5];
velocities = [0,0,-.1;
              0,0,0;
              0,0,.01;
              -.05,-.1,0];
object = addPlan(object,times,velocities);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.01);
addSensor(sensor);

data = simStart(false);