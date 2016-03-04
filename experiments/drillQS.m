numSteps = 100; timestep = 0.01;
initWorld(numSteps,timestep);
setWorldDamper(.9);
setGravity([0;0;-1]);
setRecordOn(filename);

object = initPLYMeshObject('drill.ply');
object = setObjPosition(object,[-.1;-.02;.05]);
object = setObjOrientation(object,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
object = setObjQSForceConstant(object,.1);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
% sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(true);

% save('data/drill100.mat','data');