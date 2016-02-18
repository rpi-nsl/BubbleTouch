initWorld(1000,.01);

object = initPLYMeshObject('cup.ply');
object = setObjPosition(object,[0.015;-0.01;0.11]);
object = setObjOrientation(object,kth2R([0,1,0],pi));
object = setObjVelocity(object,[0;0;-.01]);
times = [1.2;3];
velocities = [0,0,0;
              -.01,.005,0];
object = addPlan(object,times,velocities);
addObject(object);

% sensor = initRectangularSensor(64,64,.0025,0,.02);
sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(false);

save('data/cup100.mat','data');