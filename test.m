initWorld(1500,.01);

object = initSphereObject(5);
object = setObjPosition(object,[0;0;10]);
%object = setObjVelocity(object,[0;0;-1]);
times = [0;5;10;11.5];
velocities = [0,0,-1;
              0,0,0;
              0,0,1;
              -.5,-1,0];
object = addPlan(object,times,velocities);
addObject(object);

sensor = initRectangularSensor(10,10,1,0,2);
addSensor(sensor);

simStart();