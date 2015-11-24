initWorld(1500,.01);

%object = initSphereObject(5);
%object = initBoxObject(10,5,2,.5);
%object = initSmartBoxObject(10,5,2,10);
object = initPLYMeshObject('drill.ply');
object = setObjPosition(object,[-.1;-.02;.08]);
object = setObjOrientation(object,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
object = setObjVelocity(object,[0;0;-.01]);
times = [5;10;10.5];
velocities = [0,0,0;
              0,0,.01;
              -.05,-.01,0];
object = addPlan(object,times,velocities);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
addSensor(sensor);

data = simStart(false);