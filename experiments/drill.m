initWorld(1000,.01);

object = initPLYMeshObject('drill.ply');
object = setObjPosition(object,[-.1;-.02;.05]);
object = setObjOrientation(object,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
object = setObjVelocity(object,[0;0;-.01]);
times = [1.5;3];
velocities = [0,0,0;
              -.01,.005,0];
object = addPlan(object,times,velocities);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
% sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(true);

% save('data/drill100.mat','data');