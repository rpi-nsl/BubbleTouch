filename = 'boxQSMemoryLessg9_8';

numSteps = 100; timestep = 0.01;
initWorld(numSteps,timestep);
setWorldDamper(0);
setGravity([0;0;-9.8]);
setRecordOn(filename);


object = initBoxObject(.10,.05,.02,.005);
object = setObjPosition(object,[0;0;.04]);
 object = setObjOrientation(object,kth2R([0,1,0],pi/20));
% object = setObjVelocity(object,[0;0;-.01]);
% object = setObjQSForceConstant(object,.1);
object = computeObjQSConstants(object,timestep);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
% sensor = initRectangularSensor(100,100,.0015,0,.02);

%from riman, max sensor pressure = 4.46kgf/cm^2
sensor = computeSensorSpringConstant(sensor,4.46*9.8*10000);
sensor = setSensorSpringConstant(sensor,.1*sensor.springConstant);
addSensor(sensor);

data = simStart(true);


save(strcat('data/',filename,'.mat'),'data');