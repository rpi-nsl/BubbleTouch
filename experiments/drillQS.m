filename = 'drill_test';

numSteps = 100; timestep = 0.01;
initWorld(numSteps,timestep);
setWorldDamper(0);
setWorldGraphicsResolution(5);
setGravity([0;0;-9.8]);
setRecordOn(filename);
setRecordOff

% object = initPLYMeshObject('drill.ply');
% object = setObjPosition(object,[-.1;-.02;.04]);
% object = setObjOrientation(object,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
% % object = setObjQSForceConstant(object,.1);
% object = setObjMass(object,.858);
% object = computeObjInertiaTensor(object);
% object = computeObjQSConstants(object,timestep);
object = defaultDrill;
object = setObjPosition(object,[0;0;.08]);
object = computeObjInertiaTensor(object);
object = computeObjQSConstants(object,timestep);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
sensor = computeSensorSpringConstant(sensor,9/5.09*10000); %CellulARSkin
% sensor = computeSensorSpringConstant(sensor,4.46*9.8*10000); %Ri-Man
% sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(true);

% save('data/drill100.mat','data');