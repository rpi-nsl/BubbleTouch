filename = 'cupQSWithHalfMemoryg9_8';

numSteps = 100; timestep = 0.01;
initWorld(numSteps,timestep);
setWorldDamper(0);
setGravity([0;0;-9.8]);
setRecordOn(filename);

object = initPLYMeshObject('cup.ply');
object = setObjPosition(object,[0.015;-0.01;0.11]);
object = setObjOrientation(object,kth2R([0,1,0],pi));
object = setObjMass(object,.038);
object = computeObjInertiaTensor(object);
object = computeObjQSConstants(object,timestep);
addObject(object);


sensor = initRectangularSensor(64,64,.0025,0,.02);
sensor = computeSensorSpringConstant(sensor,9/5.09*10000); %CellulARSkin
% sensor = computeSensorSpringConstant(sensor,4.46*9.8*10000); %Ri-Man
% sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(true);

% save(strcat('data/',filename,'.mat'),'data');
