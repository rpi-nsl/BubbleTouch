initWorld(1000,.01);

object = initSphereObject(.005);
%object = initBoxObject(10,5,2,.5);
%object = initSmartBoxObject(10,5,2,10);
%object = initPLYMeshObject('drill.ply');
object = setObjPosition(object,[-.1;-.02;.04]);
object = setObjOrientation(object,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
object = setObjVelocity(object,[0;0;-.01]);
% times = [2;sort(rand(40,1)*8+2)];
% velocities = [0,0,0;
%               (rand(40,2)-.5)*.1,zeros(40,1)];
object = addPlan(object,times,velocities);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
addSensor(sensor);

data = simStart(false);