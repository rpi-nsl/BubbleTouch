initWorld(100,.01);
setGravity([0;0;-1]);


object = initBoxObject(.10,.05,.02,.005);
object = setObjPosition(object,[0;0;.04]);
 object = setObjOrientation(object,kth2R([0,1,0],pi/20));
% object = setObjVelocity(object,[0;0;-.01]);
object = setObjQSForceConstant(object,.1);
addObject(object);

sensor = initRectangularSensor(64,64,.0025,0,.02);
% sensor = initRectangularSensor(100,100,.0015,0,.02);
addSensor(sensor);

data = simStart(true);


% save('data/box100.mat','data');